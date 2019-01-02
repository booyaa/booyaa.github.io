---
permalink: "/2017/rust-vscode"
title: Using Rust with Visual Studio Code
published_date: "2017-08-08 07:39:42 +0100"
layout: post.liquid
data:
  route: blog
  tags: "rust,vscode,tips"
---
## Which extension?

First off if you can, you should be using the Rust Language Server (RLS) [extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust). Yes it's beta, but the user experience has been the best I've had, outside of in-house language support by giants like Microsoft and JetBrains! The extension will even install dependencies for you if you have [rustup](http://rustup.rs/) installed!

If you didn't want to use RLS, then the alternative is to install various Rust related tools (racers, rustfmt and rustsym) manually. The only Rust extension that support non-RLS is [Kalita Alexey's](https://github.com/editor-rs/vscode-rust/blob/master/doc/legacy_mode/main.md).

Whilst we're on the subject of Kalita's extension, this was a fork of the [RustyCode](https://marketplace.visualstudio.com/items?itemName=saviorisdead.RustyCode) extension which was no longer being actively maintained.

The biggest draw this extension at the time was that it was available on the [Visual Studio Marketplace](https://marketplace.visualstudio.com/), where as the RLS team extension had to be manually installed via git.

It will be interesting two see how the two active extensions progress.

If you want a proper whistle stop tour of RLS I recommend you pop over to [@nrc](https://users.rust-lang.org/u/nrc) blog as he's done a thorough job of it in this [post](http://www.ncameron.org/blog/what-the-rls-can-do/). 

## Debugging

I'm ashamed to admit that I still find setting up debugging Rust a bit of a black art if you're not using gdb. However thanks to the [LLDB
Debugger](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) extension it's become a little bit easier.

The only bit that caught me out was the `launch.json` boiler plate code (see below for a sample), specifically what would be the correct value for `program` key. This is the path to your debug binary.

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "lldb",
            "request": "launch",
            "name": "Debug",
            "program": "${workspaceRoot}/<your program>",
            "args": [],
            "cwd": "${workspaceRoot}"
        }
    ]
}
```

So if the binary you wish to debug is called `foo`, your value for the `program` key would look like this:

```json
{
    "program": "${workspaceRoot}/target/debug/foo"
}
```

note: I've omitted the rest of the json keys that don't change for the sake of brevity.

If you wanted to keep things generic and only compile a binary that matches the cargo folder name, you could use `${workspaceRootFolderName}` variable substitution.

```json
{
    "program": "${workspaceRoot}/target/debug/${workspaceRootFolderName}",
}
```

If you're interested in what other variables substitutions are available the [Visual Studio Code Debugger
guide](https://code.visualstudio.com/Docs/editor/debugging#_variable-substitution) has a handy list.

One last option to enable is `sourceLanguages` with the value of `"rust"`, this option enables visualisation of built-in types and standard library types i.e. you can peek into the contents of a `Vec` etc.


Here's a complete example of the `launch.json` for reference.

```json
{
    "version": "0.2.0",
    "configurations": [

        {
            "type": "lldb",
            "request": "launch",
            "name": "Debug",
            "program": "${workspaceRoot}/target/debug/${workspaceRootFolderName}",
            "args": [],
            "cwd": "${workspaceRoot}",
            "sourceLanguages": ["rust"]
        }
    ]
}
```

