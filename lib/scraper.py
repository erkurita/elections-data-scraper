#!/usr/bin/python

#
# This file is part of elections-data-scraper.
# 
# elections-data-scraper is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# elections-data-scraper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with elections-data-scraper.  If not, see <http://www.gnu.org/licenses/>.
# 

import csv, re,  os
from directories import Directory
from uniwriter import UnicodeWriter
from options_parser import Parser
from os import path

#
# The following snippet of code has been copied from 
# http://lxml.de/tutorial.html
#
# I claim no copyright whatsoever for this code.
#

try:
  from lxml import etree
  print("running with lxml.etree")
except ImportError:
  try:
    # Python 2.5
    import xml.etree.cElementTree as etree
    print("running with cElementTree on Python 2.5+")
  except ImportError:
    try:
      # Python 2.5
      import xml.etree.ElementTree as etree
      print("running with ElementTree on Python 2.5+")
    except ImportError:
      try:
        # normal cElementTree install
        import cElementTree as etree
        print("running with cElementTree")
      except ImportError:
        try:
          # normal ElementTree install
          import elementtree.ElementTree as etree
          print("running with ElementTree")
        except ImportError:
          raise ImportError("Failed to import ElementTree from any known place, needed for the script to operate")
#
# End of snippet
#

HTML_RESULTS_ID = ".//div[@id='resultDiv.21']"



