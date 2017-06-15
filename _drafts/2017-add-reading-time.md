extends: post.liquid

title: Add reading time in Cobalt
date: 15 Jun 2017 09:05:37 +0100

path: 2017/add-reading-time
---

I wanted to add an approximate reading time to each of my blog posts, like 
those seen in [medium](https://medium.com) posts. There's a lot of really nice
javascript libraries out that, but I kinda figured this defeat the whole purpose
of using a static site generator.

I was also looking for an excuse to use liquid (the template rendering engine 
for Cobalt).

It's a fairly simplistic approach, perform a word count and divide by 200 which 
is the average of words read per min.

Unfortunately I've just realised I've miscounted, instead I'm do a char count so 
I can't publish this yet.

```liquid
    {% assign word_count = content | size %}
    {% if word_count == 0 or word_count < 1 %}
        {% assign reading_time = "less than a " %}
    {% else %}
        {% assign reading_time = word_count | divided_by: 200 %}
        {% assign pluralize = "s"%}
    {% endif %} 
```