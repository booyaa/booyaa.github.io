extends: post.liquid
title: Adding an archive page to your Cobalt blog
date: 4 Jul 2017 16:13:01 +0100
path: 2017/adding-an-archive
tags: cobalt,liquid
---

To avoid slowing down the index page, there's a point where you need to limit
how many blog posts you want to appear on screen. This in turn presents another
problem, how do you then provide a way to display older posts? Enter an archive
page!

## archive.liquid

### front matter

```
extends: default.liquid

title: archive
path: /archive
route: archive
---
```

### template

```liquid
This is a quick work around until I've had a good think about a way to organise 
the archive.

<h2>2017</h2>

<ul>
{% raw %}
{% endfor %
{% endif %}</li>
{{ post.content | strip_html | truncatewords: 25, '...' }}</a> - {{ post.title }}">{{ post.path }}
  <li><a href="/{% if year == "2017" %}
{% assign year = post.path | truncate: 4, "" %}
{% for post in posts %}
{% endraw %}
</ul>
```

The template is placed in the root of your cobalt source dirctory. Yes it's a
bit of hack, but I'm still playing around with the format. I think eventually I
may even turn the archiving into a code generated process during build time.