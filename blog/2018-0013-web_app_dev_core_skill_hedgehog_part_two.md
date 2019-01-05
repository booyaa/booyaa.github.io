---
permalink: "/2018/web_app_dev_core_skill_hedgehog_part_two"
title: "Being a Hedgehog - Part Two"
categories:
  - "study,learning"
layout: post.liquid
published_date: "2018-09-21 14:55:00 +0000"
is_draft: false
data:
  tags: "study,learning"
  route: blog
---

*This is part of my "Blogging my Homework" blog post series, the introductory post can be found [here](/2018/blogging-my-homework/).*

Caveat emptor: any errors or misunderstanding around concepts will almost certainly be my own rather than my employee (Made Tech). This is after all my own study and mistakes do occur during learning.

**Update 22nd of September:** I passed my Hedgehog assessment!

Welcome back to part two of my study guide for Web Application Development! In the [previous](/2018/web_app_dev_core_skill_hedgehog_part_one/) post, we covered the practical side of the assessment, this time we cover the theoretical side.

## Understanding

There are nine areas where you will be assessed (in the form of Q & A) on your knowledge of React, we’ll cover each one as a separate section.

As part of your study material for this core skill, the documentation for React is cited as a good source of information especially the [Main Concepts](https://reactjs.org/docs/hello-world.html) section. And whilst not part of the assessment you are expected to understand JSX and Elements.

If like me you haven’t touched JavaScript in a while, the React documentation provides excellent references to reacquaint yourself and to understand some of the new syntax:

References

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript
- https://gist.github.com/gaearon/683e676101005de0add59e8bb345340c


### Useful React knowledge

Whilst these are not part of the assessment, you’re expected to have an understanding of them.

#### JSX

Is short for Javascript Syntax eXtensions, it produces React “elements”.

Important: JSX is closer to JavaScript than HTML, React DOM uses `camelCase` property naming convention instead of the one used for HTML attribute. e.g. `tabindex` becomes `tabIndex`

Useful properties of JSX:

- Prevents injection attacks by escaping any values embedded before rendering
- Represents objects

References

- [Introducing JSX – React](https://reactjs.org/docs/introducing-jsx.html)


#### Elements

React elements are:

- Are plain objects and cheap to create, unlike browser DOM elements.
- Are not components (more on this later)
- Immutable, that is once created, you can’t change its children or attributes.

References

- [Rendering Elements – React](https://reactjs.org/docs/rendering-elements.html)

### Situations in which using React would be a benefit

The Learn Tech resources provide a good starting point for understanding when we should use React or in fact any type of framework behind just HTML and CSS:

- Does your application require a lot of **client-side business logic**?
- Do you need **simple and reusable components**?
- Could your application benefit from **selective reloading**? I.e. does anything on the page need to react?
- Is an existing customer development team already using **React or Node**?
- Does your application require a lot of **DOM manipulation**?
- Would the customer benefit significantly from having **fast page load times**?

The last point I feel relates to the modern framework’s build tools that are optimising pages for faster load times rather than an attribute specific to React.

Now take a moment and think about your own idea for an application, if you answered, “Yes” to most of these questions then perhaps React is the best tool.

It’s also useful to think about when it would be **inappropriate** to React, here are some examples I could think of:

- Does the application remain static after it has been built i.e. a static site generator like Jekyll?
- Does the application not require any interaction beyond page navigation?
- We want to use the latest and greatest technology!
- Javascript is everywhere, so why not just go with the flow!

The last two I paraphrased from CSS-Tricks’ excellent [When Does a Project Need React?](https://css-tricks.com/project-need-react/) article.

References

- [Web Application Development with React | Learn Tech by Made Tech](https://learn.madetech.com/core-skills/web-application-development-with-react#sections)

### What a React component is

Components allow you to split UI into independent, reusable pieces that can be worked on in isolation.

If you’ve ever done Forms or Windows application development, you can think of the controls toolbox as being analogue to components.

The React page also provides a simple analogy for components they **are like JavaScript functions**.

Convention: Component names always start with a capital letter, this is because React trees components that start with a lowercase letter as DOM tags.

Components can refer to other components for their output. The convention is to create an `App` component that calls other components. This is important to know for refactoring.

References

- [Components and Props – React](https://reactjs.org/docs/components-and-props.html)

### What are props within a component

If we continue the analogue of controls for an application, then we can think of props (short for properties) as exactly the same thing. You define the properties of a control.

An alternative view again provided by the React page is that “props” are inputs and they return a React element describing what should appear on the screen.

Important: Props are read-only if your component modifies it’s own props it is considered “impure”. You cannot break this rule in React.

References

- [Props are Read-Only – React](https://reactjs.org/docs/components-and-props.html#props-are-read-only)

### What is state within a component

States are similar to props but are private and fully controllable by the component. Recall in the last section that props are immutable that is they are read-only.

Local states are only available to JavaScript classes, they will not work for JavaScript functions.

States are private and fully controlled by the component.

- Do not modify states directly, always use `setState()`
- State updates maybe asynchronous, this is because React may batch multiple `setState()` calls into a single update for performance. Use the second form of `setState()` and pass it a function rather than an object.
- State updates are merged

References

- [State and Lifecycle – React](https://reactjs.org/docs/state-and-lifecycle.html)

### What props.children refers to

All the children of a component, children can be:

- Everything, don’t have to be other components
- Text
- JavaScript functions

React says *children are an opaque data structure* (Reach.children)

References

- [A quick intro to React’s props.children – codeburst](https://codeburst.io/a-quick-intro-to-reacts-props-children-cb3d2fce4891)
- [React This Props Children - Learn.co](https://learn.co/lessons/react-this-props-children)
- [A deep dive into children in React - Max Stoibers Blog](https://mxstbr.blog/2017/02/react-children-deepdive/)

### How React allows you to respond to user events

They act like event handling on DOM elements, there are syntactic differences:

- React events are named using camelCase rather than lower case.
- JSX you pass a function as an event handler rather than a string
- You must call `preventDefault` explicitly rather than return `false`.

References

- [Handling Events – React](https://reactjs.org/docs/handling-events.html)

### One approach to styling react components

- Inline styling
- Radium
- External stylesheets
- CSS module

References

- [Styling and CSS – React](https://reactjs.org/docs/faq-styling.html)
- [DOM Elements – React](https://reactjs.org/docs/dom-elements.html#style)
- [Styling React](https://survivejs.com/react/advanced-techniques/styling-react/#react-based-approaches)
- [Styling React Components | Jake Trent](http://stylingreact.com/)

### The component lifecycle

Lifecycle hooks are used to free up resources components when they are destroyed.

- Set up (React parlance: mounting) using the `componentDidMount` method
- Teardown (React parlance: unmounting)  using the `componentWillUnmount` method

Lifecycle methods ensure that valuable resources are freed up when a component is destroyed. By defining `componentDidMount`  (allocates) and `componentWillUnmount`  (frees) methods. This is probably analogue to programming languages that have a garbage collector.

References

- [Adding Lifecycle Methods to a Class](https://reactjs.org/docs/state-and-lifecycle.html#adding-lifecycle-methods-to-a-class)

### An approach to managing Application state

- Redux
- Context API (React)
- Component state (very basic)
- JS module singleton pattern
- Unstated
- MobX

References

- [The state of the state: React state management in 2018 - DEV Community 👩‍💻👨‍💻](https://dev.to/jpnelson/the-state-of-the-state-react-state-management-in-2018-2l0c)
- [The 5 Types Of React Application State - James K Nelson](http://jamesknelson.com/5-types-react-application-state/)
- [Application State Management – kentcdodds](https://blog.kentcdodds.com/application-state-management-66de608ccb24)
- [Managing React Application State with Mobx — Full stack tutorial (Part 1)](https://levelup.gitconnected.com/managing-react-application-state-with-mobx-full-stack-tutorial-part-1-372a7825847a)

## Further Reading

- Learning/Intro
  - [5 Practical Examples For Learning The React Framework - Tutorialzine](https://tutorialzine.com/2014/07/5-practical-examples-for-learning-facebooks-react-framework)
  - https://medium.com/in-the-weeds/learning-react-with-create-react-app-part-1-a12e1833fdc
  - [Step by Step Guide To Building React Redux Apps – rajaraodv – Medium](https://medium.com/@rajaraodv/step-by-step-guide-to-building-react-redux-apps-using-mocks-48ca0f47f9a)
  - [Make a Mobile App with ReactJS in 30 Minutes ― Scotch](https://scotch.io/tutorials/make-a-mobile-app-with-reactjs-in-30-minutes)
- Integrations w/ Web Platform
  - [Fullstack React: How to get “create-react-app” to work with your Rails API](https://www.fullstackreact.com/articles/how-to-get-create-react-app-to-work-with-your-rails-api/)
  - [Fullstack React: How to get “create-react-app” to work with your API](https://www.fullstackreact.com/articles/using-create-react-app-with-a-server/)
- VS Code
  - [Live edit and debug your React apps directly from VS Code — without leaving the editor 🔥 🎉🎈](https://medium.com/@auchenberg/live-edit-and-debug-your-react-apps-directly-from-vs-code-without-leaving-the-editor-3da489ed905f)
  - [React JavaScript Tutorial in Visual Studio Code](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial)
  - [Debugging a Create React App with VS Code · Manorisms](https://elijahmanor.com/cra-debug-vscode/)
- Misc
  - [How Airtable uses React – Matt Bush – Medium](https://medium.com/@matt_bush/how-airtable-uses-react-5e37066a87d4)