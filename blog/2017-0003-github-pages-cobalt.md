---
permalink: "/2017/cobalt-github"
title: Using Cobalt with GitHub pages
published_date: "2017-06-11 18:29:09 +0100"
layout: post.liquid
data:
  route: blog
  tags: "cobalt,github"
---
It turns out using [Cobalt](https://github.com/cobalt-org/cobalt.rs) and your 
personal GitHub page is a bit trickier to setup. Your personal GitHub page as 
oppose to your repo GitHub page, must have the content in the `master` branch. 
Repository/Project GitHub pages can live in a subdir of default branch i.e. 
`docs`

This is not a criticism of Cobalt, but rather myself demonstrating my lack of 
git prowess.

The general gist of this how to, is that you place your Cobalt project in the
`source` branch and then use `cobalt import --branch master` to transfer the
rendered content to master.

## Instructions

- Create your user/personal page repo (USERNAME.github.io)
- Follow instructions for initialising a repo

```shell
git checkout -b source
cobalt init
# do cobalty stuff..
cobalt build
# commit, maybe even push to source
cobalt import --branch master
git checkout master
# commit, definitely push
```

If you want to check out my setup you can find it [here](https://github.com/booyaa/booyaa.github.io).

## Things I've not worked out yet

- The `build` folder gets copied to the `master` branch during `cobalt import`.
The folder doesn't contain any files. My work around at the moment is to add it
to `.gitignore` in the `master` branch.

## Thanks to...

- [Johann Hofmann](http://johannh.me) for allowing me to copy his 
blog's style (and his travis-ci auto deploy setup).
- [Cobalt](https://github.com/cobalt-org/cobalt.rs) for creating this easy to 
use static site generator.



