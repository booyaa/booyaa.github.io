---
permalink: "/2017/troubleshooting-rls"
title: Troubleshooting the Rust Language Server
published_date: "2017-08-18 08:36:53 +0100"
layout: post.liquid
data:
  route: blog
  tags: "rls,vscode,help"
---
To understand how to troubleshoot the Rust Language Server (RLS), it helps to know what RLS is and how the components interact.

RLS is a Rust implementation of the [Language Server Protocol](https://github.com/Microsoft/language-server-protocol) (LSP). LSP is based on the client server architecture, and simplifies the way code editors and IDEs interact with a programming language.

The client in this instance is the official [RLS extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust). The server is `rls` which is another Rust command line tool like `rustfmt`, `racer` and `rustsym`. The extension is responsible for setting up and starting `rls`.

If you want to find out more I recommend checking out [@nrc](https://www.ncameron.org/blog/)'s introductory blog post: [What the RLS can do](https://www.ncameron.org/blog/what-the-rls-can-do/).

Whilst this post is tailored towards the VS Code extension, where possible I'll let you know when you can run this against your own setup.

## The up to date mantra

- Always have the latest version of Rust nightly and RLS. `rustup update`
- Keep Visual Studio Code and the Rust RLS extension up to date.

## Increase logging level

To turn on the fire hose:
`RUST_LOG=rls=debug code .`

To reduce the noise you can drop down to informational:
`RUST_LOG=rls=info code .`

This tip assumes you have Visual Studio Code in your path so it can be launched from the command line.

Diagnostics will appear in the `Output panel` for the Rust Language Server (the drop down to the right of the panel).

This can also be used for other editors, just replace `code` with your own editor.

## Additional configuration settings

In your user or workspace settings (`settings.json`) add the following  configuration parameters:

```json
{
    // Includes standard error from RLS in the Output panel. This isn't 
    // particular useful if you've already enabled logging at debug level.
    "rust-client.showStdErr": true,
    
    // This will also log everything that appears in the Output panel to a 
    // log file in the root of your workspace.
    "rust-client.logToFile": true,
}
```

Both of these will require a restart of the editor. If your LSP client implements the
[`workspace/didChangeConfiguration`](https://github.com/Microsoft/language-server-protocol/blob/master/protocol.md#workspace_didChangeConfiguration) method, then add the same keys to your client's configuration file.

Alternatively send the abovementioned method and that example json fragment to RLS.

## Where to go if you need more help?

[@nrc](https://www.ncameron.org/blog/) has just written the definitive guide to [debugging and troubleshooting
RLS](https://github.com/rust-lang-nursery/rls/blob/master/debugging.md). I would recommend you also visit this article.

As always with any good open source project, help is always available via a new github [issue](https://github.com/rust-lang-nursery/rls/issues/new). Alternative if you use irc, you can ask in `#rust-dev-tools` on the Mozilla network.
