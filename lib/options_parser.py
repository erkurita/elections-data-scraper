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

import argparse
from os import path

def check_path(path_str):
    full_path = path.abspath(path_str)
    if not path.isdir(full_path):
        msg = "%r no es un directorio valido (directorio completo: %r)" % (path_str,full_path)
        raise argparse.ArgumentTypeError(msg)
    return path_str 

class Parser(argparse.ArgumentParser):
    def __init__(self):
        argparse.ArgumentParser.__init__(self,prog="parse_results",
                                         description='Recolecta los resultados de las elecciones venezolanas y los vuelca sobre un medio especifico.')
        self.add_argument('path', metavar='PATH', type=check_path, 
                          help='directorio donde se ubica el raiz de las paginas de los resultados.')
        self.add_argument('--no-candidatos', action='store_false',
                          help='deshabilita la recoleccion de datos de candidatos.')
        self.add_argument('--no-partidos', action='store_false',
                          help='deshabilita la recoleccion de datos de partidos.')
        self.add_argument('--no-codigos', action='store_false',
                          help='deshabilita la recoleccion de datos de codigos.')


# Used for testing, please disregard
if __name__ == '__main__':
    parse = Parser()
    print parse.parse_args()
  