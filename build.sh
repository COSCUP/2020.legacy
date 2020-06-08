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
git checkout gh-pages
mv ./* ../dist/
git reset --hard origin/master
cd -
