---
permalink: "/2017/adding-search-to-your-cobalt-site-part-two"
title: "Adding search to your cobalt site - Part Two"
published_date: "2017-06-20 08:35:51 +0100"
layout: post.liquid
data:
  tags: "cobalt,github,search,lunr,liquid"
  route: blog
---
This will be a two part post, where I detail the steps it took to enable search on my [Cobalt](https://github.com/cobalt-org/cobalt.rs) site.

As you may have gathered in [part one](/2017/adding-search-to-your-cobalt-site-part-one/) creating manual document collections is a bit of a chore, and can be easily done using the liquid templating engine.

## lunr.liquid

### front matter

```yml
title: lunr index
path: /js/lunr_docs.json
---
```

The item of note here, is the path which Cobalt will use to create the lunr document collection.

### content

{% raw %}
```css.liquid
{% assign idx = 0 %}
{% assign post_count = collections.posts.pages | size %}
[
{% for post in collections.posts.pages %}
{% assign idx = idx | plus: 1 %}
    { 
        "title" : "{{ post.title }}",

        {% assign tags_list = post.data.tags | replace: " ", "" | split: ","  %}
        {% assign tags_size = tags_list | size | minus: 1 %}
        {% assign idx2 = 0 %}
        "tags": [
        {% for tag in tags_list %}
            "{{ tag }}"{% if idx2 < tags_size %},{% endif %}
            {% assign idx2 = idx2 | plus: 1 %}
        {% endfor %}
        ],
        "href" : "{{ post.permalink }}",
        "content" : "{{ post.content | strip_html | strip_newlines | replace: "\", "\\" }}"
    }{% if idx < post_count %},{% endif %}
{% endfor %}
]
```
{% endraw %}

The only real difference here between a blog index is that I'm tracking the last post using an index so I can omit a trailing comma.

Don't forget to remove the manually generated document collection (`lunr_docs.json`) from the assets directory for javascript files (`js/`) , as this caught me out and made me wonder why the index wasn't being updated.

## Updates

2017-06-21 - Change references to the lunr index to the lunr document collection.
