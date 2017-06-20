extends: post.liquid

title: Adding search to your cobalt site - Part One
date: 20 Jun 2017 08:06:11 +0100

path: 2017/adding-search-to-your-cobalt-site-part-one
---
This will be a two part post, where I detail the steps it took to enable
search on my Cobalt site.

In this first post I will detail how to integrate [lunr](http://lunrjs.com/) 
using a manually created index file. If you already know how to wire up lunr, 
you can skip to [second post](http://booyaa.wtf/2017/adding-search-to-your-cobalt-site-part-two), 
where I create the index file using a liquid template.

I love blogs. However, once the initial excitement of discovering an interesting 
blog post has worn off and you want to look for more relevant posts by the same
author you start to look for local search or some form of taxonomy.

This is often the short coming of using a static site generator to power your 
blog. It's great at produce pre-rendered static pages, but search or tag views
are the domain of a dynamic content management system.

The subject of this post is see if I can solve content discovery via local 
search, I would like to at a later date visit taxonomies.

It turns out that we can approximate a fairly good search experience using [lunr](http://lunrjs.com/)
which is a light weight implementation of [Solr](https://lucene.apache.org/solr/) the enterprise search platform. With a little bit of 
jQuery and the lunr library we can cobble together a basic search page in 
Cobalt.

## My Cobalt source directory structure

This is a point of reference for file locations.

```
.
├── _drafts
├── _layouts
├── blog
├── img
└── js
```

There should be no surprises here.

## search.liquid

I placed my search template in the root of my Cobalt source and it looks like this.

### frontmatter

```
extends: default.liquid

title: search
path:  search/
---
```

### liquid template

The general gist (pun intended) of the template is to create an text input box and a hook for the results to appear in.

The template is a copy of this [gist](https://gist.github.com/sebz/efddfc8fdcb6b480f567) which is a recipe for getting lunr to work with [hugo](http://gohugo.io/) (an excellent static site generator written in Go).

It has some tweaks to get it working with lunr v2.1.0.

```html
<input id="search" type="text" size="25" placeholder="search for stuff here..." 
       autofocus><br />

<ul id="results">
</ul>

<script type="text/javascript" 
        src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="https://unpkg.com/lunr/lunr.js"></script>
<script type="text/javascript">
var lunrIndex,
    $results,
    pagesIndex;

// This is pretty much a copy of 
// https://gist.github.com/sebz/efddfc8fdcb6b480f567
// Initialize lunrjs using our generated index file
function initLunr() {
    // First retrieve the index file
    $.getJSON("/js/lunr_index.json")
        .done(function(index) {
            pagesIndex = index;

            // Set up lunrjs by declaring the fields we use
            // Also provide their boost level for the ranking
            lunrIndex = lunr(function() {
                this.field("title", {
                    boost: 10
                });

                this.field("content");

                // ref is the result item identifier (I chose the page URL)
                this.ref("href");
                
                // Feed lunr with each file and let lunr actually index them
                pagesIndex.forEach(function(page) {
                    this.add(page)
                }, this);
            });
            
        })
        .fail(function(jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.error("Error getting cobalt index file:", err);
        });
}

// Nothing crazy here, just hook up a listener on the input field
function initUI() {
    $results = $("#results");
    $("#search").keyup(function() {
        $results.empty();

        // Only trigger a search when 2 chars. at least have been provided
        var query = $(this).val();
        if (query.length < 2) {
            return;
        }

        var results = search(query);

        renderResults(results);
    });
}

/**
    * Trigger a search in lunr and transform the result
    *
    * @param  {String} query
    * @return {Array}  results
    */
function search(query) {
    // Find the item in our index corresponding to the lunr one to have more 
    // info
    // Lunr result: 
    //  {ref: "/section/page1", score: 0.2725657778206127}
    // Our result:
    //  {title:"Page1", href:"/section/page1", ...}
    return lunrIndex.search(query).map(function(result) {
            return pagesIndex.filter(function(page) {
                return page.href === result.ref;
            })[0];
        });
}

/**
    * Display the 10 first results
    *
    * @param  {Array} results to display
    */
function renderResults(results) {
    if (!results.length) {
        return;
    }

    // Only show the ten first results
    results.slice(0, 10).forEach(function(result) {
        var $result = $("<li style=\"list-style:none;\">"); // FUUUUUU!
        $result.append($("<a>", {
            href: result.href,
            text: "» " + result.title
        }));
        $results.append($result);
    });
}

// Let's get started
initLunr();

$(document).ready(function() {
    initUI();
});
</script>
```

### An artisanal lunr index

To get my proof of concept going, I needed to feed lunr a distilled form of my
blog posts, which I called `lunr_index.json` and stored it in `/js`.

```json
[{
    "title": "Useful commit messages",
    "href": "/2017/useful-commit-messages/",
    "content": " Keeping a copy of this excellent bit of advice until I've committed (no pun) it to memory. "
}, {
    "title": "Add reading time in Cobalt",
    "href": "/2017/add-reading-time/",
    "content": " I wanted to add an approximate reading time to each of my blog posts, like those seen in medium posts. "
}, {
    "title": "Using a custom domain with GitHub Pages",
    "href": "/2017/gh-pages-custom-domain/",
    "content": " It took far too long to work out how to do this on the GitHub help pages... "
}, {
    "title": "Using Cobalt with GitHub pages",
    "href": "/2017/cobalt-github/",
    "content": " It turns out using Cobalt and your personal GitHub page is a bit trickier to setup. Your personal GitHub page as oppose to your repo GitHub page, must have the content in the master branch. Repository/Project GitHub pages can live in a subdir of default branch i.e. docs "
}, {
    "title": "MacBook Air Setup",
    "href": "/2017/mba-setup/",
    "content": " Here's my current setup for my MacBook Air Setup. I use a range of tools like homebrew, Visual Studio Code and vim. "
}]
```

The format is fairly trivial and only has a very small fragment of the blog 
post, which will affect searching.

Incidentally the `boost` property for the `title` field in the search template 
is probably superflorous as it's the only item being searched again. The 
original source for the code also utilised a `tag` field, and `boost` allows 
you to give weightings for which field should be favoured when searching the 
index.

Also I've misleadingly called this the index file, but readers with a keen eye 
will notice that the file gets read by the jQuery script and is then 
added to lunr's own object using the `add` function.

### Putting it all together

Once you've created the search template and the lunr index, all you need to do
is perform your usual `cobalt build` workflow.

If you've followed my structure, your search page can be found in `/search`. 
Search results should appear immediately.

### But is a webscale?

I have no idea, I don't have enough blog posts, but I do plan on doing 
experiments using lunr v2.x's `lunr.Index.load`, more details can be found 
[here](https://lunrjs.com/guides/index_prebuilding.html).