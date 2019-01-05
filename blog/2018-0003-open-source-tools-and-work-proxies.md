---
permalink: "/2018/open-source-tools-and-work-proxies"
title: Open source tools and work proxies
categories:
  - work
  - tools
published_date: "2018-02-04 17:03:44 +0000"
layout: post.liquid
is_draft: false
data:
  tags: "work, tools"
  route: blog
---
I often use a lot of open source tooling at work, initially I started with with node and npm (for our front end), and more recently python, Go and of course Rust.

Unfortunately a lot of tools, expect you to have direct access to the Internet, if you're behind a work proxy most will fail to connect to their registries or pull down code from source control repositories.

To make matters worse, work proxies often require Windows authentication. So rather than stick your credentials in a plain text file, you might prefer to use something like [Fiddler](https://www.telerik.com/fiddler). Fiddler is an excellent diagnostics tool for troubleshooting web apps, a bonus feature is that it also provides a local proxy (usually listen on port 8888), using your existing browser proxy settings.

After that, it's just a case of configuring your tools to use this local proxy. Just be mindful that if you can't access websites like [GitHub](https://github.com/) or [npm](https://www.npmjs.com/) in your browser, you won't magically get access this way, those restrictions will remain in place.

Here's a list of ways to get your open source tool to work with this local proxy:

## Environment variables (env vars)

Have these setup as a minimum, most tools will look of these env vars and should start working.

```
HTTP_PROXY=http://127.0.0.1:8888
HTTPS_PROXY=http://127.0.0.1:8888
```

This works with [rustup](https://rustup.rs),

## npm

```
npm config set proxy http://127.0.0.1:8888
npm config set https-proxy http://127.0.0.1:8888
```

## cargo

edit `%USERPROFILE%\.cargo` and add the following:

```
[http]
proxy = "http://127.0.0.1:8888"
```

## git

```
git config --global http.proxy http://127.0.0.1:8888
```

This should fix problems with golang and possibly cargo (when pull dependencies).

## python (Anaconda)

edit `%USERPROFILE%\.condarc` and add the following:

```
channels:
- defaults

# Show channel URLs when displaying what is going to be downloaded and
# in 'conda list'. The default is False.
show_channel_urls: True
allow_other_channels: True

proxy_servers:
    http: http://127.0.0.1:8888
    https: http://127.0.0.1:8888
```

## vscode

edit your user settings file and add

```json
  "http.proxy": "http://127.0.0.1:8888",
  "http.proxyStrictSSL": false,
```
