#!/bin/bash

DIR=posts
PREVIEW=https://htmlpreview.github.io/?
INDEX=$DIR/index.md

find rest-discuss -type f | xargs grep -l '"authorName":"Roy T. Fielding"' > rf_all
echo "# List of rest-discuss posting by Roy Fielding\n\n" > $DIR/index.md
for f in $(cat rf_all); do
  h=$(basename $f | sed -e 's/json/html/')
  echo "<html><pre>" > $DIR/$h ; cat $f | jq -r .ygData.rawEmail >> $DIR/$h
  href="${PREVIEW}https://raw.githubusercontent.com/algermissen/rest-discuss-archive/master/${h}"
  title=$(cat $f | jq -r .ygData.subject)
  echo "- [${title}](${href})" >> $DIR/index.md
  echo -n "  > " >> $DIR/index.md
  cat $f | jq -r .ygData.msgSnippet >> $DIR/index.md
done



rm rf_all

