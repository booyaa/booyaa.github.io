permalink: "/2018/web_app_dev_core_skill_fox"
title: "Web App Development Core Skill: Fox"
categories:
  - "study,learning"
layout: post.liquid
published_date: "2018-09-28 18:31:00 +0000"
is_draft: false
data:
  tags: "study,learning"
  route: blog
---
*This is part of my "Blogging my Homework" blog post series, the introductory post can be found [here](/2018/blogging-my-homework/).*

Caveat emptor: any errors or misunderstanding around concepts will almost certainly be my own rather than my employee (Made Tech). This is after all my own study and mistakes do occur during learning.

*Updated 26th of September:* I passed by Fox assessment!

# Web App Dev Core Skills Level 2 aka Fox

This is the next level after Hedgehog, the introductory post for this core skill can be found on my previous post called [Web App Development Core Skill: Hedgehog - Part One](/2018/web_app_dev_core_skill_hedgehog_part_one). The specific of Fox can be found on [learn.madetech.com](https://learn.madetech.com/core-skills/web-application-development-with-react/#fox)

Unlike the previous level, this assessment mostly deals with purely the practical side of React development. I say mostly because there is a question around the uses of the `key` prop.

## Assumptions

In this assessment, you will be expected to continue working on your application that was started in Hedgehog.

### Storybook

As part of my actual assessment, I decided to use [Storybook](https://storybook.js.org/basics/guide-react/) to demonstrate my components whilst also showing the code in my editor. For the blog post, I made a decision to instead use [codepen.io](https://codepen.io), because I felt it was more example to show code examples rather than demonstrate Storybook.

But fear, not I will be writing a separate blog post extolling the virtues of Storybook. It's really quite amazing!

## Getting crafty with React

This assessment sees you creating components in your application and you will be assessed on the following:

- Contains a component without any props or state
- Contains a use of the `key` prop
- Contains a component which makes use of a function passed in as a prop
- Contains a component which renders differently based on state changes
- Contains a component which changes state in response to an onClick event
- Contains a component which has been styled without global styles
- Contains a component which renders differently based on the following prop types being passed in:
    - A boolean
    - A string
    - The `children` prop

There was a small theoretic piece added the assessment around what the `key` prop Is used for. We’ll address this when we demo “Contains a use of the  `key` prop”.

Now let’s tackle each part of the assessment as a separate subsection!

### Contains a component without any props or state

[codepen.io](https://codepen.io/booyaa/pen/rZbMQj)

### Contains a use of the key prop

[codepen.io](https://codepen.io/booyaa/pen/WgWaxQ?editors=0010)

References
- [Lists and Keys – React](https://reactjs.org/docs/lists-and-keys.html)
    - [Index as a key is an anti-pattern – Robin Pokorny – Medium](https://medium.com/@robinpokorny/index-as-a-key-is-an-anti-pattern-e0349aece318)
    - [Reconciliation – React](https://reactjs.org/docs/reconciliation.html#recursing-on-children)

### Contains a component which makes use of a function passed in as a prop

See the example in the next section.

### Contains a component which renders differently based on the following prop types being passed in

* A boolean
* A string
* The children prop

[codepen.io](https://codepen.io/booyaa/pen/rZbMoj)


### Contains a component which renders differently based on state changes

 [codepen.io](https://codepen.io/booyaa/pen/BOEqyg?editors=0010)

### Contains a component which changes state in response to an onClick event

[codepen.io](https://codepen.io/booyaa/pen/WgWgme?editors=0010)

References:

- [State and Lifecycle – React](https://reactjs.org/docs/state-and-lifecycle.html)

### Contains a component which has been styled without global styles

[codepen.io](https://codepen.io/booyaa/pen/NLmLEZ?editors=0010#0)

References:

- [DOM Elements – React](https://reactjs.org/docs/dom-elements.html#style)