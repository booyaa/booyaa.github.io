---
permalink: "/2018/run-rust-in-openfaas"
title: How to run Rust in OpenFaaS
categories:
  - "openfaas,faas,functions,serverless,rust"
published_date: "2018-08-04 15:04:47 +0000"
layout: post.liquid
is_draft: false
data:
  route: blog
  tags: "openfaas,faas,functions,serverless,rust"
---
I’ve been getting into Kubernetes in a big way, this is partly thanks to it being bundled in [Docker for Mac Edge][link_docker_mac] edition.

Once I'd learnt the basics via [Kubernetes by Example][link_kbe], I wanted to learn a bit more about the specifics of the Kubernetes that is bundled with Docker. I found Alex Ellis' [blog post][link_install_openfaas] incredibly helpful.

I also credit this blog post for getting me into [OpenFaaS][link_openfaas] and Serverless Functions.

This blog post expands on a [tweet][link_twitter] I wrote last sunday:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Okay time to end this hacking sesh, with Rust in <a href="https://twitter.com/openfaas?ref_src=twsrc%5Etfw">@openfaas</a>! Code is very rough, needs cleaning up before I offer it up as a contribution. I plan to write a blog  post during the week about how I got this working! <a href="https://twitter.com/hashtag/rustlang?src=hash&amp;ref_src=twsrc%5Etfw">#rustlang</a> <a href="https://twitter.com/hashtag/Serverless?src=hash&amp;ref_src=twsrc%5Etfw">#Serverless</a> <a href="https://twitter.com/hashtag/k8s?src=hash&amp;ref_src=twsrc%5Etfw">#k8s</a> <a href="https://t.co/jOSRum8gfa">pic.twitter.com/jOSRum8gfa</a></p>&mdash; ɥǝɯ uıɥsnɯs sı ɥǝddnd loɯs dlɐɥ (@booyaa) <a href="https://twitter.com/booyaa/status/1023604086644633602?ref_src=twsrc%5Etfw">July 29, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

I had just created a proof of concept Rust function template for OpenFaas.

Since then I've been able to clean up the template and come up with a more substantial example. At the time I tweeted my success, Alex (OpenFaaS maintainer) told about Erik Stoekl's [version][link_erik]. It's reassuring to see we didn't differ too greatly.

## What are Functions

Functions in the context of Functions as a Service, or Serverless Functions, becomes the next level of abstraction after Platforms as a Service (PaaS). If you think of PaaS as a way to simplify the software release process: you make changes to code, you merge them into your master branch, PaaS handles packaging, delivery of the software as well as providing servers tailored to your application.

Functions take this abstraction further, but removing concerns around how your software interacts with its environment. You no longer consider issues of RBAC, Presentation (webserver, stdio), you just write the minimum amount of code to get things done.

The best summation of what FaaS and to an extent what Microservices are was coined by Ian Cooper. To paraphrase him: Your unit tests are your functions. You do not have concerns about things outside of the function's task.

## What is OpenFaaS

OpenFaaS is an open source implementation of Function as a Service (Serverless Functions, microservices) that you can self host. Rather than list all the various offerings in this space, I'll refer you to the [Cloud Native Computing Foundation][link_cncf_landscape], in particular the [interactive Landscape][link_cncf_landscape].
 
You can either deploy existing [functions][link_openfaas_store] or create new ones. If you create new ones, there's a big list of officially supported languages. Alternative you could turn a [CLI into function][link_openfaas_cli].

Once I'd given Python and Ruby a go as an introduction, I wanted to see how easy it would be to create a Rust template.

## Anatomy of an OpenFaaS template

A template requires the following:

- a script/program to act as a driver for the function. This code will not be seen or used by end users using your tempate
- a script/program with a `handle` function that will provide the boilerplate for your end users
- a `Dockerfile` that will bundle and build the driver and function, as well as installing a watchdog process (more on this later).
- a `template.yml` which at minimum should provide the programming language of the template and the code to start the handler.

## Decisions behind the design of the Rust template

