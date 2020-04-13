#!/bin/bash

DIR=posts

find rest-discuss -type f | xargs grep -l '"authorName":"Roy T. Fielding"' > rf_all
for f in $(cat rf_all); do h=$(basename $f | sed -e 's/json/html/') ; echo "<html><pre>" > $DIR/$h ; cat $f | jq -r .ygData.rawEmail >> $DIR/$h; done
rm rf_all

