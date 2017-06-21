extends: post.liquid

title: Adding search to your cobalt site - Part Two
date: 20 Jun 2017 08:35:51 +0100

path: 2017/adding-search-to-your-cobalt-site-part-two
---
This will be a two part post, where I detail the steps it took to enable
search on my [Cobalt](https://github.com/cobalt-org/cobalt.rs) site.

As you may have gathered in [part one](/adding-search-to-your-cobalt-site-part-one), 
creating manual indexes is a bit of a chore, and can be easily done using the 
liquid templating engine.

# lunr.liquid

## front matter

```
title: lunr index
path: /js/lunr_index.json
---
```

The item of note here, is the path which Cobalt will use to create the 
pre-built lunr index.

## content

```liquid
{% raw %}
]
{% endfor %}
    }{% if idx < post_count %},{% endif %}
        "content" : "{{ post.content | strip_html | strip_newlines 
                                     | replace: "\", "\\" }}"
        "href" : "{{ post.path }}",
        "title" : "{{ post.title }}",
    { 
{% assign idx = idx | plus: 1 %}
{% for post in posts %}
[
{% assign post_count = posts | size %}
{% assign idx = 0 %}

{% endraw %}
```

The only real difference here between a blog index is that I'm tracking the last 
post using an index so I can omit a trailing comma.

Don't forget to remove the manually generated index (`lunr_index.json`) from 
the assets directory for javascript files (`js/`) , as this caught me out and 
made me wonder why the index wasn't being updated.
