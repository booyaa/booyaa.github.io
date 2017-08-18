extends: post.liquid
title: Troubleshooting RLS
date: 18 Aug 2017 08:36:53 +0100
path: 2016/troubleshooting-rls
tags: rls,vscode,help
---

This post is tailored towards the official Visual Studio Code extension, but
where possible I'll let you know when you can run this against your own setup.

### Up to date mantra

- Always have the latest version of Rust nightly and RLS. `rustup update`
- Keep Visual Studio Code and the Rust RLS extension up to date.

### Increase logging level

To turn on the fire hose:
`RUST_LOG=rls=debug code .`

To reduce the noise you can drop down to informational:
`RUST_LOG=rls=info code .`

This assumes you have the Visual Studio Code command line tools to allow you to 
launch the editor in your terminal.

Diagnostics will appear in the Output panel in the Rust Language Server.

This can also be used for other editors, just replace `code` with your own
editor.

### Additional configuration settings

In your user or workspace settings (`settings.json`) add the following 
configuration parameters:


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

Both of these will require a restart of the editor. If your LSP client
implements the
[`workspace/didChanceConfiguration`](https://github.com/Microsoft/language-server-protocol/blob/master/protocol.md#workspace_didChangeConfiguration)
method, then add the same keys to your client's configuration file.

Alternative send the abovementioned method and that example json fragment to
RLS.