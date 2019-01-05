---
permalink: "/2019/gatsby-wordpress-cutlasses-and-webhooks"
title: "Gatsby and WordPress: Yarr! Cutlasses and WebHooks!"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-06 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
We’re almost finished! All we need to do is get WordPress to tell Netlify when we’ve published any new posts. To do this, we’ll use webhooks.

- Setup webhook in Netlify (`Build & Deploy > Continuous Deployment > Build hooks > Add build hook`)
- Go to your WordPress site’s Admin page (`Settings > Webhooks > Add webhook`)
  - **Action:** publish_post
  - **Fields:** ID (this doesn’t matter)
  - **URL:** paste your Netlify web hook

Note: this will only cause a rebuild of the site Netlify for new posts, you need to create a separate webhook event to trigger for pages. Although if it can wait, until your next post. Gatsby will pull in those changes to posts too.

You can test this works, by creating a new post in WordPress. You should see a new build job in Netlify almost immediately after hitting publish in WordPress. Once build, you should see your new post!

![Web Hook Triggered Post](/img/gxw-webhook-post.png)

Let’s the click deploy button to publish the site. If there were any errors, check out the logs in the Deploys section of your Netlify site.

## Bonus material: Have you talked to your kid about PWAs?

At no point have we compared how performant our “starter” Gatsby site is. Installing and configuring the Offline site we can beat the default Lighthouse (Google Chrome Dev Tools) rating for a stock WordPress.com site. Let’s do this last thing!

Note: this is a copy of the instructions from the Gatsby [docs](https://www.gatsbyjs.org/docs/add-offline-support-with-a-service-worker/#add-offline-support-with-a-service-worker).

Install the plugin `npm install --save gatsby-plugin-offline`

Enable the offline plugin in `gatsby-config.js`.

```js
    {
      resolve: `gatsby-plugin-manifest`,
      options: {
        // details omitted
      },
    },
    'gatsby-plugin-offline',
  ],
}
```

Note: the offline plugin must come after the manifest plugin.

Finally, add code to notify the user that they need to refresh the page when the service worker has an update:

```js
exports.onServiceWorkerUpdateFound = () => {
  const answer = window.confirm(
    `This application has been updated. ` +
      `Reload to display the latest version?`
  )

  if (answer === true) {
    window.location.reload()
  }
}
```

Let’s compare Lighthouse audits, first up is our stock WordPress blog:
![Web Hook Triggered Post](/img/gxw-lighthouse-1.png)

And now our Gatsby site `*drum roll*`
![Web Hook Triggered Post](/img/gxw-lighthouse-2.png)

This is pretty amazing, we turned out site into a compliant and highly performant Progressive Web App (PWA) in just a few simple steps. This is largely in part to the excellent boilerplate that you get when you run `gatsby new`.

At last count, there were [86](https://www.gatsbyjs.org/starters/?v=2) Gatsby starters created by the team and community. There’s bound to be a starter to fit your needs.

If you got stuck, you can check out the following Git hash: [`b1a4cc77a3d5ff0b0ad364ed5eff57fce30da5cf`](https://github.com/booyaa/wordsby/commit/b1a4cc77a3d5ff0b0ad364ed5eff57fce30da5cf)

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- [Setup](/2019/gatsby-wordpress-setup)
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- *Yarr! Cutlasses and Webhooks!*
- [Summary](/2019/gatsby-wordpress-summary)