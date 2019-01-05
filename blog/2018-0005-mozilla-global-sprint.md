---
permalink: "/2018/2018-0005-mozilla-global-sprint"
title: Mozilla Global Sprint
categories:
  - "rust,mozilla"
published_date: "2018-05-13 16:29:50 +0000"
layout: post.liquid
is_draft: false
data:
  route: blog
  tags: "rust,mozilla"
---
I wanted to share my experience of participating at [Mozilla's Global Sprint 2018][link_mozsprint_2018]. The Global Sprint runs once a year and is a two day hackathon event. The projects you can work on, have a central focus of promoting a healthy Internet.

At last count there were 145 projects that you could participate in during the sprint, including a certain project called: [Content-o-Tron][link_cot], but more on this later!

## Open Leaders Programme

A significant amount of the projects that were submitted for this year's sprint came from an excellent programme run by Mozilla called [Open Leaders][link_mol]. This is a 14-week online course on working open, which will help you take an idea and turn it into a project that is ready to accept contributors from all over the world.

I've participated in lots of Open Source projects, and even created a few of my own. So you would think I would be well versed in "Working Open", but this course has taught me so much more!

I plan to write a separate blog post about the programme, but I will say that if you are looking to harness the power of crowd sourcing, I recommend that you [apply][link_mol] when applications are accepted in 2019!

## Content-o-Tron

[Content-o-Tron][link_cot] is the evolution of an idea that I submitted as part of my application for the [Open Leaders][link_mol] programme. 

Whilst on the programme, I have watched my project evolve from something that would generate more "Rust" content into a toolkit that can be used to grow diversity and inclusivity in communities.

My personal ambition is for this project to be a stand alone resource that can referenced like [Open Leaders][link_mol] or [RailsBridge][link_railsbridge].

## A Sprint Finish for Content-o-Tron

### Pre-sprint

A few weeks before the sprint, I started creating tasks (GitHub issues) labelled as ![good_first_issue](https://img.shields.io/badge/-good%20first%20issue-7057ff.svg). Previously these would've been tasks that I would fixed myself (fix typos, or write introductory text), but it was time to start sharing the work.

I also spent a lot of time spamming [twitter][link_twitter] and keeping a thread of all related #mozsprint tweets.

### Sprint-eve

Support from friends and family is incredibly important. I had a big confidence boost, when my friend [Florian][link_twit_flo] told me he would be checking in occassionally and helping out with a few of the tasks!

### Sprint Days

I was planning to use [IRC][link_wiki_irc] as a way to coordinate with contributors in real time (versus commenting in GitHub Issues). In the end I decided to use [gitter][link_gitter], because I felt it would be easier to setup (it's web based) and has a good initial user experience. Also most of the sprint participants would already have GitHub accounts (which is a single sign on option in gitter).

I also created a tracking issue for the [Global Sprint][link_mozsprint]. This is an issue where people go to register their intent to help out on the project. I then used [bit.ly][link_bitly] to create a memorable URL to this tracking issue  (`bit.ly/cot-sprint-18`) so it would be easier to share out during our video call "pitches".

It wasn't long before people started to contribute, it was interesting to see the team dynamics change as more people started to join. I like to think that because myself and Florian greeted people (in gitter) and responded to queries in a timely manner this set the tone for collaboration.

Once someone had contributed to the project I immediately made them a maintainer of the repository. I wanted to remove any potential barriers, that could prevent them from getting things done. This had the added advantage of making more reviewers for PRs.

When I resumed work on day two of the sprint, it was thrilling to see that people had continued to work on the project overnight. This meant I had provided enough work and that the instructions were clear.

Here's a snapshot of the activity on the project during the sprint. I couldn't capture the activity for the two days, so this may have included some last minutes fixes on Sprint-eve.

![github_pulse](/img/content-o-tron-pulse.png)

I did some further analysis and concluded the following occurred during the sprint.

- 11 out of 12 pull requests closed.
- 9 out of 23 tasks (issues) closed that were labelled ![mozsprint](https://img.shields.io/badge/-mozsprint-4faeb5.svg).  (excluding the tracking issue)
- 10 issues labelled as ![good_first_issue](https://img.shields.io/badge/-good%20first%20issue-7057ff.svg). .
- 4 out of 10 issues closed that were labelled ![no_code](https://img.shields.io/badge/-no%20code-fbca04.svg).  (did not require software development).
- 2 issues that were labelled ![code](https://img.shields.io/badge/-code-5e9ced.svg).  that required development. One of the issues (curation tool) is pending peer review, so could potentially be closed soon.

## Thanks

I'd like to thank the following people in making this such an awesome "Global Sprint" experience:

- The [Mozilla Global Sprint Team][link_mozsprint] for an awesome event.
- The [Mozilla Open Leaders Team][link_mol] and the cohort hosts and guest speakers. You helped me turn an idea into something that I hope will help lots of people.
- The [Content-o-Tron][link_cot] [contributors][link_cot_collab] who helped make this a truely Open project!

[link_mozsprint_2018]: https://foundation.mozilla.org/opportunity/global-sprint/2018-projects/
[link_cot]: https://github.com/rust-community/content-o-tron
[link_mol]: https://mozilla.github.io/leadership-training/
[link_railsbridge]: http://www.railsbridge.org/
[link_mozsprint]: https://foundation.mozilla.org/opportunity/global-sprint/
[link_twitter]: https://twitter.com/booyaa/status/990972718278377473
[link_twit_flo]: https://twitter.com/Argorak
[link_wiki_irc]: https://en.wikipedia.org/wiki/Internet_Relay_Chat
[link_gitter]: https://gitter.im/
[link_bitly]: https://bit.ly/
[link_gh_jdm]: https://github.com/jdm
[link_cot_collab]: https://github.com/rust-community/content-o-tron/issues/8