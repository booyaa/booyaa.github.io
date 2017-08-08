extends: post.liquid
title: Using Rust with Visual Studio Code 
date: 8 Aug 2017 07:39:42 +0100
path: 2017/rust-vscode
tags: rust,vscode,tips
---

## Which extension?

First off if you can, you should be using the Rust Language Server (RLS)
[extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust).
Yes it's alpha, but the user experience has been the best I've had, outside of
in-house language support by giants like Microsoft and JetBrains! The extension
does everything for you if you have [rustup](http://rustup.rs/) installed!

If you didn't want to use RLS, then the alternative is to install various rust
related tools (racers, rustfmt and rustsym) manually. There's a
[guide](https://github.com/editor-rs/vscode-rust/blob/master/doc/legacy_mode/main.md)
which was part of Kalita Alexey's rust extension that provides the details.

## Debugging

I'm ashamed to admit that I still find setting up debugging Rust a bit of a
black art if you're not using gdb. However thanks to the [LLDB
Debugger](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)
extension it's become a little bit easier.

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

So the binary you wish to debug is called `foo`, your valuye for the `program` key would look like this: 

```json
{
    "program": "${workspaceRoot}/target/debug/foo"
}
```

note: I've omitted the rest of the json keys that don't change for the sake of
brevity.

If you wanted to keep things generic and only compile a binary that matches the cargo folder name, you could use `${workspaceRootFolderName}` variable substitution.

```json
{
    "program": "${workspaceRoot}/target/debug/${workspaceRootFolderName}",
}
```

If you're interested in what other variables substitutions are available the
[Debugger
guide](https://code.visualstudio.com/Docs/editor/debugging#_variable-substitution)
has a handy list.

One last option to enable is `sourceLanguages` with the value of `"rust"`, this
option enables visualisation of built-in types and standard library types. So
you can peek into the contents of a `Vec` etc.


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

