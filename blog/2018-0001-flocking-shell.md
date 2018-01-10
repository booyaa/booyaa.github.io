permalink: /2018/flocking-shell
title: Flocking shell
published_date: "2018-01-10 07:49:00 +0000"
layout: post.liquid
categories: [ til, flock, linux]
is_draft: true
data:
  route: blog
  tags: "til, flock, linux"
---
Yesterday, I had an interesting problem where my cron task spawned hundreds of copies of itself because it was blocking. If a  process spawns emough times, you'll eventually run out of file descriptors and be unable to fork more processes. To avoid further repeats, I needed to add a check to see if the script was already running and exit early.

Script is a little bit more complicated because it needed to spawn specific instances. Each of these instances might contain different code blocks or maybe connect to a different database. The important takeaway is that each instance, must be allow a single copy of itself.

I could've gone down the route of using creating a PID file (storing the current process id of the script), checking if the current process and the PID file matched and exiting if not.

Instead I fancied trying something different, according to StackOverflow [flock](https://linux.die.net/man/1/flock) was a popular choice.
