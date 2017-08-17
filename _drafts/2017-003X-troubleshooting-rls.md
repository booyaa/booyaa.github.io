extends: post.liquid
title: Troubleshooting RLS
date: 17 Aug 2017 08:51:33 +0100
path: 2016/troubleshooting-rls
tags: rls,vscode,help
---

This post is tailored towards the official Visual Studio Code extension, but
where possible I'll let you know when you can run this against your own setup.

### Up to date mantra

- Always have the latest version of nightly and rls. `rustup update`
- Keep Visual Studio Code and the Rust RLS extension up to date.

### Turning on diagnostics

To turn on the fire hose:
`RUST_LOG=rls=debug code .`

To reduce the noise you can drop down to informational:
`RUST_LOG=rls=info code .`

This assumes you have the Visual Studio Code command line tools to allow you to launch the editor in your terminal.

Diagnostics will appear in the Output panel in the Rust Language Server.

### Logging

In your user or workspace settings add the following configuration parameters:

```json
{
    "rust-client.logToFile" : true
}
```