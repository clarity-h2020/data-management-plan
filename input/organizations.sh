#!/bin/sh 
cd "${0%/*}"
ckanapi action package_search fq=organization:clarity rows=1000 -r https://ckan.myclimateservice.eu/ > clarity.json
ckanapi action package_search fq=organization:dc1 rows=1000 -r https://ckan.myclimateservice.eu/ > dc1.json
ckanapi action package_search fq=organization:dc2 rows=1000 -r https://ckan.myclimateservice.eu/ > dc2.json
ckanapi action package_search fq=organization:dc3 rows=1000 -r https://ckan.myclimateservice.eu/ > dc3.json
ckanapi action package_search fq=organization:dc4 rows=1000 -r https://ckan.myclimateservice.eu/ > dc4.json