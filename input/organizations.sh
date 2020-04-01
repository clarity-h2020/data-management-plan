#!/bin/sh 
ckanapi action package_search fq=organization:clarity -r https://ckan.myclimateservice.eu/ > clarity.json
ckanapi action package_search fq=organization:dc1 -r https://ckan.myclimateservice.eu/ > dc1.json
ckanapi action package_search fq=organization:dc2 -r https://ckan.myclimateservice.eu/ > dc2.json
ckanapi action package_search fq=organization:dc3 -r https://ckan.myclimateservice.eu/ > dc3.json
ckanapi action package_search fq=organization:dc4 -r https://ckan.myclimateservice.eu/ > dc4.json