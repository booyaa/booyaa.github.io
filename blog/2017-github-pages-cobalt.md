extends: default.liquid

title: Using cobalt with github pages
date: 11 Jun 2017 18:29:09 +0100

path: 2017/cobalt-github
---

Bit of a pain, but only because my git prowess is lacking..

# Instructions

- create your user page
- follow instructions for initialising a repo

```shell
git -b checkout source
cobalt init
# do stuff....
cobalt build
# commit, maybe even push
cobalt import --branch master
git checkout master
# commit, definitely push
```




