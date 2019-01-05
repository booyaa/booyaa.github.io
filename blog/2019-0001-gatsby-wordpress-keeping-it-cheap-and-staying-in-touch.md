---
permalink: "/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch"
title: "Gatsby and WordPress: Keeping it cheap and staying in touch"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-01 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
_This is the start of a blog post series about creating Gatsby site with content pulled in from a WordPress site._

Gatsby is a static site generator based around the JAMStack (JavaScript, APIs and Markup) and uses React and GraphQL to create blazingly fast sites. It’s fast because the sites it creates are static and uses modern web techniques like service worker and webpack. You can pull content from various sources using plugins, once pulled in to Gatsby they can be turned into static assets.

By the end of this series you’ll have learnt:

- How to create a new Gatsby site
- How to configure the WordPress plugin to connect to a WordPress.com blog
- How to adapt the starter site to use the newly created WordPress Posts and Pages nodes
- Automatically publish to Netlify via GitHub
- Finally set up the WordPress.com blog to notify Netlify when a new post has been published to trigger a new build of the Gatsby site

Things you’ll need to follow along:

- A GitHub account
- A netlify account
- A WordPress.com account
- Favourite snacks and beverage

We’ll also assume you understand Git basics, Node (and friends) and are comfortable with the command line. 

If you get stuck you can always check out my reference site on GitHub. At the end of a section, I’ll stick in the commit hash that closely matches the changes we made.

**The Gatsby x WordPress Blog Post series**

- *Keeping it cheap and staying in touch*
- [Setup](/2019/gatsby-wordpress-setup)
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- [Summary](/2019/gatsby-wordpress-summary)