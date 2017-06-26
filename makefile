.PHONY: build clean

build:
	cobalt clean --silent
	cobalt build --silent
	node _lunr/build-index.js < build/js/lunr_docs.json > js/lunr_prebuilt.json
	
serve:
	cobalt serve

upgrade:
	cargo install --force cobalt-bin --features="syntax-highlight"