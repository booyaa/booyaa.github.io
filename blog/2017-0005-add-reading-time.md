extends: post.liquid
title: Add reading time in Cobalt
date: 15 Jun 2017 09:05:37 +0100
path: 2017/add-reading-time
tags: cobalt,github,liquid
---

I wanted to add an approximate reading time to each of my blog posts, like 
those seen in [medium](https://medium.com) posts. There's a lot of really nice
javascript libraries out that, but I kinda figured this defeat the whole purpose
of using a static site generator.

I was also looking for an excuse to use liquid (the template rendering engine 
for Cobalt).

It's a fairly simplistic approach, perform a word count and divide by 200 which 
is the average of words read per min.

```liquid
{% raw %}
{{ phrase }} 

Reading:

{% endcase %}
    {% assign phrase = " minutes." | prepend: reading_time %}
  {% else %}
    {% assign phrase = "about a minute." %}
  {% when 1 %}
    {% assign phrase = "less than a minute." %}
  {% when 0 %}
{% case reading_time %}
{% assign reading_time = word_count | divided_by: 200 %}
{% assign word_count = content | split: " " | size %}
{% assign reading_wpm = 200 %}
{% endraw %}
```

It would appear I may have found a bug with the `raw` tag implementation in 
[liquid-rs](https://github.com/cobalt-org/liquid-rust). I had to reverse the 
order of my code to get it to appear as you see in this blog post!

Bug report time!