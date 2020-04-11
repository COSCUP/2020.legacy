#!/usr/bin/env sh
set -e

# build
if [ -d dist ]; then
  rm -rf dist
fi
mkdir dist

cp -R landing/ dist/landing

cd main
npm i
npm run build
mv dist/* ../dist/
rm -rf dist/
cd -

# replace index.html with temporary index.html
# remove this line when the main page is online
rm dist/index.html && cp index.html dist/index.html

# deploy
cd dist
git init
git add -A
git commit -m 'deploy'
git push -f https://github.com/COSCUP/2020.git master:gh-pages
cd -