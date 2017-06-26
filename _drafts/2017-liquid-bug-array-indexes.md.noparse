extends: post.liquid

title: Liquid Bug: Array Indexes
date: 23 Jun 2017 06:36:59 +0100

path: 2017/liquid-bug-array-indexes
---
```liquid
{% assign tags = "foo,bar" | split: "," %}
tags[0]: {{ tags[0] }}
```

`cobalt build` results in 
```
...normal build messages...
[error]  Parsing error: Expected |, found [
[error]  Build not successful
```

```liquid
{% for tag in tags %}
   {{ tag }}
{% endfor %}
```

Will build and display each tag. 

I've tested using another liquid [parser](http://harttle.com/shopify-liquid/) and this definitely a problem with liquid-rust

references
- https://github.com/cobalt-org/liquid-rust/issues/11
- http://shopify.github.io/liquid/filters/split/
- https://shopify.github.io/liquid/basics/types/#array
- https://github.com/harttle/shopify-liquid/wiki/Builtin-Filters
- https://help.shopify.com/themes/liquid/tags/theme-tags#raw
- https://github.com/harttle/shopify-liquid/blob/master/tags/raw.js
- https://github.com/harttle/shopify-liquid/blob/master/test/tags/raw.js