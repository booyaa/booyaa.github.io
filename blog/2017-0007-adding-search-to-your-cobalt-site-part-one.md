---
permalink: "/2017/adding-search-to-your-cobalt-site-part-one"
title: "Adding search to your cobalt site - Part One"
published_date: "2017-06-20 08:06:11 +0100"
layout: post.liquid
data:
  tags: "cobalt,github,search,lunr,liquid"
  route: blog
---
This will be a two part post, where I detail the steps it took to enable search on my [Cobalt](https://github.com/cobalt-org/cobalt.rs) site.

In this first post I will detail how to integrate [lunr](http://lunrjs.com/)  using a manually created document collection. If you already know how to wire up lunr, you can skip to [second post](/2017/adding-search-to-your-cobalt-site-part-two/), where I create the document collection using a liquid template.

I love blogs, but after the initial excitement of discovery you become curious about the blog author and if they have other posts of a similar topic. At this point you expect to have either a local search or some form of taxonomy.

This is often a shortcoming of using a static site generator to power your blog. It's great at producing pre-rendered static pages, but search or tag views are the domain of a dynamic content management system.

As the title of this blog post suggests, I will be looking to solve the problem of local search. I'll leave the subject of taxonomies for a future blog post.

It turns out that we can approximate a resonable search experience using lunr. lunr is a light weight implementation of [Solr](https://lucene.apache.org/solr/) the enterprise search platform (off the shelf search engine). With a little bit of jQuery and the lunr library we can cobble together a search page in Cobalt.

## My Cobalt source directory structure

I've shared my own blog's structure as an way to refer to locations within a Cobalt source directory.

```
.
├── _drafts
├── _layouts
├── blog
├── img
└── js
```

There should be no surprises here, our primary areas of interest will be the `js` directory where javascript related assets live. And the root of the directory where my index, about and licenses pages live (all extending the default liquid template).

## search.liquid

I placed my search template in the root of my Cobalt source and it looks like this.

### frontmatter

```yml
extends: default.liquid

title: search
path:  search/
---
```

### content

The general gist (pun intended) of the template is to create an text input box and a hook for the results to appear in.

The template is a copy of this [gist](https://gist.github.com/sebz/efddfc8fdcb6b480f567) for getting lunr to work with [hugo](http://gohugo.io/) (an excellent static site generator written in Go).

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
    $.getJSON("/js/lunr_docs.json")
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

## An artisanal lunr document collection

To get my proof of concept going, I needed to feed lunr a distilled form of my blog posts, which I called `lunr_docs.json` and stored it in `/js`. In an earlier version of this post, I mistakenly referred to this as the lunr index.

It's the data that will be used to generate lunr's index. The index has different structure that we'll learn about in [part two](/adding-search-to-your-cobalt-site-part-two).

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

The format of the document collection is fairly trivial and only has a very small fragment of the blog post, which will affect searching.

Incidentally the `boost` property for the `title` field in the search template is probably superflorous as it's the only item being searched again. The original source for the code also utilised a `tag` field, and `boost` allows you to give a weighting for which field should be favoured when searching the index.

As you can imagine hand crafting an document collection is a bit lo-fi, so if you want to see what I used in the end (another liquid template), check out [part two](/2017/adding-search-to-your-cobalt-site-part-two) of this blog post.

## Putting it all together

Once you've created the search template and the lunr index, all you need to do is perform your usual `cobalt build` workflow.

If you've followed my structure, your search page can be found in `/search`. Search results should appear immediately as you start to type in the input box.

## But is it webscale?

I have no idea, I don't have a large enough volume of data to test against. However lunr v2.x's `lunr.Index.load` function allows you to load a pre-built index, but this does add an extra of complexity. And at time of writing will require either node.js or some form of v8 context to generate it. The idea is that you index the document collection and serialise the index generated.

More details can be found [here](https://lunrjs.com/guides/index_prebuilding.html).

## Anything else?

I'd love to remove the dependency on jQuery, but to be fair I can't be arsed to rewrite in vanilla js as it just works &trade;. Saying that, it has got me thinking perhaps, I should create a liquid-rust extension (not sure if it'll be a tag, filter or other) to generate vanilla js for things that causes people to reach for [jQuery](http://youmightnotneedjquery.com).

Also I have no idea why the damn input box is so small.

Any guidence or help with either of these two issues would be greatly appreciated.

## Updates

2017-06-21 - Change references to the lunr index to the lunr document collection.
