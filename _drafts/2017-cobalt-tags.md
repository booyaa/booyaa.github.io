extends: post.liquid
title: How to add tags to Cobalt
date: 9 Jul 2017 10:07:03 +0100
path: 2017/cobalt-tags
tags: cobalt, tags, taxonomies, categories
---
For sometime I've been adding a new front matter attribute to all my posts called 
`tags`. I initially did this to improve my site search indexing (you can read about that 
[here](/2017/adding-search-to-your-cobalt-site-part-one/)).

I've spent considerably time thinking about how to add tags to the site, and I think I've come up with a reasonable solution.

The biggest problem with tags is that you can't easily codegen the templates like the I used for the [documents collection feed](/2017/adding-search-to-your-cobalt-site-part-two/) used to seed the lunr indexer.

The tag page code looks like this.

```liquid
{% raw %}
</ul>
{% endfor %}
{% endfor %}
    {% endif %}
        {% break %}</a></li>
            {{ post.title }}">{{post.path}}
            <li><a href="/{% if tag == filter_tag %}
        {% for tag in tags %}
    {% assign tags = post.tags | replace: " ", "" |  split: "," %}
    {% for post in posts reversed %}</h1>
<ul>
{{ filter_tag }}
<h1>Posts tagged as {% endraw %}
```

As you can see if you don't do something clever there's a risk of code duplication. You could mitigate against this if the tag pages are recreated each time.


However you can use the `include` liquid tag to reuse 


```
extends: default.liquid

title: booyaa's boggy bloggy
path: tags/cobalt/
comment: collection of cobalt related posts
---
```

```liquid
{% raw %}
{% include "_layouts/_tag.liquid" %}

{% assign filter_tag = "cobalt" %}
{% endraw %}
```