To create a Rust template, I created two crates (we'll discuss the functionality later on):

- the `main` crate acts as the driver for the function
- the `function` crate contains the library with the `handle` function

I used `cargo new` to create the new crates and to provide all the necessary plumbing required for a Rust project.

Important note about the `function` crate. OpenFaaS expects to find a folder called `function`, if you call it anything else it will not copy the boilerplate code when a new function is created using the template.

The `main` crate pulls in the `function` crate as a dependency using a relative path.

`Cargo.toml` (some sections omitted)

```toml
[dependencies]
handler = { path = "../function" }
```

For the `Dockerfile`, I went for the [official][link_rust_docker] stable image of Rust.

### The flow of function

The driver reads standard input and passes to the function.

```rust
use std::io::{self, Read};

extern crate handler;

fn main() -> io::Result<()> {
    let mut buffer = String::new();
    let stdin = io::stdin();
    let mut handle = stdin.lock();

    handle.read_to_string(&mut buffer)?;

    Ok(())
}
```

I copied this code from the standard library [documentation][link_rust_docs].

The function parses the input and returns its output to the driver.

```rust
pub fn handle(req : String) -> String {
    req
}
```

## Demonstration

```shell
faas-cli template pull https://github.com/booyaa/openfaas-rust-template
faas-cli new trustinrust --lang rust
```

Here's what our folder structure looks like.

```shell
.
├── trustinrust
│   ├── Cargo.toml
│   └── src
│       └── lib.rs
└── trustinrust.yml
```

You want to edit `trustinrust.yml` and update the following values (other parts of the code have been omitted):

```yml
provider:
  gateway: http://127.0.0.1:31112

functions:
  shuffle:
    image: DOCKER_ID/shuffle
```

The `gateway` assumes you're running on port 8080, kubernetes runs on a different port. 

I also found the containers couldn't find the local repository so adding your docker id to the `image` ensures it uploads to [Docker Hub][link_docker_hub] instead.

The `trustinrust` folder contains the boilerplate code from the `function` crate.

For our demo, we're going to make a function that shuffle a list of items that are comma separated.

We'll add `rand` crate to our dependancies in the `Cargo.toml`. As you can see we're pretty much writing standard Rust, add in libraries as we need them.

```toml
[dependencies]
rand = "0.5.1"
```

Here's the code that's going to go in `src/lib.rs` (apologies for my awful Rust)

```rust
extern crate rand;

use rand::{thread_rng, Rng};

pub fn handle(req : String) -> String {
    let mut rng = thread_rng();
    let split = req.split(",");
    let mut vec: Vec<&str> = split.collect();
    rng.shuffle(&mut vec);
    let joined = vec.join(", ");
    format!("{:?}", joined)
}
```

If you wanted, you can run `cargo build` to see if the code will build. If you had tests, this would be testable via `cargo test`.

Now we can build, push the image to Docker Hub and deploy to OpenFaaS.

```shell
faas-cli build -f trustinrust.yml
faas-cli push -f trustinrust.yml    # pushes image to docker
faas-cli deploy -f trustinrust.yml
```

Finally we can test our function!

```shell
curl -d 'alice,bob,carol,eve' \
> http://localhost:31112/function/trustinrust

"bob, alice, eve, carol"
```

## Summary

It was a lot of fun experimenting with serverless functions and Rust. I can see the appeal of serverless functions, reducing functionality to the absolutely minimum. I think my next foray into this space is to see if I can convert my Slack slash commands into serverless functions (they're currently hosted on Heroku).

If you have to go for yourself, the template and demo function can be found below:

- Template: [github.com/booyaa/openfaas-rust-template][link_rust_template]
- Trust in Rust function: [github.com/booyaa/trustinrust][link_openfaas_demo]

## Further reading

If you want to learn more you should look out for videos by the Kubernetes Legend Kelsey Hightower. I can highly recommend [Kubernetes For Pythonistas][link_kelsey], which features the now-famous Tetris analogy for DevOps. Also seek out Alex Ellis on the youtubes and his excellent collection of [Docker, Kubernetes and OpenFaaS][link_youtube_alex] videos.

[link_kbe]: http://kubernetesbyexample.com/
[link_helm]: https://helm.sh/
[link_openfaas]: https://www.openfaas.com/
[link_openfaas_cli]: https://blog.alexellis.io/cli-functions-with-openfaas/
[link_openfaas_store]: https://github.com/openfaas/store
[link_install_openfaas]: https://blog.alexellis.io/docker-for-mac-with-kubernetes/
[link_rust_docker]: https://hub.docker.com/_/rust/
[link_docker_hub]: https://hub.docker.com/
[link_rust_docs]: https://doc.rust-lang.org/std/io/struct.Stdin.html#examples
[link_docker_mac]: https://docs.docker.com/docker-for-mac/kubernetes/
[link_kelsey]: https://youtu.be/u_iAXzy3xBA
[link_lambda]: https://aws.amazon.com/lambda/
[link_google_cloud_functions]: https://cloud.google.com/
[link_microsoft_azure_functions]: https://azure.microsoft.com/en-us/services/functions/
[link_youtube_alex]: https://www.youtube.com/watch?v=0DbrLsUvaso
[link_erik]: https://github.com/ericstoekl/faas-custom-templates
[link_cncf]: https://www.cncf.io/
[link_cncf_landscape]: https://landscape.cncf.io/
[link_twitter]: https://twitter.com/booyaa/status/1023604086644633602
[link_rust_template]: https://github.com/booyaa/openfaas-rust-template
[link_openfaas_demo]: https://github.com/booyaa/trustinrust