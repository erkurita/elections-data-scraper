#!/user/bin/python

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

RECURSIVE = True
COPY_IMAGE = True
OVERWRITE_FILES = True
BAD_ARGUMENTS = 1

class Directory(object):
  path = None
  dir_name = None
  listing = {
      'directories' : None,
      'files' : None
      }

  def GetDirectories(self,recursivity = RECURSIVE):
    import os
    if os.path.isdir(self.path):
      directories = {}
      filess = {}
      listing = {}
      cwd = os.getcwd()
      os.chdir(self.path)
      files = os.listdir(os.getcwd())
      for files in files:
        filename = os.path.split(files)[1]
        if os.path.isdir(files) and recursivity:
          directory = Directory(files)
          if directory.path != None:
            directories[filename] =  directory
          else:
            directory = None
        else:
          if filename[-4:] == 'html' and filename[:3] == 'reg':
            filess[filename] = files
      os.chdir(cwd)
      if directories != {}:
        listing['directories'] = directories
      if filess != {}:
        listing['files'] = filess
      return listing

  def GetDictionary(self,tipo):
    if tipo == 'directories' or tipo == 'files':
      try:
        return self.listing[tipo]
      except (TypeError,KeyError):
        return {}
    return None

  def __init__(self,directory,recursive = RECURSIVE):
    from os import path
    self.path = path.abspath(directory)
    if path.isdir(self.path):
      try:      
        self.listing = self.GetDirectories(recursive)
      except OSError:
        self.listing = None
        self.path = None
    else:
      self.path = None
      raise Exception(directory+" is not a valid directory.")
    try:
      self.dir_name = path.split(self.path)[1]
    except AttributeError:
      self.dir_name = None

  def PrintDirectories(self):
    self.PrintDirs(0)

  def PrintDirs(self,depth):
    def SetSeparator(depth):
      separator = ''
      if depth != 0:
        if depth > 1:
          separator = " "*(depth-1)+'|'+('-'*5)+'>'
        else:
          separator = '|'+'->'
      return separator
    separator = SetSeparator(depth)
    print separator,self.path
    depth += 1
    separator = SetSeparator(depth)
    try:
      if self.listing['directories'] != None:
        for direc in self.listing['directories'].values():
          direc.PrintDirs(depth)
    except KeyError:
      pass
    try:
      if self.listing['files'] != None:
        for files in self.listing['files'].values():
          print separator,files
    except KeyError:
      pass

  def IsEmpty(self):
    import os
    return os.listdir(self.path) == []

  def RemoveFile(self,image_file):
    if not isinstance(image_file,str):
      raise TypeError('RemoveFile(): Argument must be a string, got '+type(image_file).__name__)
    if image_file in self.self.listing['files']:
      self.listing['files'].get(image_file).img = None
      self.listing['files'].pop(image_file)

  def RemoveDir(self,directorio):
    if not isinstance(directorio,Directory):
      raise TypeError('RemoveDir(): Argument must be a directory, got '+type(directorio).__name__)
    directories = self.GetDictionary('directories')
    if directories != None and directorio.dir_name in directories:
      import os
      dir_name = directorio.path
      self.GetDictionary('directories').pop(directorio.dir_name)
      os.rmdir(dir_name)

  def DirHasFile(self,image_file):
    if not isinstance(image_file,str):
      raise TypeError('DirHasFile(): Argument must be a string, got '+type(image_file).__name__)
    return image_file in self.GetDictionary('files')

