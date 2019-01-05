---
permalink: "/2019/gatsby-wordpress-creating-content"
title: "Gatsby and WordPress: Creating Content"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-02 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
## Pulling in content from WordPress

Now that we’ve verified that the plugin can pull in data from our WordPress site, let’s start creating static content based on our posts and pages!

Let’s start with something simple and pull in the posts and display them in the developer console. This involves two steps:

- Create a GraphQL query
- Act upon the results of the query being run (in this case we’ll just display the contents of the query)

Page creation is handled by [createPages](https://www.gatsbyjs.org/docs/node-apis/#createPages) API, using promises we can perform the required steps to programmatically create pages. Let’s edit the `gatsby-node.js` add the following code.

```js
exports.createPages = ({ graphql, actions }) => {
  const createWpPosts = new Promise((resolve, reject) => {
    const query = graphql(`
      {
        allWordpressPost {
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
      console.log(JSON.stringify(result, null, 4))
      resolve()
    }) // query.then
  }) // createWpPosts

  return Promise.all([createWpPosts])
} // createPages
```

Go ahead and restart `gatsby develop`, you should see the following in your terminal:

```console
success building schema — 0.920 s
⠁ {
    "data": {
        "allWordpressPost": {
            "edges": [
                {
                    "node": {
                        "id": "51ec1d4e-7b5f-54b8-b5ea-f36aea0c1d8f",
                        "slug": "a-long-form-post"
                    }
                },
```

Whilst this is not very exciting, it confirms that we’ve been able to pull our posts from WordPress. It turns out the two fields  `id` and `slug` are just what we need to begin programmatically creating pages.

## Create pages based on Wordpress

Let’s update our code, for brevity we've omitted blocks of code that haven’t changed if you get stuck there’s a commit hash at the end of this checkpoint.

```js
const path = require('path');

exports.createPages = ({ graphql, actions }) => {
    const { createPage } = actions
  
    const createPostPages = new Promise((resolve, reject) => {
      // omitted
  
      query.then(result => {
        if (result.errors) {
          console.error(results.errors)
          reject(result.error)
        }
  
        const postEdges = result.data.allWordpressPost.edges
  
        postEdges.forEach(edge => {
          createPage({
            path: `/${edge.node.slug}`,
            component: path.resolve(`./src/templates/post.js`),
            context: {
              id: edge.node.id,
            },
          })
        })
  
        resolve()
// omitted
```

Before we create any pages, let’s do a bit of error handling and return early from our promise if we hit any errors.

Next, we extract our results into a const to make it easier to read the code.

```js
const postEdges = result.data.allWordpressPost.edges
```

You’ll recall that this is just a flattening of our GraphQL query.

```graphql
{
  allWordpressPost {
    edges {
        ...
    }
  }
}
```

We then iterate over our results calling the createPage API, which expects three parameters:

- `path` which will be used to create a page slug, WordPress already has this data, so rather than compute it ourselves let’s reuse it.
- `component` is React parlance for a unit of markup. Think of a controls toolbox with various components you can add to a form. We’ll take about this in the next section.
- `context` allows us to pass data to the component, in this case, we’ll pass the WordPress Id of our posts.

## Checkpoint: Create a blog post template

That’s a lot of information to take in, but we’re almost there!

Remember the `component` parameter from the last section?

```js
component: path.resolve(`./src/templates/post.js`),
```

Let’s go ahead and create that file `post.js`. 

Note: you’ll need to create a new subdirectory within `src` called `templates`.

`src/templates/post.js`

```jsx
import React from 'react';
import Layout from '../components/layout';

export default () => {
    return (
        <Layout>
            <div>Hello blog post</div>
        </Layout>
    )
}
```

Let’s stop and restart Gatsby:`gatsby develop`

We don’t have an index page to view our newly created post, but the Gatsby 404 development page acts as handy makeshift.

Go to a non-existent page: `http://localhost:8000/xyz`

You should now see your WordPress blog posts alongside other pages that Gatsby knows about.

![Post Template 1](/img/gxw-post-template-1.png)

You may have gathered that our current post template is pretty basic, so clicking on any of our posts will just display the same contents. The important thing to observe is that we now have pages for our WordPress posts and the template is being used for each post.

If you got stuck, you can check out the following Git hash: [`13a036ae2a8dea2ea0f7a910c35c2fe4789f9a50`](https://github.com/booyaa/wordsby/commit/13a036ae2a8dea2ea0f7a910c35c2fe4789f9a50)

## Turning that template into something useful

As you gathered from the last section, all we’ve managed to do with our template is to generate slugs. The means to pull the content is available, but we need to wire it up. Again we’ll only show you the bits you need to add/modify

```jsx
import { graphql } from 'gatsby'

export default ({ data }) => {
  const post = data.wordpressPost
  return (
    <Layout>
      <div>
        <h1 dangerouslySetInnerHTML=&#123;&#123; __html: post.title  &#124;&#124; />
        <h3>
          date: {post.date} tags: {extractTags(post)}{' '}
        </h3>
        <div dangerouslySetInnerHTML=&#123;&#123; __html: post.content  &#124;&#124; />
      </div>
    </Layout>
  )
}
```

We can see our function’s signature has changed to allow data to be passed (which will be provided by a GraphQL later on). The key things to notice here is the use of  [dangerouslySetInnerHTML](https://reactjs.org/docs/dom-elements.html#dangerouslysetinnerhtml) and the JSX [expressions](https://reactjs.org/docs/introducing-jsx.html#embedding-expressions-in-jsx) (curly brackets - looks a bit like moustache doesn’t it?).

`dangerouslySetInnerHTML` is a React’s replacement for innerHTML, why but is it dangerous? Setting HTML from code (or in this case from a database) is risky because it’s easy to expose yourself to XSS). So by using this helper you acknowledging, you’re doing something DANGEROUS, but before we complete freak out, let’s do a quick assessment of the data we’re parsing. **Our** WordPress blog, with content  **we’ve** written. So unless we have a serious case of self-loathing, it’s unlikely we’re at risk here. If you do need to parse HTML safely,  there are options like [html-react-parser](https://github.com/remarkablemark/html-react-parser)

If the field our `post` object we’re interested doesn’t have any markup, then we can use expressions to rendered them `{post.date}`. 

You can stick any valid JavaScript with these expressions and `extractTags` is a helpful function to flatten the array of tags for our posts. Here’s the definition of that helpful function (add after our default function).

```jsx
const extractTags = post =>
  post.tags ? post.tags.map(x => x.name).join(', ') : 'none'
```

Almost there, just need to add our GraphQL that will power this template.

```jsx
export const pageQuery = graphql`
  query($id: String!) {
    wordpressPost(id: { eq: $id }) {
      title
      tags {
        name
      }
      date(formatString: "Do MMMM YYYY")
      content
    }
  }
`
```

The [pageQuery](https://www.gatsbyjs.org/docs/page-query/) takes the WordPress Post Id we passed in the context when we created our static pages in `gatsby-node.js` (see below) and allows us to pull a specific WordPress post using this Id `wordpressPost(id: { eq: $id })`, we don’t need to pull everything we just need the title, tags, publish date and content. Note: we used GraphQL to format the date.

```jsx
createPage({
  path: `/${edge.node.slug}`,
  component: path.resolve(`./src/templates/post.js`),
  context: {
    id: edge.node.id,
  },
})
```

Demo: remember our friend `dangerouslySetInnerHTML`, you could avoid the risks by using expressions, but as you can see if there’s any markup it will be sanitised i.e. it will be escaped.

## Checkpoint: let’s see that content

It’s probably best we restart gatsby to see our changes.

![Post Template 2](/img/gxw-post-template-2.png)

If you got stuck, you can check out the following Git hash: [`50156723a4b21f08baeece9a5f7cd3936e384ee8`](https://github.com/booyaa/wordsby/commit/50156723a4b21f08baeece9a5f7cd3936e384ee8)

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- [Setup](/2019/gatsby-wordpress-setup)
- *Creating Content*
- [Creating an index page](/2019/gatsby-wordpress-index-page)
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- [Summary](/2019/gatsby-wordpress-summary)