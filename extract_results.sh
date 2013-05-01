#!/bin/sh

python parse_results.py 
mysql -u root -p  < sql/create_schema.sql 
mysqlimport -u root -p --fields-optionally-enclosed-by="=" --fields-terminated-by="," --local elecciones_2013 elecciones_2013_candidatos.csv elecciones_2013_partidos.csv elecciones_2013_codigos.csv

