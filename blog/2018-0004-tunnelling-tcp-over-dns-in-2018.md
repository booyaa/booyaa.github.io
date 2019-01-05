---
permalink: "/2018/2018-0004-tunnelling-tcp-over-dns-in-2018"
title: Tunnelling TCP over DNS in 2018
categories:
  - tools
published_date: "2018-03-18 13:38:32 +0000"
layout: post.liquid
is_draft: false
data:
  tags: tools
  route: blog
---
I wrote this article after seeing that no one had written anything about tunnelling tcp traffic over dns since 2016. 

A common use of this type of tunnelling is to gain free Internet access by tunneling through a WiFi captive portal. 

I'd also say it's probably a good idea to get some practice before similar types of network restriction are imposed by your ISP or the state.

Just like stateful packet inspection will reveal ssh tunneling over https, this is by no means a method of concealment so caveat emptor! 

My choice of tunneling tool is **iodine**. The code can be found on [GitHub](https://github.com/yarrick/iodine), the site is hosted on [code.kryo.se](http://code.kryo.se/iodine/).

The setup hasn't changed along with the current version (0.7.0). Important thing to note here is that you should always have parity with the client and server version of iodine.

## Setting up iodine:

### Provision a server (via DigitalOcean et al). 

- install iodine (ubuntu/debian) `apt-get install iodine`
- run as a service `iodined -f -c -P f00b44 10.0.0.1 t1.yourdomain.tld`

note 1: f00b44 is your shared secret between client and server

note 2: just as you would with a vpn, you create a private network for your tunnel, in our case we're using the 

note 3: here's my DigitalOcean referral [link](https://m.do.co/c/95d81208d348) if you're feeling particularly generous.

### Create DNS records to point to your server

```text
t1ns A your_vps_ip
t1 NS t1ns.yourdomain.tld
```

tip: I use cloudflare to manage my dns, which means my DNS records propagate fairly quickly across the Internet.

### Install the client (mac OS)

```shell
git clone https://github.com/yarrick/iodine.git
ls
cd iodine/
ls
make
make
PREFIX=/usr/local make install
```

### Connect the client to the server  

`sudo /usr/local/sbin/iodine -d utunX -f -P f00b44 t1.yourdomain.tld`

note: you need sudo to use the tunnelling network adaptor.

### Setup verification

To verify setup we'll setup a ssh as a SOCKS proxy `ssh -D 9999 10.0.0.1`.

note: we're setting up the the SOCKS proxy via our server's ip address.

And then use httpbin to verify our ip address `curl --socks5-hostname 127.0.0.1:9999 -L http://httpbin.org/ip`

When tunnelling you got expect a considerable loss of bandwidth, I'd only recommend using ssh over this type of tunnelling, it's just too slow to do anything else useful.

random-tip: `<enter> ~.` to escape hung ssh sessions