#!/bin/bash

YEAR=$(date +%Y)
MONTH_DAY=$(date +%m-%d)
TITLE=$*

mkdir -p "posts/$YEAR"
FILENAME="posts/$YEAR/$MONTH_DAY-${TITLE// /-}.md"

echo "%{
  title: \"$TITLE\",
  author: \"Matt\",
  tags: ~w(),
  description: \"\"
}
---
" > $FILENAME
