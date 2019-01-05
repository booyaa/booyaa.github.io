---
permalink: "/2017/remote-speaking-tips"
title: Remote speaking tips
published_date: "2017-10-20 20:05:52 +0100"
layout: post.liquid
data:
  route: blog
  tags: "talks,publicspeaking,hangout,remote,livecoding,demo"
---
On Monday I did my first remote talk (for the [Rust
Edinburgh](https://www.meetup.com/rust-edi/) user group). I thought I'd share
my experience to help others who want to do the same.

## tl;dr - your check list:

- Get a good quality headset, don't use the internal microphone on your computer.
- Do a mirror (selfie) test, make sure there's no embarrassing stuff in the background.
- Make more slides, allow the information to trickle through to re-enforce concepts. 
- Avoid information dense slides.
- Do a test video conference call beforehand.
- Pre-bake your demos unless you're a live coding veteran.
- Don't ramble, short sound bites are more memorable.
- Practice.

## Gear

Get a decent headset, do not use your internal microphone on your computer! I
borrowed my better half's pair of [HyperX Cloud
II](https://www.amazon.co.uk/HyperX-Cloud-Gaming-Headset-Mobile/dp/B00SAYCXWG/ref=sr_1_1?ie=UTF8&qid=1508527812&sr=8-1&keywords=hyperx+ii),
they're her gaming headphones, but they also function excellently for video
conferencing.

An acceptable low-fi alternative is a phone hands free kit. The ones that come
bundled with iPhones are surprisingly good for this task.

## Setup

If this is your first time to do video conferencing, then do a mirror or selfie
test. In google hangout you can do this by clicking on the video call icon.

Look around you, is there anything that you wouldn't want to appear in the
background? Our home office is also our guest bedroom and where we keep our
clothes dryer - you get the idea.

Bonus points if you can stick cool posters or a talk related paraphernalia
(mascots and the like) in the background!

## Deck Design

This is the area that I'm still trying to master, so I will prolly revisit in a
separate post, but here's tips I was given by more experienced speakers. 

Keep the detail on each slide, light, but also have more slides to re-enforce
the concepts you're trying to get across. You no longer have the advantage of
seeing the audience reaction i.e. how well they're grasping the subject matter.
So drip feed the information, gradually.

## Google Hangouts

At the moment I'm still using Google Hangout to conduct my remote talks and to
facilitate remote speakers for the [London Rust user group](https://www.meetup.com/Rust-London-User-Group/). Provided both
parties have Chrome, it's zero software install. 

However, I do have concerns, in particular the lack of multi-display support
(more on this in a moment) and the inability to increase the size of the other
party's video window.

### Multi display (or lack of)

When doing talks in person, nearly all A/V equipment allow you to use the
projector/TV as an additional display. This allows me to configure Keynote (Mac
presentation tool) in presenter mode. The slides appear on the project/TV as
you would expect and on your own computer's display you can see the time
elapsed, next slide and presenters notes.

Google hangout allows you to share your screen in two modes: full screen or
application. Neither modes are multi display aware. This means Keynote will
only display the slides, no presentation mode! Imagine my surprise when I
discovered as I start my talk!

Luckily I had my laptop as a second computer (for my live coding script). So a
few seconds later I had the presentation on this computer with notes. The
alternative would be to use Keynote on your iOS device as a presentation
remote. You can then configure it to display your presentation notes alongside
the current slide.

### The inability to increase the size of the other party's video

This means you can't see the audience, well not well enough to know if they're
following your talk.

## Live Coding

Don't do it unless you can already touch type and talk to someone at work! It's
better to pre-record you live coding, then you can edit out pauses. You'll also
find that providing commentary is easier, when you're not worry about what to
type next.

If you do decide you want to do live coding, keep a script of what you want to
show. If it makes sense have the code snippets handy. 

My talk about was the Rust Language Server and it's integration into Visual
Studio Code, so I needed to make errors to demonstrate functionality. So code
snippets wouldn't have been useful.

If you have a suitable screen recording that also records your microphone, use
to practice. Once the lengthy pauses have stopped you're be ready!

I did do live coding, but I've done this talk twice. And I also practiced the
script everyday until I did the talk.

## Preparation

If possible do a test call before the day of the talk. This gives you time to
iron out any technical glitches. Also expect to do another setup call a few
minutes before you talk, your hosts will usually want this.

The Rust Edinburgh organisers also asked for a copy of my slides. The plan was
that if the internet connection dropped off, they would call my phone and they
would go through the slide on my behalf.

## Performance

Rambling in general is a bad idea in talks. In remote talks it can spoil your
performance. Remember you can't see your audience, if you could see the yawns
or people staring at their phones you would know you're rambling.

Finally this one is a given if you want to do talks: practice makes perfect! 

![remote talk selfie!](/img/remote_talk_selfie.png)
-- Don't forget to take an audience selfie!
