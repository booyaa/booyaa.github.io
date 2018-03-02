permalink: "/2018/2018-0004-tunnelling-tcp-over-dns-in-2018"
title: Tunnelling TCP over DNS in 2018
categories:
  - tools
layout: post.liquid
is_draft: true
data:
  tags: "tools"
  route: blog
---
## setting up iodine (2018)

- github: https://github.com/yarrick/iodine
- install: http://code.kryo.se/iodine/README.html
- homebrew (why did this fall out of favour?) https://github.com/Homebrew/homebrew-core/pull/24054/files

```text
t1ns A your_vps_ip
t1 NS t1ns.yourdomain.tld
```

server side (debian/ubuntu)

- `apt-get install iodine`
- `iodined -f -c -P f00b44 10.0.0.1 t1.yourdomain.tld`

client side

- install

```shell
git clone https://github.com/yarrick/iodine.git
ls
cd iodine/
ls
make
make
PREFIX=/usr/local make install
```

- `sudo /usr/local/sbin/iodine -d utunX -f -P f00b44 t1.booyaa.wtf`

socks proxy

- `ssh -D 9999 10.0.0.1`
- `curl --socks5-hostname 127.0.0.1:9999 -L http://httpbin.org/ip`

pro-tip

`<enter> ~.` to escape hung ssh sessions 