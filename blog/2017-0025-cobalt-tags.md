extends: post.liquid
title: Add support for tags to Cobalt
date: 9 Jul 2017 10:07:03 +0100
path: 2017/cobalt-tags
tags: cobalt, tags, taxonomies, categories
---
A while back I started adding a new front matter attribute to all my posts
called `tags`. I initially did this to improve my site search indexing (you can
read about that [here](/2017/adding-search-to-your-cobalt-site-part-one/)).

After spending some time thinking about how to add tags to the site, and I
think I've come up with a reasonable solution.

The biggest problem with tags is that you can't easily codegen the template
like the one I used for the documents collection
[feed](/2017/adding-search-to-your-cobalt-site-part-two/) to seed the lunr
indexer.

The code for the tag template looks like this.

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

The code is fairly trivially, grab the `tags` attribute turn it into an array
of tags and then loop over it and add a link if the tag is found.

If you were to create a template per tag, there's a risk of code duplication.
After that, it's only a matter of time, when you "fix" one template, but forget
apply to the others.

You could mitigate against this by recreating all the tag pages at build time.
I may revisit this solution at a later date to see if there's any other
benefits that might have been overlooked.

In the end I decided to use the `include` liquid tag to reuse the tag template
code, again I got the idea from Johann's excellent [blog](http://johannh.me)
where he broke up his default layout into components using `include`. One thing
to note about using the `include` tag is that you shouldn't include a front
matter section otherwise this will also be rendered.

## tags/cobalt.liquid
### front matter

```
extends: default.liquid
title: booyaa's boggy bloggy
path: tags/cobalt/
comment: collection of cobalt related posts
---
```

The only item of note here is the path, I've decided to utilise `tags` as a
sub-path. I've not created a index page for this sub-path, so it'll give a 404
for now.

### content

```liquid
{% raw %}
{% include "_layouts/_tag.liquid" %}

{% assign filter_tag = "cobalt" %}
{% endraw %}
```

The tag page content literally define the tag filter that will be used by the
`tags` template and then includes the `tags` template.

The end result can be found [here](/tags/cobalt/). The source code can be found
[here](https://github.com/booyaa/booyaa.github.io).