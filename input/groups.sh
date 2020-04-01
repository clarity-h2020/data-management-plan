#!/bin/sh
ckanapi action group_package_show id='non-open-data-produced-by-clarity' -r https://ckan.myclimateservice.eu/  > non-open-data-produced-by-clarity.json
ckanapi action group_package_show id='non-open-data-used-by-clarity' -r https://ckan.myclimateservice.eu/  > non-open-data-used-by-clarity.json
ckanapi action group_package_show id='open-data-produced-by-clarity' -r https://ckan.myclimateservice.eu/  > open-data-produced-by-clarity.json
ckanapi action group_package_show id='open-data-used-by-clarity' -r https://ckan.myclimateservice.eu/  > open-data-used-by-clarity.json