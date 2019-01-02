---
permalink: "/2017/gh-pages-custom-domain"
title: Using a custom domain with GitHub Pages
published_date: "2017-06-13 08:02:54 +0100"
layout: post.liquid
data:
  route: blog
  tags: "cobalt,github,dns"
---
It took far too long to work out how to do this on the GitHub help pages...

Assumptions:

- I've only tested for personal/user domain i.e. the doc root for
`http://USERNAME.github.io/`.
- You've already have an `A` (APEX) record for your existing site.
- You've already got a `CNAME` record that points to the `A` record.

## Instructions 

1. Enable custom domain in your repository (settings).
2. Update your `A` record to point to IP addresses: `192.30.252.153` and 
`192.30.252.154`. Pro-tip: Switch your DNS management to cloudflare if you want 
super fast switch from your old hosting to GitHub.
3. `echo "your-domain-name" > CNAME` in the default branch repo. This will be
`source` if you're doing this for a Cobalt site.
