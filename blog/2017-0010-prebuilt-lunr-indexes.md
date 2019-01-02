---
permalink: "/2017/prebuilt-lunr-indexes"
title: "Using pre-built lunr indexes"
published_date: "2017-06-22 19:21:00 +0100"
layout: post.liquid
data:
  route: blog
  tags: "cobalt,search,lunr"
---
I've implemented pre-built indexes vs. on demand i.e. generating them when the 
search page is being loaded. I'm not entirely happy with the solution yet for 
the following reasons:

- Additional requirements - pre-built indexes require node.js to generate the
indexes offline.
- Documents collection - the original search page still depends on the `ref`
field (the link to the relevant blog post) and title because the lunr index 
doesn't provide this. The `content` field is now surplus to requirements once 
the site has been built, but it is needed during index generation.
- Added complexity - I know adding node.js isn't a big ask, but it has resulted 
in a new makefile. And until I update my travis config, pre-built indexes only
get created when I've written a new article.

One novel approach to solving both these problems is to utilise a V8 crate and
run lunr index natively. This is the approach adopted by the [lunr indexer](https://github.com/256dpi/middleman-lunr/blob/master/lib/middleman-lunr/indexer.rb) 
for [middleman](https://middlemanapp.com/) (a static site generate written in 
ruby).

Since we're not looking at native Cobalt solutions i.e. using liquid templates, 
another approach would be to modify the node.js script used to pre-build the 
index, to parse the content natively and remove the need for the `lunr.liquid` 
template. The script would also need to generate the documents collection 
that's still used by the search page minus the content field.

The code changes can be found in the following commits:

- [node.js script](https://github.com/booyaa/booyaa.github.io/commit/6628ea50d34ea83969089ade327002dcafe454d1) - used to pre-build the index, mostly cribbed from the lunr 
[guide](https://lunrjs.com/guides/index_prebuilding.html) on that subject.
- [makefile and search template](https://github.com/booyaa/booyaa.github.io/commit/9303429d0fb1e7a1163149a9b14cb97201003a50) - the makefile is cribbed from Matthias Endler's [own](https://github.com/mre/mre.github.io/blob/source/Makefile) version used to 
build his Cobalt site. The search template adds the prebuilt index to the list of
assets to be loaded when the page is loaded.
