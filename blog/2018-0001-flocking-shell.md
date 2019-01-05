---
permalink: /2018/flocking-shell
title: Flocking shell
published_date: "2018-01-10 07:49:00 +0000"
layout: post.liquid
categories: [ til, flock, linux]
data:
  route: blog
  tags: "til, flock, linux"
---
Yesterday, I had an interesting problem. My cron task spawned hundreds of copies of itself because it was blocking on a database call. If a process spawns enough times, you'll eventually run out of file descriptors and will be unable to fork more processes. To avoid further repeats, I needed to add a check to see if the script was already running and exit early.

My requirements for the script in question, also requires that it be able to spawn a specific instance. Instance in this case, could mean connecting to a different database. The important takeaway is that each instance, must be allow a spawn single copy of itself.

I could've gone down the route of using creating a PID or lock file (storing the current process id of the script), checking if the current process and the PID file matched and exiting if not.

Instead I fancied trying something different and according to StackOverflow [flock](https://linux.die.net/man/1/flock) was a popular choice.

Here's a snippet of how to enable file locking in your scripts.


```shell
# how to allow the script multiple times for different instances
readonly LOCKFILE="${LOCKFILE_DIR}/${PROGNAME}-${INSTANCE}.lock"

# to avoid command block, link file descriptor (auto incremented) to our lock file
exec {lock_fd}>"$LOCKFILE"

# early exit if instance is already running
flock -n ${lock_fd} || exit 1
```

The funny notation `{lock_fd}` is an auto-incrementing named file descriptor which doesn't appear until bash 4.1.x.x (so you're out of luck Mac users). To add the Mac woes, flock isn't bundled with Mac, but someone's created a cross platform [version](https://github.com/discoteq/flock) with the same name.

To prove my script no longer spawned multiple copies I wrote the following script (safe-driver.sh):

```shell
#!/bin/bash

clear

for i in $(seq 3)
do 
    ( 
        echo "> BEGIN FOO $i"
        safe.sh FOO
        echo "> END FOO $i exit code: $?"
    ) & 
done

if [ ! -z "$IN_DOCKER" ]; then
    sleep 1 # allow scripts to run (needed for docker)
fi

printf "\n\njobs running (should only see one process running)\n"
jobs -l

printf "\n\nlist file locks\n"
lsof /tmp/safe*.lock

if [ ! -z "$IN_DOCKER" ]; then
    printf "\n\npausing, press any key to return early\n"
    read -r
fi
```

## References

-  Elegant locking of bash program [blog post](http://www.kfirlavi.com/blog/2012/11/06/elegant-locking-of-bash-program/) - I cribbed the idea of not running flock as a command block from Kfir's post, but I drew the line with how the code was organised. Where possible I try to avoid imposing coding style from other languages. I also still think bash can be consumed by two parties operational staff and developers, I would prefer to cater for ops since they usually end up looking after these scripts.&lt;/soapbox&gt;
- exec [examples](http://wiki.bash-hackers.org/commands/builtin/exec) from bash-hackers.org - This was my first time to use exec in anger and I think it helped me understand the role the file descriptor played in my flock script.
- Advanced Bash-Scripting Guide ([Special Characters](http://www.tldp.org/LDP/abs/html/special-chars.html) - This is my goto resource for searching for various symbols and glyphs often used blindly in bash. In particular I used this to find out the proper name for `()` (command block).

## Updates

You may have seen an earlier post (on the 10th), which I withdrew because I didn't feel I had solved the problem sufficiently and there was a misunderstanding of how [automatic file descriptor allocation](http://wiki.bash-hackers.org/scripting/bashchanges#redirection_and_related) works.
