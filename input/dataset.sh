#!/bin/sh
echo 'retrieving dataset' $1;
ckanapi action package_show id=$1 -r https://ckan.myclimateservice.eu > $1.json