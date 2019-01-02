---
permalink: "/2017/vscode-rls"
title: Rust Language Server and Visual Studio Code
published_date: "2017-07-24 08:08:41 +0100"
layout: post.liquid
data:
  route: blog
  tags: "rls,rust,vscode,languageserverprotocol"
---
Click [here](#tips) to skip the history lesson and go straight to the tips.

I first heard about the Rust Language Server (RLS), via Phil Dawes' Racer talk
at the [4th London Rust User
Group](https://www.meetup.com/Rust-London-User-Group/events/229413056/).
Immediately I knew the significance of this strategy and how it would reduce
the friction required to get Rust working on the vast array of editors and
IDEs.

This was also around the same time I switched from using vim to Visual Studio
Code as my primary editor. Until code landed, I had to make do with the now
defunct Rusty Code which like all other editor add-ons requires a fair bit of
work to have a coding environment that is Rust savvy.

As soon as RLS alpha came out, I happily gave it a go (along with it's
reference Visual Studio Code extension). Eventually we'd see RLS move into the
rust-lang-nursery repo (where great ideas get incubated) and also become
another rustup component (like src).

I would flit between using the reference extension and Kalita Alexey's fork,
waiting for the day when the reference extension also got added to the [Visual
Studio Marketplace](https://marketplace.visualstudio.com/vscode).

Finally the big day has come and the reference Visual Studio Code extension has
now landed in the Marketplace! So getting Rust to work with Visual Studio Code
is super simplified. In fact I think if you already have a recent version of
rustup, installing the
[extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust)
will trigger the installation of RLS automatically!

<a name="tips"></a>
So you can imagine over time you start to gather a lot of Rust extension leavings...

I'd recommend you go through each of your workspace or user (global) settings
file and remove anything rust related.

## Rusty Code

```json
{
    "rust.racerPath": null, // Specifies path to Racer binary if it's not in PATH
    "rust.rustLangSrcPath": null, // Specifies path to /src directory of local copy of Rust sources
    "rust.rustfmtPath": null, // Specifies path to Rustfmt binary if it's not in PATH
    "rust.rustsymPath": null, // Specifies path to Rustsym binary if it's not in PATH
    "rust.cargoPath": null, // Specifies path to Cargo binary if it's not in PATH
    "rust.cargoHomePath": null, // Path to Cargo home directory, mostly needed for racer. 
                                // Needed only if using custom rust installation.
    "rust.cargoEnv": null, // Specifies custom variables to set when running cargo. Useful for 
                           // crates which use env vars in their build.rs (like openssl-sys).
    "rust.formatOnSave": false, // Turn on/off autoformatting file on save (EXPERIMENTAL)
    "rust.checkOnSave": false, // Turn on/off `cargo check` project on save (EXPERIMENTAL)
    "rust.checkWith": "build", // Specifies the linter to use. (EXPERIMENTAL)
    "rust.useJsonErrors": false, // Enable the use of JSON errors (requires Rust 1.7+). 
                                 // Note: This is an unstable feature of Rust and is still in the process of being stablised
    "rust.useNewErrorFormat": false, // "Use the new Rust error format (RUST_NEW_ERROR_FORMAT=true). 
                                     // Note: This flag is mutually exclusive with `useJsonErrors`.
}
```

## Kalita's Rust fork of the reference extension

I used the RLS integration rather than the legacy setup. The legacy setup
requires you to install rust's friends like rustfmt and racer manually.

```json
{
    "rust.rls": {
         "executable": null, // The path to an executable to execute
         "args": null, //  an array of strings. Arguments to pass to the executable
         "env": null, //  An object with the environment to append to the current environment to execute the executable
         "revealOutputChannelOn": null, // A string. Specifies the condition when the output channel should be revealed
         "useRustfmt": null // either a boolean or null. Specifies whether rustfmt should be used for formatting
    }
}
```

Finally it looks like `rls.toml` is being deprecated in favour of 
similiary named `settings.json` parameters.

so 

```toml
build_lib: false
workspace_mode: true
```

becomes

```json
{
    "rust.build_lib": false,
    "rust.workspace_mode": true,
}
```
