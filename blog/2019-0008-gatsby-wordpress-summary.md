---
permalink: "/2019/gatsby-wordpress-summary"
title: "Gatsby and WordPress: Summary"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-07 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---

We've reached the end of our blog series, so what have we learnt?

- Gatsby has a great starter template that is highly performant (`gatsby new`). Whilst it's React based, the organisation of resources (components, images, pages, templates) made it fairly intuitive to edit or create new items.
- The build system allows you to get immediate feedback on your changes via live reloading. (`gatsby develop`)
- The Gatsby plugin ecosystem is healthy and provides us with many ways to pull in content to our site.
- The builtin GraphQL explorer (GraphiQL) allow us to query the WordPress data that we pulled in.
- The Gatsby APIs are powerful, but we didn't get overwhelmed by them as we only needed to know about [`createPages`](https://www.gatsbyjs.org/docs/node-apis/#createPages).
- Netlify took a lot of the hard work in continuously deploy new versions of our site.
- Using webhooks we can wire up WordPress and our site on Netlify.

There's still so much we haven't covered:

- Creating pages based on tags, categories, media, users, taxonomies or custom post types.
- Provide replacements for shortcodes, user comments and search.
- Image processing (which in turn requires the use of the ACF Entities (Advanced Custom Fields) WordPress Plugin).
- Authentication to have content for signed up members of your site.

Thank you for finishing this series! Please let me know if there are other topics you'd like me to cover around the Gatsby WordPress plugin.

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- [Setup](/2019/gatsby-wordpress-setup)
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- *Summary*