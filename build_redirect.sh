#!/bin/sh

cd docs/
printf -- "---\nlayout: redirect\n---\n" > ./redirect
find ./ -name "*.html" | xargs -I {} sh -c "rm {}; ln ./redirect {}"

cd ../
bundle exec jekyll build
# http://stackoverflow.com/questions/1935081/remove-leading-whitespace-from-file
find _site/docs -name '*.html' | xargs -d '\n' -n 1 sed -e '/./,$!d' -i
find _site/docs -type f | grep -vP "\.html$" | grep -v "_site/docs/README.md" | grep -v "_site/docs/logo.png" | xargs -d '\n' rm
find _site/docs -type d -empty -delete

echo "Now docs are ready under: _site/docs/"
