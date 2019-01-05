---
permalink: "/2017/porting-python-turtle-examples-to-turtle-rs"
title: Porting python turtle examples to turtle.rs
published_date: "2017-12-15 08:11:04 +0000"
layout: post.liquid
data:
  route: blog
  tags: "turtle,rust,python"
---
I've been tinkering around with the [Rust version](http://turtle.rs/) of [Turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics). Turtle graphics, was a key feature of the programming language [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)), and has frequently been ported to other programming languages as a visual way to teach programming.

I read somewhere that the author [Sunjay Varma](https://github.com/sunjay/turtle) of Rust port of Turtle was inspired by python's own module. 

There's a few minor cosmetic changes `pendown()` vs `pen_down()`. So I decided to have a go at running existing python examples and I came across this code from the module [documentation](https://docs.python.org/3/library/turtle.html).

```python
from turtle import *

color('red', 'yellow')
begin_fill()
while True:
    forward(200)
    left(170)
    if abs(pos()) < 1:
        break
end_fill()
done()
```

![python turtle!](/img/python-turtle.png)


The only item that threw me was the `abs(pos())`. `pos()` is an alias to the `position` method which returns the cartesian coordinates (x,y). I figured some form of special handling was taking place.

A quick search of the code.

```shell
$ python3 -v

*lots of irrelevant noise*

>>> import turtle
# /System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-tk/turtle.pyc matches /System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-tk/turtle.py
```

A quick peek at the [source code](https://github.com/python/cpython/blob/3.6/Lib/turtle.py#L265) identified the `position` method returns a class called `Vec2D`, which in turn has a definition for abs' behaviour within this class.

```python
def __abs__(self):
    return (self[0]**2 + self[1]**2)**0.5
```

My geometry is too sketch to guess at why you'd want to square the pair of cartesian coordinates, add the two numbers together. Finally exponentiation the result by 0.5, but there you go, this is what absolute value of a pair of cartesian coordinates should be.

The equivalent Rust code would look something like this:

```rust
fn abs(point : &Point) -> f64 {
    (point[0].powf(2.0) + point[1].powf(2.0)).powf(0.5)
}
```

The only method to address is `color` which in it's two parameter form sets the pen and fill colour.

```rust
fn color(turtle: &mut Turtle, pen_color: &str, fill_color: &str) {
    turtle.set_pen_color(pen_color);
    turtle.set_fill_color(fill_color);
}
```

Here's the code in it's entirety:

```rust
extern crate turtle;

use turtle::{Turtle,Point};

fn main() {
    let mut turtle = Turtle::new();
    color(&mut turtle, "red", "yellow");
    turtle.begin_fill();
    loop {
        turtle.forward(200.00);
        turtle.left(170.00);
        if abs(&turtle.position()) < 1.0 {
            break;
        }
    }
    turtle.end_fill();
}

fn abs(point : &Point) -> f64 {
    (point[0].powf(2.0) + point[1].powf(2.0)).powf(0.5)
}

fn color(turtle: &mut Turtle, pen_color: &str, fill_color: &str) {
    turtle.set_pen_color(pen_color);
    turtle.set_fill_color(fill_color);
}
```

The result is fairly close!

![rust turtle!](/img/rust-turtle.png)
