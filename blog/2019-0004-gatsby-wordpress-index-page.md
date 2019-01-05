---
permalink: "/2019/gatsby-wordpress-index-page"
title: "Gatsby and WordPress: Creating an index page"
categories:
  - "wordpress,gatsby"
layout: post.liquid
published_date: "2019-01-03 13:37:00 +0000"
is_draft: false
data:
  tags: "wordpress,gatsby"
  route: blog
---
## Order order! Let’s create an index to list our posts

Let’s visit http://localhost::8000/___graphql to fire up the builtin GraphQL explorer and paste the following query.

```graphql
{
  allWordpressPost(sort: {fields: [date], order:DESC} ) {
    totalCount
    edges {
      node {
        title
        excerpt
        slug
        date(formatString: "Do MMMM")
      }
    }
  }
}
```

Things to note here how to sort the collection of posts. If you’re wondering what fields are available,  the explorer provides documentation for any plugins you have loaded so in the case of WordPress Post we can explore this clicking on the hover dialogue for `allWordpressPost`.

Let’s update our index page (`src/pages/index.js`) to list our WordPress posts.

First, we import `graphql` and we can remove our import of `Image` component.

```jsx
import { Link, graphql } from 'gatsby'
```

Then we update IndexPage definition,  we use the `map` function transform each array item into an HTML fragment containing information about each post.

```jsx
const IndexPage = ({data}) => (
  <Layout>
    <SEO title="Home" keywords={[`gatsby`, `application`, `react`]} />
    <h1>Welcome to the Gatsby demo</h1>
    <h3>There are {data.allWordpressPost.totalCount} posts</h3>

    {data.allWordpressPost.edges.map(({ node }) => (
      <div key={node.id}>
        <Link to={node.slug}>
          <h4><span dangerouslySetInnerHTML=&#123;&#123; __html: node.title &#124;&#124;/> - {node.date}</h4>
        </Link>
        <div dangerouslySetInnerHTML=&#123;&#123; __html: node.excerpt &#124;&#124; />
      </div>
    ))}

  </Layout>
)
```

Finally, we add our pageQuery that we tested in our GraphQL explorer at the start of the post.

```jsx
export const pageQuery = graphql`
  query {
    allWordpressPost(sort: { fields: [date], order: DESC }) {
      totalCount
      edges {
        node {
          id
          title
          excerpt
          slug
          date(formatString: "Do MMMM")
        }
      }
    }
  }
`
```

## Checkpoint: Index page rebooted

If we visit `http://localhost:8000` we should see a different page to what we started at the beginning of this blog post series

![Post Template 2](/img/gxw-index.png)

If you got stuck, you can check out the following Git hash: [`2249ea842a18e4da39c6e3abcf8eeabd78a17116`](https://github.com/booyaa/wordsby/commit/2249ea842a18e4da39c6e3abcf8eeabd78a17116)

**The Gatsby x WordPress Blog Post series**

- [Keeping it cheap and staying in touch](/2019/gatsby-wordpress-keeping-it-cheap-and-staying-in-touch)
- [Setup](/2019/gatsby-wordpress-setup)
- [Creating Content](/2019/gatsby-wordpress-creating-content)
- *Creating an index page*
- [Creating WordPress Page Types](/2019/gatsby-wordpress-pages)
- [Netlify or Die!](/2019/gatsby-wordpress-netlify)
- [Yarr! Cutlasses and Webhooks!](/2019/gatsby-wordpress-cutlasses-and-webhooks)
- [Summary](/2019/gatsby-wordpress-summary)