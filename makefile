.PHONY: build clean

build:
	cobalt clean --silent
	cobalt build --silent
	cat build/js/lunr_docs.json | json_pp | node _lunr/build-index.js - > js/lunr_prebuilt.json
	
serve:
	cobalt serve

upgrade:
	cargo install --force cobalt-bin --features="syntax-highlight"

publish:
	-git branch -D master
	rm -rf build/
	cobalt build
	cp keybase.txt build/
	cobalt import --branch master
	git checkout master
	cp build/keybase.txt .
	git add keybase.txt
	echo "build/" > .gitignore
	echo "_lunr/" >> .gitignore
	echo ".DS_Store" >> .gitignore
	git add .gitignore
	touch .nojekyll
	git add .nojekyll
	git commit -m "Github Pages integration"
	git push -u -f origin master
	git checkout source