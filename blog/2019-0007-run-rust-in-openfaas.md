--
permalink: "/2018/run-rust-in-openfaas"
title: "How to run Rust in OpenFaaS"
categories:
  - "openfaas,faas,functions,serverless,rust"
layout: post.liquid
is_draft: true
data:
  route: blog
  tags: "openfaas,faas,functions,serverless,rust"
---
I’ve been getting into Kubernetes in a big way, this is partly thanks to it being bundled in [Docker for Mac Edge][link_docker_mac] edition.

Once I'd learnt the basics via [Kubernetes by Example][link_kbe], I wanted to learn a bit more about the specifics of Kubernetes bundled with Docker. I found Alex Ellis' [blog post][link_install_openfaas] incredibly helpful.

I also credit this blog post for getting me into [OpenFaaS][link_openfaas] and Functions as a Service.

## What are Functions

Functions in the context of Functions as a Service or Serverless Functions, becomes the next level of abstraction after Platforms as a Service (PaaS). If you think of PaaS as a way to simplify the software release process: you make changes to code, you merge them into your master branch, PaaS handles packaging, delivery of the software as well as providing servers tailored to your application.

Functions take this abstraction further, but removing concerns around how your software interacts with it's environment. You no longer consider issues of RBAC, Presentation (webserver, stdio), you just write the minimum amount of code to get things done.

The best summation of what FaaS and to an extent what Mircoservices are was coined by Ian Cooper. To paraphrase him: Your unit tests are your functions. You do not have concerns about things outside of the function's task.

## What is OpenFaaS

OpenFaaS is an open source implementation of Function as a Service (Serverless Functions, microservices) that you can self host vs commercial offerings by [AWS Lambda][link_lambda]), [Google Cloud Functions][link_google_cloud_functions], [Oracle Fn][link_oracle_fn], [IBM OpenWhisk][link_ibm_openwhisk] and [Microsoft Azure Functions][link_microsoft_azure_functions].

You can either deploy existing functions or create new ones. If you create new ones, there a big list of officially supported languages. Alternative you could turn a [CLI into function][link_openfaas_cli].

Once I'd given Python and Ruby a go as an introduction, I wanted to see how easy it would be to create a Rust template.

## Anatomy of an OpenFaaS template

A template requires the following:

- a script/program to act as a driver for the function, this code will not be seen or used by end users using your tempate
- a script/program with a `handle` function, that will provide the boilerplate for your end users
- a `Dockerfile` that will bundle and build the driver and function, as well as installing a watchdog process (more on this later).
- a `template.yml` which at minimum should provide the programming language of the template and the code to start the handler.

## Decisions behind the design of the Rust template

To create a Rust template, I opted to create two crates (we'll discuss the functionality later on):

- the `main` crate acts as the driver for the function
- the `function` crate contains the library with the `handle` function

I opted for crates and followed the usual style of keep the code in `src` sub-directory and `Cargo.toml` in the root to maintain convention.

Important note about the `function` crate, OpenFaaS expects to find a folder called `function`, if you call it anything else it will not copy the boilerplate code when a new function is created using the template.

The `main` crate pulls in the `function` crate as a dependency using a relative path.

Cargo.toml (some parts omitted)

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

The function parses the input and returns it's output to the driver.

```rust
pub fn handle(req : String) -> String {
    req
}
```

## Demonstration

```shell
faas-cli template pull https://github.com/booyaa/openfaas-rust-template
faas-cli new trustinrust --lange rust
```

You want to edit `trustinrust.yml` and update the following values (other parts of the code have been omitted:

```yml
provider:
  gateway: http://127.0.0.1:31112

functions:
  shuffle:
    image: DOCKER_ID/shuffle
```

The `gateway` assumes you're running on port 8080, kubernetes runs on a different port. Also I found the containers couldn't find the local repository so adding your docker id to the `image` ensures it uploads to Docker instead.


```shell
tree trustinrust

trustinrust
├── Cargo.toml
└── src
    └── lib.rs
```    

`trustinrust` contains just the boiler plate code from the `function` crate.

We're going to amend `lib.rs` just to show we've made a change to the boilerplate.

```rust
pub fn handle(req : String) -> String {
    "lolwat:".to_owned() + &req
}
```

```shell
faas-cli build
faas-cli deploy
curl -d 'hi' http://localhost:31112/function/trustinrust
lolwat:hi
```

## Further reading

If you want to learn more you should look out for videos by the Kubernetes Legend Kelsey Hightower. I can highly recommend [Kubernetes For Pythonistas][link_kelsey]. Which features the now famous Tetris analogy for DevOps. Also see out Alex Ellis on the youtubes and his excellent collection of [Docker, Kubernetes and OpenFaaS][link_youtube_alex] videos.

[link_kbe]: http://kubernetesbyexample.com/
[link_helm]: https://helm.sh/
[link_openfaas]: https://www.openfaas.com/
[link_openfaas_cli]: https://blog.alexellis.io/cli-functions-with-openfaas/
[link_install_openfaas]: https://blog.alexellis.io/docker-for-mac-with-kubernetes/
[link_rust_docker]: https://hub.docker.com/_/rust/
[link_rust_docs]: https://doc.rust-lang.org/std/io/struct.Stdin.html#examples
[link_docker_mac]: https://docs.docker.com/docker-for-mac/kubernetes/
[link_kelsey]: https://youtu.be/u_iAXzy3xBA
[link_lambda]: https://aws.amazon.com/lambda/
[link_google_cloud_functions]: https://cloud.google.com/
[link_microsoft_azure_functions]: https://azure.microsoft.com/en-us/services/functions/
[link_oracle_fn]: http://fnproject.io/
[link_ibm_openwhisk]: https://www.ibm.com/cloud/functions
[link_youtube_alex]: https://www.youtube.com/watch?v=0DbrLsUvaso
