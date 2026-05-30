#!/bin/bash

FILE="/var/www/html/index.nginx-debian.html"

CITY="Perm"

read -r temp humidity <<< $(curl -s wttr.in/${CITY}?format=j1 | jq -r '.current_condition[0] | "\(.temp_C) \(.humidity)"')


{
    echo "<h1>Weather ${CITY}</h1>"
    echo "<p>Temperature: ${temp}<br>"
    echo "Humidity: ${humidity}<br>"
    echo "Date: $(date)</p>"
} > ${FILE}
