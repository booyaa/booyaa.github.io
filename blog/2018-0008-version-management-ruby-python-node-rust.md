---
permalink: "/2018/version-management-ruby-python-node-rust"
title: "Version Management for Ruby, Python, Node and Rust"
categories:
  - "rust,ruby,python,version management"
published_date: "2018-08-19 15:04:51 +0000"
layout: post.liquid
is_draft: false
data:
  tags: "rust,ruby,python,version management"
  route: blog
---
Here's a handy cheat sheet if you find yourself needing an exotic version of Ruby, Python, Node or Rust. Other version management tools are available for ruby, python and node, I just happen to like these ones.

| Action                            | Ruby                 | Python               | Node                            | Rust                               |
|-----------------------------------|----------------------|----------------------|---------------------------------|------------------------------------|
| List available versions to install|`rbenv install --list`|`pyenv install --list`|`nvm ls-remote`                  | n/a                                |
| Install specific version          |`rbenv install 2.5.1` |`pyenv install 3.6.6` |`nvm install v10.9.0`            |`rustup use nightly-2018-08-01`     |
| List locally installed versions   |`rbenv versions`      |`pyenv versions`      |`nvm ls`                         |`rustup show`                       |
| Pin a project to a version        |`rbenv local 2.5.1`   |`pyenv local 3.6.6`   |`echo v10.9.0 > .nvmrc ; nvm use`|`rustup override nightly-2018-08-01`|
| Set global version                |`rbenv global 2.5.1`  |`pyenv global 3.6.6`  |n/a                              |`rustup default nightly-2018-08-01` |

## Python virtual environments

This assumes you've pinned your project to a specific version of python.

```shell
# create an virtual environment
pyenv virtualenv thingy
# activate!
pyenv activate thingy
# do your thang!
pip install pylint black pytest
# exit virtual environment
pyenv deactivate
```

## Rust components (standard libraries, RLS, clippy)

Components will install for the active toolchain (stable, nightly, beta)

To install RLS: `rustup component add rls-preview rust-analysis rust-src`

To install clippy: `rustup component add clippy-preview`

## Rust docs

Did you know you always get an off-line copy of the Rust documentation (language reference, standard library and the Rust book) suite when you install a toolchain? To open it for the active toolchain: `rustup doc`