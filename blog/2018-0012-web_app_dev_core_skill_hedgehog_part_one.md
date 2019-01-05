---
permalink: "/2018/web_app_dev_core_skill_hedgehog_part_one"
title: "Being a Hedgehog - Part One"
categories:
  - "study,learning"
layout: post.liquid
published_date: "2018-09-18 08:59:00 +0000"
is_draft: false
data:
  tags: "study,learning"
  route: blog
---

_This is part of my "Blogging my Homework" blog post series, the introductory post can be found [here](/2018/blogging-my-homework/)._

Caveat emptor: any errors or misunderstanding around concepts will almost certainly be my own rather than my employee (Made Tech). This is after all my own study and mistakes do occur during learning.

# Web App Dev Core Skills Level 1 aka Hedgehog

This core skill is based around as the name suggests Web Application Development. It's focussed around the React framework because of this our chosen framework for front-end work at [Made Tech](https://www.madetech.com/).

The [first](https://learn.madetech.com/core-skills/web-application-development-with-react/#hedgehog) level of the [Web Application Development with React](https://learn.madetech.com/core-skills/web-application-development-with-react/) core skill primarily deals with setting up a new project that is ready for production use.

The core skill assessment is split into two parts: a practical demonstration (Application) and a theoretical (Understanding) in a Q & A format. I have also split the blog posts accordingly so the first part will be the practical demonstration.

## Assumptions

You have [Node](https://nodejs.org/en/) and [Docker](https://www.docker.com/) installed.

## Our application

As part of the core skill, you are expected to work on an application. My choice was to create a guiding breathing app. Why this choice of app? Well sometimes, you need to take a breather when it all gets a bit much.

More details of the will follow, but for now, it should be thought of in terms of the following:

- UI
  - Has a settings panel that allows you:
    - to define intervals between breathing in and out, and holding the breath.
    - set the volume of sounds
  - Has a timer to define how long you wish to have you're guided breathing session.
- Behaviours
  - Has a countdown timer
  - Has visual and audio cues for when for guided breathing

## Setup

- Create our app using `npx create-react-app breathe`
- Enter our app `cd breathe`
- Start our app  `npm start`

`npx` is a handy way to install and run `create-react-app`.

## Application

The practical part of the assessment has six areas where you will be assessed. I've created a header for each area.

### Has created an application that is independent of the node install on the candidate's machine

Here we are being assessed on be able to provide a reproducible build. Docker is our prefer way of doing this, there are other alternatives.

```Dockerfile
FROM node:10
WORKDIR /app
COPY package.json ./
RUN npm install
CMD ["npm", "start"]
```

The general idea behind this `Dockerfile` is to use define an image with Node, copy the `package.json`, install its dependencies and start the application.

Tip: During the early stages of prototyping I like to add `—verbose` to my `npm install`

Info: I’ve provided more information about the `Dockerfile` syntax in the references section below.

Tip: If your application has many `Dockerfile`s or related scripts, you may find it prudent to keep application and Docker artefacts separate.

Finally, we build and test our dockerized application.

```shell
docker build -t . <DOCKER_ID/MY_APP>
docker run -it --rm -p 3000:3000 -v ${PWD}/public:/app/public -v ${PWD}/src:/app/src <DOCKER_ID/MY_APP> 
```

Once the app has finished running, you can open the site using `http://localhost:3000`
![Starting up React](/img/hedgehog-001-start.png)

Tip: if you’ve done any kind of web development, you’ll have noticed that port `3000` is prevalent. Make sure you flush cookies associated with this address to avoid unexpected behaviour.

You’re probably wondering why we’re using volume mounting (`-v`) this is to enable hot re-loading (which is a requirement).

The `docker run`  feels a bit clunky, so let’s use a `docker-compose.yml`  file to simplify docker invocation.

```yaml
version: '2'
services:
  web:
    build: .
    volumes:
      - ./public:/app/public
      - ./src:/app/src
    ports:
      - "3000:3000"
```

Again we’ll re-test.

```shell
docker-compose build web
docker-compose run --rm --service-ports web
```

References

- [Dockerizing a Node.js web app | Node.js](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/)
- [Dockerfile reference | Docker Documentation](https://docs.docker.com/engine/reference/builder/)
- [Compose file version 2 reference | Docker Documentation](https://docs.docker.com/compose/compose-file/compose-file-v2/#service-configuration-reference)

### Has a make recipe for serve, which runs the application in development mode

Whilst command history is great, you want the process of building and starting of your app to be a zero effort. To do this at Made Tech we utilise `Makefile`s.

```Makefile
PHONY:docker-build
docker-build:
    docker-compose build web

PHONY:serve
serve:    
    docker-compose run --rm --service-ports web
```

In case you’re wondering why we opted for these target names, (`docker_build` and `serve`) it’s because we decided to define a standard for our `Makefile`s. This is to ensure that any engineer should be able to know without any documentation about how to build, serve and test an application. You can see our standard for `Makefile`s in our Requests of Comment repo: [Makefile Standards](https://github.com/madetech/rfcs/blob/master/rfc-012-makefile-standards.md).

If you’re wondering why we didn’t just stick our targets in `package.json`, it’s because not all our projects are node based. Whereas a Makefile can always exist in any solution.

Again we can test both these targets by the following invocations:

```shell
make docker_build
make serve
```

### Has a make recipe for test, which runs the tests for the application

Time to add `test` to `Makefile`. Our `Makefile` now looks like this:

```Makefile
PHONY:docker-build
docker-build:
    docker-compose build web

PHONY:serve
serve:    
    docker-compose run --rm --service-ports web

PHONY: test
test:
    docker-compose run --rm web npm test
```

Tip: If you want a single shot test run i.e you do not want to use the watch process, then add an environment variable called `CI` with the value `true` to `web`  section of `docker-compose.yml`

To test our target test we type `make test`

### Has a sandbox environment which allows them to quickly prototype components

For this requirement, we install Storybook.

```shell
npm i -g @storybook/cli
storybook init # assumes we're still in our app's folder
```

We also add the following scripts to `package.json`

```json
    "storybook": "start-storybook -p 9009 -s public",
    "build-storybook": "build-storybook -s public"
```

References

- [Getting started with Storybook for React](https://github.com/storybooks/storybook/tree/master/app/react#getting-started)

### Has the ability to hot-reload based on changes

You get this out of the box with React, this is done via react-scripts. If you’ve got the started via `make serve`, you can see this being demonstrated by changing the text in `src/App.js`

References

- [Disabling opening of the browser in server start · Issue #873 · facebook/create-react-app · GitHub](https://github.com/facebook/create-react-app/issues/873)
- [Configure create-react-app without ejecting ⏏ – Kitze – Medium](https://medium.com/@kitze/configure-create-react-app-without-ejecting-d8450e96196a)
- [create-react-app/README.md at master · facebook/create-react-app · GitHub](https://github.com/facebook/create-react-app/blob/master/packages/react-scripts/template/README.md)

### Has a failing test that appears when running make test

We can write a failing test by throwing an exception, which causes the test to fail immediately!

![React Test Failing](/img/hedgehog-002-test-fail.png)