class Scraper:
    """
    Escanea los HTMLs de los resultados y vuelca los datos en un soporte especifico
    """
    def __init__(self,arg_options = None):
        self.opcodes = ['codigos','partidos','candidatos']
        # Which CSV to generate
        self.options = {
            'codigos'    : self.do_scrape_codigos,
            'candidatos' : self.do_scrape_candidatos,
            'partidos'   : self.do_scrape_partidos
        }
        # Headers of the CSV files
        self.headers = {
            'codigos'       : ['estado', 'municipio', 'parroquia', 'centro', 'mesa', 'ubicacion'                        ],
            'candidatos'    : ['estado', 'municipio', 'parroquia', 'centro', 'mesa', 'candidato', 'votos', 'porcentaje' ],
            'partidos'      : ['estado', 'municipio', 'parroquia', 'centro', 'mesa', 'partido',   'votos', 'porcentaje' ]
        }
        self.headers_written = {
            'codigos'       : False,
            'candidatos'    : False,
            'partidos'      : False
        }
        # Filenames
        self.filenames = {
            'codigos'       : 'elecciones_codigos.csv',
            'candidatos'    : 'elecciones_candidatos.csv',
            'partidos'      : 'elecciones_partidos.csv'
        }
        # Length of the code for padding
        self.code_length = {
            6  : '0'*6,
            9  : '0'*3,
            12 : ''
        }

        if arg_options != None:
            self.set_options(arg_options)
    
    ##
    # @param options: Argumentos del programa
    #
    def set_options(self,options):
        self.arg_options    = options
        
        self.do_candidatos  = options.no_candidatos
        self.do_partidos    = options.no_partidos
        self.do_codigos     = options.no_codigos
        self.directory      = options.path
        
        self.configure()
          
    def configure(self):
        options = self.options
        if not self.do_candidatos:
            options.pop('candidatos')
        if not self.do_partidos:
            options.pop('partidos')
        if not self.do_codigos:
            options.pop('codigos')
        self.options = options
          
    def do_scrape(self):

        directory = Directory(self.directory)
        options = self.options.keys()
        
        if options == []:
            return
        
        self.clear_files()
        
        self.scrape_data(directory)
            
    def scrape_data(self, directory):
                
        files = directory.GetDictionary('files')
        dirs  = directory.GetDictionary('directories')
        
        for folder in dirs.values():
            print "Scraping "+folder.path
            self.scrape_data(folder) 
            
        for result_data in files:
            filename = path.join(directory.path,result_data)
            
            print "Scraping file "+result_data
            result_code = result_data[4:-5]
            
            html_file = self.get_parsed_file(filename)
            root = html_file.getroot()
            results = root.findall(HTML_RESULTS_ID)
            
            if results == []:
                continue
            else:
                results = results[0]

            for option in self.options.keys():
                self.options[option](result_code,root)

    def do_scrape_candidatos(self, result_code,root):
        candidatos  = []
        votes_per   = []
        
        results     = root.findall(HTML_RESULTS_ID)[0]
        resultados  = results.findall(".//tr/td/a[@href]")

        # Get the candidate name
        for candidato in resultados:
            candidatos.append(candidato.text)

        resultados = results.findall("./div/table/tr/td[@align]/span")
        
        # Get the votes and percentages
        for vote in resultados:
            vote = vote.text.replace('.','')
            vote = vote.replace(',','.')
            vote = vote.replace('%','')
            votes_per.append(vote)

        if candidatos == [] or votes_per == []:
            return

        votes = votes_per[0::2]
        perc  = votes_per[1::2]

        code = self.prepare_code(result_code)
        data = map(lambda x,y,z: code+[x,y,z], candidatos,votes,perc)
        
        #Tuple with votes and percentages per candidate.
        self.save_to_file('candidatos',data)
        
        return

    def do_scrape_partidos(self, result_code,root):
        resultados = []
         
        # Now on a per-party basis
        partidos = root.findall(".//table[@class='n_s']")

        for candidato in partidos:
            for partido in candidato.findall(".//table/tr/td/span"):
                if partido.text == None:
                    result = partido[0].get('alt')
                else:
                    result = partido.text.replace('.','')
                    result = result.replace(',','.')
                    result = result.replace('%','')
                resultados.append(result)

        partido = resultados[0::3]
        votos   = resultados[1::3]
        percen  = resultados[2::3]

        code = self.prepare_code(result_code)
        data = map(lambda x,y,z: code+[x,y,z], partido,votos,percen)
        self.save_to_file('partidos',data)
        
        return

    def do_scrape_codigos(self, result_code,root):
        data = []
        
        codigos = root.findall(".//ul/li[@class='region-nav-item']/a")
        
        # Get the location codes
        if codigos != []:
            for codigo in codigos:
                data_code = re.search('reg_(?P<code>[0-9]+)\.html',codigo.get('href')).group('code')
                centre    = codigo.text.replace(',',' - ')
                temp_data = self.prepare_code(data_code)
                temp_data.append(centre)
                data.append(temp_data)

            self.save_to_file('codigos',data)
        
        return
    
    def prepare_code(self,data_code):
        # We pad the code up to the maximum length to split it properly
        temp_code = data_code+(self.code_length[len(data_code)])
        
        # Estado - Municipio - Parroquia - Centro - Mesa - Nombre
        data = [ temp_code[:2], temp_code[2:4], temp_code[4:6], temp_code[6:9], temp_code[9:12] ]
        return data

    def get_parsed_file(self, filename):
        try:
            parser = etree.HTMLParser()
            html_file = etree.parse(filename,parser)
            return html_file
        except IOError,e:
            print 'get_parsed_file(): ',e
            raise Exception("Could not load "+filename+" for parsing")

    def save_to_file(self, filename_code, data):
        filename = self.filenames[filename_code]
        with open(filename, 'a+b') as csvfile:
            resultados = UnicodeWriter(csvfile, delimiter=',', quotechar='=', quoting=csv.QUOTE_MINIMAL)
            if not self.are_headers_written(filename_code):
                self.write_headers(filename_code)
            resultados.writerows(data)
            csvfile.close()

    def clear_files(self):
        for csv in self.filenames.values():
            if path.isfile(csv):
                os.remove(csv)

    def are_headers_written(self,filename_code):
        return self.headers_written[filename_code]

    def write_headers(self, filename_code):
        filename = self.filenames[filename_code]
        with open(filename, 'a+b') as csvfile:
            resultados = UnicodeWriter(csvfile, delimiter=',', quotechar='=', quoting=csv.QUOTE_MINIMAL)
            resultados.writerow(self.headers[filename_code])
            self.headers_written[filename_code] = True
            csvfile.close()
