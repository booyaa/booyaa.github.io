permalink: "/2018/rust2018-a-year-of-talks"
title: Rust2018 - A year of talks
published_date: "2018-01-17 07:42:54 +0000"
layout: post.liquid
categories: [ rust,talks,community,meetups ]
is_draft: true
data:
  route: blog
  tags: "rust,talks,community,meetups"
---
Background: This my blog post for the the Rust team's [request](https://blog.rust-lang.org/2018/01/03/new-years-rust-a-call-for-community-blogposts.html) for community blog posts.

Before I address my hopes for Rust in 2018, I thought I'd look back at a year of meet ups that we've organised for London's Rust [user group(https://www.meetup.com/Rust-London-User-Group)].

##  meetups.len() // The Numbers Don't Lie


We had 7 talks with an average RSVP of 56 people per meet up. There were 6 "Hack and Learn" events (where we work on Rust together) with an average RSVP of 30 people per meet up. Finally we hosted our year end "Show and Tell" (lightning talks, where no demo is too small) with 22 RSVPs. That's 14 events, which is an amazing achievement and given that we ran out of speakers (more on this later). Furthermore I feel we gave our user group a choice to either listen to talks about Rust, or what I'm sure is preferably to most to hack on Rust!

I'm particular of the "Show and Tell" because it's relaxed format allows people to try things out, we've had a few people go on to do main talks, so I feel it's a confidence booster.

## str::replace("These are a few of my Favourite Things", "hing", "alk")

I've loved all the talks that have been given, but ultimate there are some favourites:

- Jonathan Pallant (JPster) - [Embedded Rust Talk (video)](https://skillsmatter.com/skillscasts/9817-february-rust-meetup) - This was my first example of Rust running on embedded hardware and not via serial. This has so far been our only talk involving electronics!
- Niko Matsakis - [Compiler Internals (video)](https://skillsmatter.com/skillscasts/10868-inside-the-rust-compiler) - Not our first remote talk, but certainly the exciting because it provided by a member of the core team. Trivia: this wasn't the first time Niko had given a talk to our group. Over a year a go he along with a sizable contingency of the core team descended upon our humble group and gave us a serious overload of Rust! You can see those videos here. 

# Lessons learnt

## time keeping

## better remote speaker experience


# So what's in store for 2018?

- 51% attendees will be female (should I be using identify as female) or non-binary
  - Will be lots of friends to help me achieve, but I plan to have an official CoC. We've been very lucky so far to not have an incident.
  - Extend the team so we can respond to CoC violations, but also to share the work load (compere, admin, speakers).
  - Workshops to introduce people to Rust. Conferences and other interested user groups.
- More home grown speakers.
- Rust Bridge 

# Thanks

- Skillsmatter for hosting us and provide video recordings. I'd like to single out the A/V team who were unfazed by any of our display connectivity issues and remote talk quirks.
- Speakers for taking the time to talk about your passion project.
- You for attending!

------------

# raw data

During 2017 we managed to host 14 meet ups:
- 7 x talks 34, 63, 41, 74, 66, 55, 65 = 395 / 7 = 56.85 avg
- 6 x hack and learns 62, 22, 24, 22, 19, 35 = 184 / 6 = 30.66 avg
- 1 x show and tell 22


# Talks (have a bookmark collection called [MyRust2018BlogPost])
- Jan 62 hl
- Feb 34 t 
  - Jonathan Pallant - [Embedded Rust Talk (video)](https://skillsmatter.com/skillscasts/9817-february-rust-meetup)
- May 63 t Blockchains (only themed event) 
  - Parity Tech - [Building blockchains at Parity Technologies (video)](https://skillsmatter.com/skillscasts/10194-building-blockchains-at-parity-technologies)
  - MaidSafe - [Building the SAFE Network in Rust (video)](https://skillsmatter.com/skillscasts/10209-building-the-safe-network-in-rust)
    - First remote talk, learnt a lot. Back channel, screen size, etc, remote talking is hard.
- Jul 41 t
  - Me - [Generator X: The State of Rust Static Site Generators (video)](https://skillsmatter.com/skillscasts/10589-london-rust-meetup-14)
    - This triggered a lot of talk from the static site generators, which was useful.
 - Aug 74 t
   - Aidan Hobson Sayers - [Rewrite it in Rust? Some experiences in journeys from C and C++ (video)](https://skillsmatter.com/skillscasts/10663-rewrite-it-in-rust-some-experiences-in-journeys-from-c-and-c-plus-plus)
   - Me - [Rust Language Server And You! (video)](https://skillsmatter.com/skillscasts/10664-rust-language-server-and-you)
- Aug 22 hl
- Sep 24 hl
- Sep 66 t
  - Niko Matsakis - [Compiler Internals (video)](https://skillsmatter.com/skillscasts/10868-inside-the-rust-compiler)
  - Amanieu d'Antras - [Intrusive collections for Rust (video)](https://skillsmatter.com/skillscasts/10911-intrusive-data-structures-for-rust)
  - David Harvey-Macaulay - [three-rs: High-level 3D in Rust (video)](https://skillsmatter.com/skillscasts/10925-three-rs-high-level-3d-in-rust)
- Oct 22 hl
- Oct 55 t
  - David Dawson - [Building Message and Event based APIs using Muon - Rust Edition (video)](https://skillsmatter.com/skillscasts/10898-building-message-and-event-based-apis-using-muon-rust-edition)
    - Allowing people to pitch their projects and make a request for contributors
  - Diane Hosfelt - [Attacking Rust for Rust for Fun and Profit (video)](https://skillsmatter.com/skillscasts/11037-exploiting-rust-for-fun-and-profit)
    - Need a better remote talk experience
  - Pete Hayes - [Intecture 2: Tokio Drift (video)](https://skillsmatter.com/skillscasts/11038-intecture-2-tokio-drift)
    - An update from our favourite project!
- Nov 65 t
  - Apoorv Kothari - [Ownership, the Core Principal of API Design (video)](https://skillsmatter.com/skillscasts/10897-ownership-the-core-principal-of-api-design)
- Nov 19 hl
- Dec 35 hl
- Dec 22 st
  - Sam Scott - [libpasta](https://libpasta.github.io/)
  - Matt Williams - [swagger codegen (rust)](https://github.com/swagger-api/swagger-codegen)
  - Aidan Hobson Sayers - [Frametool the Fantastic](https://docs.google.com/presentation/d/1I7PZwEvDIzTZl3NC1yhd_eCAu7fqwBEKCFAhGXrz7XM/)
  - Samuel Hockham - [Caper, a minimalist game engine](https://github.com/shockham/caper)
  - Ema 
     - [persy.rs - an amazing desktop ui library](http://persy.rs/)http://relm.ml/relm-intro, 
     - [fractal - Matrix client](https://gitlab.gnome.org/danigm/fractal)
     - [cobalt](https://github.com/cobalt-org/cobalt.rs)
  - Me
    - Turtle and the new wasm-unknown-unknown lightning talks