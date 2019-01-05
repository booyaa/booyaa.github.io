---
permalink: "/2019/gatsby-wordpress-netlify"
title: "Gatsby and WordPress: Netlify or Die!"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-05 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
We’re done with our new site, it’s time to setup Netlify.

- Install `gatsby-cli` in your repo (netlify needs it to build your site): `npm install --save gatsby-cli`
- Get your node version `node -v` and stick it in `.nvmrc` to pin netlify to the version you used to build the site (note: don’t include the `v` in version number i.e. `v11.3.0` becomes  `11.3.0`
- Complete netlify setup up to step 5, but don’t hit deploy: [A Step-by-Step Guide: Gatsby on Netlify | Netlify](https://www.netlify.com/blog/2016/02/24/a-step-by-step-guide-gatsby-on-netlify/#connecting-to-netlify)
- Expand `advanced build settings`

![Advanced in Netlify](/img/gxw-netlify-1.png)

Remember those environmental variables we set up on `gatsby-config.js`? It’s time add them up in Netlify.

![Environment Variables in Netlify](/img/gxw-netlify-2.png)

Let’s the click deploy button to publish the site. If there were any errors, check out the logs in the Deploys section of your Netlify site.

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- [Setup](/2019/gatsby-wordpress-setup)
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- *Netlify or Die!*
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- [Summary](/2019/gatsby-wordpress-summary)