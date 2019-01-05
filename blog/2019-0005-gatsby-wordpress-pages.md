---
permalink: "/2019/gatsby-wordpress-pages"
title: "Gatsby and WordPress: Creating WordPress Page Types"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-04 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
WordPress Pages are another [Post Type](https://codex.wordpress.org/Post_Types), they differ from Post Post(!) Types insofar that they aren’t time-related or be assigned categories and tags. Generally, they’re used for navigational items like About, Contact or Archive pages.

We’re going to update our `gatsby-node.js` to also pull in WordPress Pages so we can add an About link in our footer.

```jsx
  const createWpPages = new Promise((resolve, reject) => {
    const query = graphql(`
      {
        allWordpressPage {
          edges {
            node {
              id
              slug
            }
          }
        }
      }
    `)

    query.then(result => {
      if (result.errors) {
        console.error(result.errors)
        reject(result.errors)
      }

      const pageEdges = result.data.allWordpressPage.edges
      pageEdges.forEach(edge => {
        createPage({
          path: `/${edge.node.slug}`,
          component: path.resolve(`./src/templates/page.js`),
          context: {
            id: edge.node.id,
          },
        })
      })

      resolve()
    }) // query.then
  }) // createWpPages

  return Promise.all([createWpPosts, createWpPages])
} // createPages
```

It’s almost identical to our createWpPosts bar a few places such as query and template.

Here’s the page template `src/templates/pages.js`

```jsx
import React from 'react'
import { graphql } from 'gatsby'
import Layout from '../components/layout'

export default ({ data }) => {
  const page = data.wordpressPage
  return (
    <Layout>
      <div>
        <h1 dangerouslySetInnerHTML=&#123;&#123; __html: page.title &#124;&#124; />
        <div dangerouslySetInnerHTML=&#123;&#123; __html: page.content &#124;&#124; />
      </div>
    </Layoqut>
  )
}

export const pageQuery = graphql`
  query($id: String!) {
    wordpressPage(id: { eq: $id }) {
      title
      content
    }
  }`
```

Finally, let’s update our footer (which lives in the Layout component `src/components/layout.js`)

```html
<footer>
© 2018, Built with <a href="https://www.gatsbyjs.org">Gatsby</a> | <a href="/about">About Us</a>
</footer>
```

## Checkpoint: Let’s talk about us

If we restart Gatsby, and we’ll see a new link in our site footer.

![About Link](/img/gxw-about-link.png)

Clicking on it takes us to our newly created WordPress Page!

![About Page](/img/gxw-about-page.png)

If you got stuck, you can check out the following Git hash: [`ce6cc022a881e813af31279ff857f908ecc599f4`](https://github.com/booyaa/wordsby/commit/ce6cc022a881e813af31279ff857f908ecc599f4)

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- [Setup](/2019/gatsby-wordpress-setup)
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- *Creating WordPress Page Types*
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- [Summary](/2019/gatsby-wordpress-summary)