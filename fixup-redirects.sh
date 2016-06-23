#!/bin/bash

for file in `find . -name "*.html"`; do
  base=`basename $file`
  if [ "X$file" = "X./index.html" ]; then
    loc=""
  elif [ "X$base" = "Xindex.html" ]; then
    loc=`dirname $file`
  elif [ `expr "$base" : '.*\(.1.html\)'` ]; then
    loc="`dirname $file`/Manuals/$base"
  elif [ `expr "$base" : '.*\(.8.html\)'` ]; then
    loc="`dirname $file`/Manuals/$base"
  elif [ `expr "$file" : '.*\(apidocs\).*'` ]; then
    loc="`echo $file | sed 's/apidocs/JavaDoc/'`"
  else
    loc=$file
  fi
  loc=`echo $loc | cut -d/ -f2-`
  cat redir-template | sed "s,LOCATION,$loc,g" > $file
done

