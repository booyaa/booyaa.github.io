---
permalink: "/2019/learning-about-ebpf-on-macos"
title: "Learning about eBPF on macOS"
categories:
  - "linux,ebpf"
layout: post.liquid
published_date: "2019-10-13 13:37:00 +0000"
is_draft: false
data:
  tags: "linux,ebpf"
  route: blog
---

I've created this is a short post to talk about a new GitHub repo that might be useful to some: [vagrant-bcctools][gh_repo].

It's a simple Vagrant box using the latest (at the time of writing) version of Ubuntu (bionic) with the bcc tools [package][ubuntu_packages] installed.

I needed a way to play around with [eBPF][iovisor_ebpf] on macOS locally. So before embarking on a fool's errand, I did some research. For details about my findings, see the repo's [`README.md`][gh_repo].

I saw there was a Docker image, which doesn't work because I think it expects the underlying Docker host to be Linux base (volume mounts to `/lib/modules`, `/usr/src` and `/etc/localtime`). 

The `Vagrantfile` provided by [IO Visor][iovisor_homepage] is using such an old version of Ubuntu that a modern version of Vagrant seems to choke on it.

No doubt someone will point me to something that only requires [xhyve][gh_xhyve] (at me on Twitter or dev.to if you do know).

<!-- links -->

[gh_repo]: https://github.com/booyaa/vagrant-bcctools
[ubuntu_packages]: https://packages.ubuntu.com/bionic/all/bpfcc-tools/filelist
[iovisor_ebpf]: https://www.iovisor.org/technology/ebpf
[gh_xhyve]: https://github.com/machyve/xhyve
[iovisor_homepage]: https://www.iovisor.org/
