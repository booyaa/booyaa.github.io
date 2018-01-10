permalink: /2018/flocking-shell
title: Flocking shell
published_date: "2018-01-10 07:49:00 +0000"
layout: post.liquid
categories: [ til, flock, linux]
data:
  route: blog
  tags: "til, flock, linux"
---
Yesterday, I had an interesting problem. My cron task spawned hundreds of copies of itself because it was blocking on a database call. If a process spawns emough times, you'll eventually run out of file descriptors and will be unable to fork more processes. To avoid further repeats, I needed to add a check to see if the script was already running and exit early.

My requirements for the script in question, also requires that it be able to spawn a specific instance. Instance in this case, could mean connecting to a different database. The important takeaway is that each instance, must be allow a spawn single copy of itself.

I could've gone down the route of using creating a PID or lock file (storing the current process id of the script), checking if the current process and the PID file matched and exiting if not.

Instead I fancied trying something different and according to StackOverflow [flock](https://linux.die.net/man/1/flock) was a popular choice.

```shell
$ cat safe-spawn.sh
#!/bin/bash

#exit on errors
set -e

readonly PROGNAME=$(basename "$0" .sh)
readonly LOCKFILE_DIR=/tmp
readonly INSTANCE="$1"
readonly LOCKFILE="${LOCKFILE_DIR}/${PROGNAME}-${INSTANCE}"

if [ -z "${INSTANCE}" ]; then
        echo "Must provide an instance!"
        exit 1
fi

# to avoid command block, link file descriptor 200 to our lock file
exec 200>"$LOCKFILE"

# early exit if instance is already running
flock -n 200 || exit 1

# write the pid to the file descriptor
echo $$ 1>&200

###################################################################
## code begins here..

echo "sleeping on $INSTANCE"
sleep 60
echo "finished on $INSTANCE"
exit 0
```

The magic number `200` is a file descriptor, named file descriptors don't appear until sometime after bash 3.2.57(1) (stock shell with MacOS). Incidentally, flock isn't bundle with osx, but someone's created a cross platform [version](https://github.com/discoteq/flock) with the same name.

Whilst the flock will happily prevent spawn multiple copies of an instance, I wanted to a way to kill a process cleanly, so our trusty friend the pid/lock file reappears, but relieved of the complex duty of determining if it's currently running.

Again we could easily do `kill $(cat /path/to/lockfile)`, but since I'm dealing with instances why not make a handy helper script? The lock files 

```shell
$ cat kill-instance.sh
#!/bin/bash

#exit on errors
set -e

readonly INSTANCE="$1"
readonly LOCKFILE="/tmp/safe-spawn-${INSTANCE}"

if [ -z "${INSTANCE}" ]; then
        echo "Must provide an instance!"
        exit 1
fi

if [ ! -f "$LOCKFILE" ]; then
        echo "Failed to find lock file: $LOCKFILE"
        exit 2
fi

kill $(cat "$LOCKFILE")

exit 0
```

Make sure you update the `LOCKFILE` variable in this script if you change the name of `safe-spawn.sh` to something else.

To prove my script no longer spawned multiple copies for a given instance, I came up with the following test commands.

```shell
clear
( echo BEGIN FOO 1 ; ./safe-spawn.sh FOO ; echo END FOO 1 exit status: $?) & # only one should run
( echo BEGIN FOO 2 ; ./safe-spawn.sh FOO ; echo END FOO 2 exit status: $?) & # only one should run
( echo BEGIN FOO 3 ; ./safe-spawn.sh FOO ; echo END FOO 3 exit status: $?) & # only one should run
```

I paste that into the shell, hit enter a copy of times. What you should see is 2 of the 3 tasks will exit immediately, leaving just a single task running. You can run `jobs` to see the task running.

If I wanted to kill this task, I just need to type `kill-instance.sh FOO`.

To prove that you can run a single instance (recall this could be different code logic or connecting to a different database), you could use the following test script:

```shell
clear
( echo BEGIN FOO ; ./safe-spawn.sh FOO ; echo END FOO exit status: $?) &
( echo BEGIN BAR ; ./safe-spawn.sh BAR ; echo END BAR exit status: $?) & # should also run
```

## References

-  Elegant locking of bash program [blog post](http://www.kfirlavi.com/blog/2012/11/06/elegant-locking-of-bash-program/) - I cribbed the idea of not running flock as a command block from Kfir's post, but I drew the line with how the code was organised. Where possible I try to avoid imposing coding style from other languages. I also still think bash can be consumed by two parties operational staff and developers, I would prefer to cater for ops since they usually end up looking after these scripts.&lt;/soapbox&gt;
- exec [examples](http://wiki.bash-hackers.org/commands/builtin/exec) from bash-hackers.org - This was my first time to use exec in anger and I think it helped me understand the role the file descriptor played in my flock script.
- Advanced Bash-Scripting Guide ([Special Characters](http://www.tldp.org/LDP/abs/html/special-chars.html) - This is my goto resource for searching for various symbols and glyphs often used blindly in bash. In particular I used this to find out the proper name for `()` (command block).
