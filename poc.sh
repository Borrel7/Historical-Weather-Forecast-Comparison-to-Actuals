#!/bin/bash

country='Canada'
city='Toronto'
tz='Central'
today=$(date +%Y%m%d)

reportname=raw_data_$today.txt
curl "wttr.in/$city" > $reportname

grep -iw °C $reportname > temperature.txt
now=$(head -1 temperature.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev)
cast=$(sed '3q;d' temperature.txt |  tr -s " " | xargs | cut -d 'C' -f2 | rev | cut -d ' ' -f2 | rev)
echo -e "$now\n"
echo -e "$cast\n"

year=$(TZ="$country/$tz" date +%Y)
month=$(TZ="$country/$tz" date +%m)
day=$(TZ="$country/$tz" date +%d)
hour=$(TZ="$country/$tz" date +%H)

echo -e "$year\t$month\t$day\t$hour\t$now\t$cast" >> rx_poc.log