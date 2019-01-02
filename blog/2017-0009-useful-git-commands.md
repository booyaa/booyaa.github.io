---
permalink: "/2017/useful-git-commands"
title: Useful git commmands
published_date: "2017-06-22 18:51:43 +0100"
layout: post.liquid
data:
  route: blog
  tags: git
---
## Commit logs

Now that I've started adding [useful commit messages](/2017/useful-commit-messages.md)
it's really use to make sense of my commits, more so when you use single line 
mode.


```shell
$ git log --oneline
3b04513 doc: add 'comment' tag to explain purpose of new templates
86cc454 feat: add tags to search
7286f90 feat: add twitter share button
24cfc85 feat: add todo
20d28d7 chore: remove manually generated lunr index
...
```

## Started working on a feature/fix, but forgot you we're in master?

This assumes you haven't committed your changes...

```shell
git checkout -b new_branch
# add and commit your changes
git checkout master
# clean up any files you don't want to commit...
```

## Sync your repo with the upstream

Setup a remote to the upstream.

```shell
git remote add upstream <path/to/upstream> # e.g. https://github.com/cobalt-org/liquid-rust.git
```

Now sync!

```shell
git fetch upstream  # gets branches and commits from upstream
git checkout master # switch to your fork’s master branch (if you're not already there)
git merge upstream/master # sync
git push -u origin master # update remote repo of your fork
```

This can also be used to push your GitHub repos to other hosted SCM providers 
i.e. GitLab and BitBucket

## Submodules

You want to add repo `Bar` to your own repo `Foo`

`git submodule add https://path/to/bar`

To pull the changes in

`git submodule init`

To do this at clone time

`git clone --recursive https://repo/contain/submodules`

To refresh the submodule (assuming the dir name is the same as the submodule)

 `git submodule update --remote submodule_name`

Possible gotcha if you refresh your submodule, you will need to commit new
version into your own repo.

## Tags

N.B. Tags when push to GitHub become releases!

to tag

`git tag v1.0.0`

to see what tag we're on

`git tag`

to push

`git push --tags`

to pull

`git fetch --tags`

## Fixing "fatal: refusing to merge unrelated histories"

Warning: this is destructive, if you've got local uncommitted changes do not 
proceed!

```shell
$ git pull origin master
From github.com:booyaa/broken_repo
 * branch            master     -> FETCH_HEAD
fatal: refusing to merge unrelated histories
$ git fetch # may be superflurous
$ git reset --hard origin/master
$ git branch --set-upstream-to=origin/master master
Branch master set up to track remote branch master from origin.
```

## Updating a branch with new changes from master

```shell
git checkout out_of_date_branch
git merge origin/master
git push origin out_of_date_branch
```