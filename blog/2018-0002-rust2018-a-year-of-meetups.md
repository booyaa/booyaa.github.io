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

##  meet_ups.len() // The Numbers Don't Lie

We had 7 talks with an average RSVP of 56 people per meet up. There were 6 "Hack and Learn" events (where we work on Rust together) with an average RSVP of 30 people per meet up. Finally we hosted our year end "Show and Tell" (lightning talks, where no demo is too small) with 22 RSVPs. 

That's 14 events, which given that we ran out of speakers (more on this later) was an an amazing achievement!

Furthermore I feel we gave our user group a choice to either listen to talks about Rust, or what I'm sure is preferably to most to hack on Rust!

I'm particular of the "Show and Tell" because it's relaxed format allows people to try things out, we've had a few people go on to do main talks, so I feel it's a confidence booster.

## str::replace("These are a few of my Favourite Things", "hing", "alk")

I've loved all the talks that have been given, but there are a few that are my favourites.

- Jonathan Pallant (JPster) - [Embedded Rust Talk (video)](https://skillsmatter.com/skillscasts/9817-february-rust-meetup) - This was my first example of Rust running on embedded hardware (vs talking to a server via serial). This has so far been our only talk involving physical computing, I hope it's not the last!
- Niko Matsakis - [Compiler Internals (video)](https://skillsmatter.com/skillscasts/10868-inside-the-rust-compiler) - Not our first remote talk, but certainly the exciting because it provided by a member of the core team. Trivia: this wasn't the first time Niko had given a talk to our group. Over a year a go he along with a sizable contingency of the core team descended upon our humble group and gave us a serious overload of Rust! You can see those videos [here](https://skillsmatter.com/meetups/8173-state-of-rust-2016-and-how-to-create-webservices-in-rust). 
- Pete Hayes - [Intecture 2: Tokio Drift (video)](https://skillsmatter.com/skillscasts/11038-intecture-2-tokio-drift) - Pete gave a talk about Intecture in [2016 (video)](https://skillsmatter.com/skillscasts/8311-rust-london-meetup), he had just started out on his journey and it was nice to see his progress, which it turns out was a lot and included replacing a lot of zeromq with Tokio!

# Lessons learnt

I'm still bad at time keeping, we've still been close to being kicked out at the venue because we've ran so late. So to address this I plan this I will nominate someone as a time keeper and give them time remaining card.

Our remote speaking isn't ideal. I'd love to use Mozilla's Vidya, but licenses to extend to meet ups. Also Google hangout's UI is so counter-intuitive (don't at me) that frequently new users end up not screen switching and you spend the first 5 minutes with a very personal face to face chat.

I'm going to try Zoom, but if you have something you swear by that ideally allows 2 way video and screen sharing, drop me a note!

On the subject of remote speakers, if you're lucky to have excellent A/V support (2 way audio) this can be an equally good experience for your information hungry Rustaceans. If we hadn't made use of remote speakers, I'm certain we'd have three less meet ups for 2017. Fledging meet up groups should take note.

# So what's in store for the talks meetup in 2018?

My overarching goal will be to have an 51% average RSVPs from people who identify as female or non-binary.

I'm going to be relying on the kindest of friends to help me achieve this, and I plan to follow this post up with a further post outlining the actual plan.

My stretch goals will be:

- Produce more home grown speakers i.e. from our attendee list
- Run a RustBridge
- Host a Rust conference in the UK

# Thanks

Before I end this blog, I'd like to thank the following group of people who with out their help these meet ups wouldn't happen.

- Skillsmatter for hosting us and provide video recordings. I'd like to single out the A/V team in particular who were unfazed by any of our display connectivity issues and remote talk quirks.
- Speakers for taking the time to talk about your passion project.
- The attendees for being the last vital ingredient to make a meet up successful.

# You're still reading?

Then why not enjoy our recorded talks from 2017!

- February 
  - Jonathan Pallant - [Embedded Rust Talk (video)](https://skillsmatter.com/skillscasts/9817-february-rust-meetup)
- May 63 t Blockchains (only themed event) 
  - Parity Tech - [Building blockchains at Parity Technologies (video)](https://skillsmatter.com/skillscasts/10194-building-blockchains-at-parity-technologies)
  - MaidSafe - [Building the SAFE Network in Rust (video)](https://skillsmatter.com/skillscasts/10209-building-the-safe-network-in-rust)
    - First remote talk, learnt a lot. Back channel, screen size, etc, remote talking is hard.
- July
  - Me - [Generator X: The State of Rust Static Site Generators (video)](https://skillsmatter.com/skillscasts/10589-london-rust-meetup-14)
    - This triggered a lot of talk from the static site generators, which was useful.
 - August
   - Aidan Hobson Sayers - [Rewrite it in Rust? Some experiences in journeys from C and C++ (video)](https://skillsmatter.com/skillscasts/10663-rewrite-it-in-rust-some-experiences-in-journeys-from-c-and-c-plus-plus)
   - Me - [Rust Language Server And You! (video)](https://skillsmatter.com/skillscasts/10664-rust-language-server-and-you)
- September
  - Niko Matsakis - [Compiler Internals (video)](https://skillsmatter.com/skillscasts/10868-inside-the-rust-compiler)
  - Amanieu d'Antras - [Intrusive collections for Rust (video)](https://skillsmatter.com/skillscasts/10911-intrusive-data-structures-for-rust)
  - David Harvey-Macaulay - [three-rs: High-level 3D in Rust (video)](https://skillsmatter.com/skillscasts/10925-three-rs-high-level-3d-in-rust)
- October
  - David Dawson - [Building Message and Event based APIs using Muon - Rust Edition (video)](https://skillsmatter.com/skillscasts/10898-building-message-and-event-based-apis-using-muon-rust-edition)
    - Allowing people to pitch their projects and make a request for contributors
  - Diane Hosfelt - [Attacking Rust for Rust for Fun and Profit (video)](https://skillsmatter.com/skillscasts/11037-exploiting-rust-for-fun-and-profit)
    - Need a better remote talk experience
  - Pete Hayes - [Intecture 2: Tokio Drift (video)](https://skillsmatter.com/skillscasts/11038-intecture-2-tokio-drift)
    - An update from our favourite project!
- November
  - Apoorv Kothari - [Ownership, the Core Principal of API Design (video)](https://skillsmatter.com/skillscasts/10897-ownership-the-core-principal-of-api-design)

  # FIN

  honest.