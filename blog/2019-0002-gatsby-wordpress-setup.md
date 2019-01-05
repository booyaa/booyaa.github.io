---
permalink: "/2019/gatsby-wordpress-setup"
title: "Gatsby and WordPress: Setup"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-01 13:37:01 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
_This is the start of a blog post series about creating Gatsby site with content pulled in from a WordPress site._

## Setup

- Create a new Gatsby site called “wordsby” `gatsby new wordsby`, this will create a new site using the starter site.
- Enter your new site: `cd wordsby`
- Setup a new GitHub repo and push your changes up to your repo

## Checkpoint: start up our site locally

- Let’s start our new site up `gatsby develop`
- Open up your new site on http://localhost:8000
- Open `gatsby-config.js` in your editor and change `siteMetadata.title` to something different, notice the site changed after you saved the changes?

If you got stuck, you can check out the following Git hash: `168483273e38b94dd35dd5063a44c4696c69ea11`

Setup WordPress and the Gatsby plugin

- Lets setup WordPress, go ahead and sign up for a free WordPress site. It’s fine to uses one of the free non-WordPress.com sites.
- Setup a new developer app that will allow us to connect to the blog: [Developer.WordPress.com](https://developer.wordpress.com/apps/)
  - Make a note of your
    - WordPress URL
    - Credentials (your email address and password that you used to create your blog)
    - Client Id
    - Client Secret
- Install the WordPress plugin `npm install --save gatsby-source-wordpress`
- Let’s edit our `gatsby-config.js`

Add the following entry to your `plugins` section

```js
    {
      resolve: `gatsby-source-wordpress`,
      options: {
        baseUrl: process.env.WORDPRESS_BASE_URL,
        protocol: process.env.WORDPRESS_PROTOCOL,
        hostingWPCOM: (process.env.WORDPRESS_HOSTING_WPCOM === 'true'),
        useACF: (process.env.WORDPRESS_USE_ACF === 'true'),
        verboseOutput: (process.env.WORDPRESS_VERBOSE_OUTPUT === 'true'),
        auth: {
          wpcom_app_clientSecret: process.env.WORDPRESS_CLIENT_SECRET,
          wpcom_app_clientId: process.env.WORDPRESS_CLIENT_ID,
          wpcom_user: process.env.WORDPRESS_USER,
          wpcom_pass: process.env.WORDPRESS_PASSWORD,
        },
        includedRoutes: [
          "**/posts",
          "**/pages",
          "**/tags",
        ],
      },
    },
```

You’ve probably noticed we’ve made use of environmental variables to store WordPress info. This is good practice and prevents accidental leakage of secrets  (storing them in a config file and committing to source control).

Let’s test our credentials by adding them to a `.env` file

```shell
WORDPRESS_BASE_URL=xxx.wordpress.com
WORDPRESS_PROTOCOL=https
WORDPRESS_HOSTING_WPCOM=true
WORDPRESS_USE_ACF=false
WORDPRESS_VERBOSE_OUTPUT=true
WORDPRESS_CLIENT_SECRET=xxx
WORDPRESS_CLIENT_ID=xxx
WORDPRESS_USER=xxx@example.com
WORDPRESS_PASSWORD=xxx
```

Don’t forget to include  `.env` in your `.gitignore` (the starter Gatsby site adds it by default, but it’s good practice to check it’s not being tracked by Git).

Whilst the `dotenv` module is installed as part of Gatsby it’s not enabled by default, so  find your  `module.exports` line add this  code above  it:

```javascript
require('dotenv').config();
```

## Checkpoint: verify WordPress credentials

Let’s restart the Dev environment using `gatsby develop`

Let’s go to the graphic explorer `http://localhost:8000/___graphql` this time. Paste the following `graphql` query into the left panel and hit the play button:

```graphql
{
  allWordpressPost {
    edges {
      node {
        title
        excerpt
        tags {
          name
        }
      }
    }
  }
}
```

If the plugin has successfully loaded and was able to connect to your WordPress blog you should be able to see data on the right panel.

### Troubleshooting

If you’ve copied the default WordPress for verbose output then, there the plugin should be in debug mode.  Look for the following warning:

`warning The gatsby-source-wordpress plugin has generated no Gatsby nodes. Do you need it?`

This indicates there was an error parsing one of the values you gave in `.env`.

If you see the following:

```text
Path: /oauth2/token
The server response was "400 Bad Request"
```

Then the username or password may be wrong. Test them by logging into WordPress.com.

If you see the following:

```shell
=== [ Fetching wordpress__ ] ===
=== [ Fetching wordpress__ ] ===
=== [ Fetching wordpress__ ] ===
```

I’m currently investigating this, and I believe this could be to do with your email address containing `+` e.g. `joe+wordpress@example.com`

If you got stuck, you can check out the following Git hash: [`3ee8aae5e0c8d6f45127963f776fd1c9358dd647`](https://github.com/booyaa/wordsby/commit/3ee8aae5e0c8d6f45127963f776fd1c9358dd647)

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- *Setup*
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- [Summary](/2019/gatsby-wordpress-summary)