#!/bin/sh

echo "Scraping data, this will take a while ..."
python parse_results.py $1

echo "Creating database structure"
mysql -u root -p  < sql/create_schema.sql 

echo "Adding raw data to the database, please wait ..."
mysqlimport -u root -p --fields-optionally-enclosed-by="=" --fields-terminated-by="," --ignore-lines="1" --local elecciones_2013 elecciones_2013_candidatos.csv elecciones_2013_partidos.csv elecciones_2013_codigos.csv

echo "Organizing raw data into more manageable data, please wait ..."
mysql -u root -p  < sql/organize_data.sql

echo "Done!"

