#!/usr/bin/env sh
set -e

git submodule update --init --depth 1
git submodule foreach --recursive git fetch --all
git submodule foreach --recursive git reset --hard origin/master

# build
if [ -d dist ]; then
  rm -rf dist
fi
mkdir dist

cp -R landing/ dist/landing

cd main
npm ci
npm run build
mv dist/* ../dist/
rm -rf dist/
cd -

# replace index.html with temporary index.html
# remove this line when the main page is online
rm dist/index.html && cp index.html dist/index.html
