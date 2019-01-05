---
permalink: "/2018/rust2018-a-year-of-talks"
title: Rust2018 - A year of talks
published_date: "2018-01-28 19:49:54 +0000"
layout: post.liquid
categories: [ rust,talks,community,meetups ]
data:
  route: blog
  tags: "rust,talks,community,meetups"
---
Background: This my blog post for the Rust team's [request](https://blog.rust-lang.org/2018/01/03/new-years-rust-a-call-for-community-blogposts.html) for community blog posts.

Before I address my hopes for Rust in 2018, I thought I'd look back at a year of meet ups that we've organised for London's Rust [user group](https://www.meetup.com/Rust-London-User-Group).

##  meet_ups.len() // The Numbers Don't Lie

We had 7 talks with an average RSVP of 56 people per meet up. There were 6 "Hack and Learn" events (where we work on Rust together) with an average RSVP of 30 people per meet up. Finally we hosted our year end "Show and Tell" (lightning talks, where no demo is too small) with 22 RSVPs. 

That's 14 events, which given that we ran out of speakers (more on this later) was an amazing achievement!

Furthermore I feel we gave our user group a choice to either listen to talks about Rust, or what I'm sure is preferable to most, to hack on Rust!

I'm particularly fond of the "Show and Tell" because it's a relaxed format that allows people to try things out. We've had a few people go on to do main talks, so I feel it's a confidence booster.

## str::replace("These are a few of my Favourite Things", "hing", "alk")

I've loved all the talks that I've heard this year, but here are a few that stood out.

- Jonathan Pallant (JPster) - [Embedded Rust Talk (video)](https://skillsmatter.com/skillscasts/9817-february-rust-meetup) - This was my first example of Rust running on embedded hardware (vs talking to a server via serial). This has so far been our only talk involving physical computing, I hope it's not the last!
- Niko Matsakis - [Compiler Internals (video)](https://skillsmatter.com/skillscasts/10868-inside-the-rust-compiler) - Not our first remote talk, but certainly the most exciting because it was provided by a member of the core team. Trivia: this wasn't the first time Niko had given a talk to our group. Over a year ago he along with a sizable contingency of the core team descended upon our humble group and gave us a serious overload of Rust! You can see those videos [here](https://skillsmatter.com/meetups/8173-state-of-rust-2016-and-how-to-create-webservices-in-rust). 
- Pete Hayes - [Intecture 2: Tokio Drift (video)](https://skillsmatter.com/skillscasts/11038-intecture-2-tokio-drift) - In [2016 (video)](https://skillsmatter.com/skillscasts/8311-rust-london-meetup) Pete introduced us to his product Intecture. In 2017 he came back to show us his progress, which was pretty exciting, and included replacing a lot of zeromq with Tokio!

# Lessons learnt

I need to improve my time keeping; we've been close to being kicked out of the venue because we've run so late. So to address this I plan to nominate someone as time keeper.

Our remote speaking set-up isn't ideal. I'd love to use Mozilla's Vidyo, but licenses don't extend to meet ups. Also Google hangout's UI is so counter-intuitive (don't @ me) that frequently new users end up not screen switching and you spend the first 5 minutes with a very personal face to face chat.

I'm going to try Zoom, but if you have something you swear by that ideally allows 2 way video and screen sharing, drop me a note!

On the subject of remote speakers, if you're lucky enough to have excellent A/V team who provide 2 way audio this is almost as good as having your speaker there with you. If we hadn't made use of remote speakers, I'm certain we'd have fewer meet ups in 2017. Turns out even the capital only has a finite number of people who can and want to talk about Rust!

# So what's in store for the talks meetup in 2018?

My overarching goal is to encourage female and non-binary attendees to come to our meetups. Currently the percentage is under 3%. It would be great to get to 51%, to prove that the Rust community is as welcoming and supportive as we'd like to be.

I'm going to be relying on the kindest of friends to help me achieve this, and I'll follow this post up with an outline of the actual plan.

My stretch goals are:

- Produce more home grown speakers i.e. from our attendee list.
- Try out the [Fishbowl](https://skillsmatter.com/skillscasts/8311-rust-london-meetup) (thanks Florian) and [Open Space](https://en.wikipedia.org/wiki/Open_Space_Technology) format meet ups.
- Find a better way to solicit feedback about the events, speakers and suggestions.

# Thanks

Before I end this blog, I'd like to thank the following group of people without whose help these meet ups wouldn't happen.

- Christian, my fellow organiser, who single handledly took on the Hack and Learn meet ups and has had equally great success.
- Skillsmatter for hosting us and providing video recordings. I'd like to single out the A/V team in particular who were unfazed by any of our display connectivity issues and remote talk quirks.
- Speakers for taking the time to talk about your passion project.
- The attendees for being the vital ingredient to make a meet up successful.

# You're still reading?

Then why not enjoy our recorded talks from 2017!

- February 
  - Jonathan Pallant - [Embedded Rust Talk (video)](https://skillsmatter.com/skillscasts/9817-february-rust-meetup)
- May - Blockchains (only themed event) 
  - Parity Tech - [Building blockchains at Parity Technologies (video)](https://skillsmatter.com/skillscasts/10194-building-blockchains-at-parity-technologies)
  - MaidSafe - [Building the SAFE Network in Rust (video)](https://skillsmatter.com/skillscasts/10209-building-the-safe-network-in-rust)
- July
  - Me - [Generator X: The State of Rust Static Site Generators (video)](https://skillsmatter.com/skillscasts/10589-london-rust-meetup-14)
 - August
   - Aidan Hobson Sayers - [Rewrite it in Rust? Some experiences in journeys from C and C++ (video)](https://skillsmatter.com/skillscasts/10663-rewrite-it-in-rust-some-experiences-in-journeys-from-c-and-c-plus-plus)
   - Me - [Rust Language Server And You! (video)](https://skillsmatter.com/skillscasts/10664-rust-language-server-and-you)
- September
  - Niko Matsakis - [Compiler Internals (video)](https://skillsmatter.com/skillscasts/10868-inside-the-rust-compiler)
  - Amanieu d'Antras - [Intrusive collections for Rust (video)](https://skillsmatter.com/skillscasts/10911-intrusive-data-structures-for-rust)
  - David Harvey-Macaulay - [three-rs: High-level 3D in Rust (video)](https://skillsmatter.com/skillscasts/10925-three-rs-high-level-3d-in-rust)
- October
  - David Dawson - [Building Message and Event based APIs using Muon - Rust Edition (video)](https://skillsmatter.com/skillscasts/10898-building-message-and-event-based-apis-using-muon-rust-edition)
  - Diane Hosfelt - [Attacking Rust for Rust for Fun and Profit (video)](https://skillsmatter.com/skillscasts/11037-exploiting-rust-for-fun-and-profit)
  - Pete Hayes - [Intecture 2: Tokio Drift (video)](https://skillsmatter.com/skillscasts/11038-intecture-2-tokio-drift)
- November
  - Apoorv Kothari - [Ownership, the Core Principal of API Design (video)](https://skillsmatter.com/skillscasts/10897-ownership-the-core-principal-of-api-design)

# Comments or feedback?

Here's the [URLO thread](https://users.rust-lang.org/t/rust2018-a-year-of-talks/15316) to do this.

# FIN

  honest.
