---
permalink: "/2017/youtube-dl"
title: "youtube-dl gems"
published_date: "2017-07-04 16:42:14 +0100"
layout: post.liquid
data:
  tags: "youtube-dl"
  route: blog
---
A handy collection of youtube-dl incantations, remember it's not just for 
youtube-dl! There's plenty more, but these are the one use I use on a daily 
basis.

If you're a windows users, these should work on your platform provided you change any directory references from `/` to `\`. And remove `\` and concatenate the entire incantation into a single line.

```shell
youtube-dl -F VIDEO_URL # see all video formats available for a given url

youtube-dl -f mp4 VIDEO_URL # download specific format

youtube-dl -f mp4 -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' \ 
    'YOUTUBE_PLAYLIST_URL' # downloads playlist in number order

youtube-dl --playlist-items ITEM_SPEC 'YOUTUBE_PLAYLIST_URL' \
    # download items from a playlist where ITEM_SPEC is 1,2,3 or 1-3,4,9-100 

youtube-dl --verbose --username PS_USER --password PS_PASS \
    --sleep-interval 200 -o "%(playlist)s/%(chapter_number)s.%(chapter)s/%(playlist_index)s.%(title)s.%(ext)s" \
    --restrict-filenames PLURALSIGHT_URL \
    # where PS_USER and PS_PASS are your pluralsight credentials

```
