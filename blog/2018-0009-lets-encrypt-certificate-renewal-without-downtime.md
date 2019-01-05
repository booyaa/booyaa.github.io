---
permalink: "/2018/lets-encrypt-certificate-renewal-without-downtime"
title: "Let's Encrypt certificate renewal without downtime"
categories:
  - "docker,nginx,letsencrypt,devops"
published_date: "2018-09-12 18:26:00 +0000"
layout: post.liquid
is_draft: false
data:
  tags: "docker,nginx,letsencrypt,devops"
  route: blog
---
Warning: this blog post assumes the following:
- you are running nginx in a [Docker](https://www.docker.com/) container. 
- Let’s Encrypt has been configured correctly in the nginx container.
- You are awesome for reading this blog.

The default behaviour of [certbot](https://certbot.eff.org/) (Let’s Encrypt’s command line tool) is to restart the web server. This isn’t desirable in a live environment, ideally you want your web server to reload it’s configuration. For [nginx](https://www.nginx.com/), this involves sending a [signal](https://en.wikipedia.org/wiki/Signal_(IPC)) to the process, in this case it’s `HUP` (hangup).

But how can you tell that your certificates have been renewed?

The recommended way by NGINX (the organisation rather than the web server) is to check the PIDs (Process Ids) before triggering nginx to reload the configuration.

```shell
docker top <NGINX_CONTAINER_ID> axw -o pid,ppid,command | egrep '(nginx|PID)'
PID                 PPID                COMMAND
2089                31208               tail -f /var/log/nginx/access.log
3509                31222               nginx: worker process
31222               31208               nginx: master process nginx -g daemon off;
```

The PID you want to observe is **nginx worker process** (COMMAND) which is in this example is  **3509**.

Pro-tip: You can pass `docker top`  subcommand `ps` flags? Neat huh?

Now let’s send a `HUP` signal to the container to force nginx to reload the configuration: `docker kill —signal  HUP <NGINX_CONTAINER_ID>`

Then re-check PIDs

```shell
docker top <NGINX_CONTAINER_ID> axw -o pid,ppid,command | egrep '(nginx|PID)'
PID                 PPID                COMMAND
2089                31208               tail -f /var/log/nginx/access.log
3643                31222               nginx: worker process
31222               31208               nginx: master process nginx -g daemon off;
```

The PID of the **nginx worker process** has now changed to **3643**!

Further reading:

- [Controlling nginx](http://nginx.org/en/docs/control.html)