#!/bin/bash

set -o errexit -o nounset

rev=$(git rev-parse --short HEAD)

# RUN PANDOC and create HTML
for i in *md; do
  if [[ $i != 'README.md' ]]; then
    pandoc -f markdown_github -c theme.css -s $i -o public/${i%%md}html;
  fi
done

cd public

git init


git config user.name "roddypr"
git config user.email "rodrigopracana@gmail.com"
git remote add deploy "https://$GH_TOKEN@github.com/wurmlab/QMUL-MSc-Programming-in-R-and-Using-Linux.git"

git fetch deploy gh-pages
git reset deploy/gh-pages

git add -A .
git commit -m "build website at ${rev}"
git push deploy HEAD:gh-pages
