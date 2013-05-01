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

import sys
sys.path.append('lib')

import scraper
from options_parser import Parser

if __name__ == '__main__':
    parser = Parser()
    options = parser.parse_args(namespace=scraper.Scraper)
    elecciones = scraper.Scraper(options)
    elecciones.do_scrape()
    print "Done!"
