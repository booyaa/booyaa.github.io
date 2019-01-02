---
permalink: "/2017/add-reading-time"
title: Add reading time in Cobalt
published_date: "2017-06-15 09:05:37 +0100"
layout: post.liquid
data:
  route: blog
  tags: "cobalt,github,liquid"
---
I wanted to add an approximate reading time to each of my blog posts, like those seen in [medium](https://medium.com) posts. There's a lot of really nice javascript libraries out that, but I kinda figured this defeat the whole purpose
of using a static site generator.

I was also looking for an excuse to use liquid (the template rendering engine for Cobalt).

It's a fairly simplistic approach, perform a word count and divide by 200 which is the average of words read per min.

```liquid
{% raw %}
{% assign reading_wpm = 200 %}
{% assign word_count = page.content | split: " " | size %}
{% assign reading_time = word_count | divided_by: 200 %}
{% case reading_time %}
  {% when 0 %}
    {% assign phrase = "less than a minute." %}
  {% when 1 %}
    {% assign phrase = "about a minute." %}
  {% else %}
    {% assign phrase = " minutes." | prepend: reading_time %}
{% endcase %}
Reading time: {{ phrase }}
{% endraw %}
```