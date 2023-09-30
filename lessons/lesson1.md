So, Lecture 1   @here

Where: https://www.youtube.com/watch?v=iMnzwcpI1OE

Wen: Today, September 20, 6PM UTC  (you can watch anytime after the premiere)

About: 
This is an Introduction lecture to the Autumn School of Solana 2023. We will introduce the speakers, and the curriculum structure, set up a local development environment, and talk about the basics of Solana CLI to get you all set up.

# Useful links: 
Ackee Solana Handbook:
https://ackeeblockchain.com/solana-handbook.pdf
Development tools :
Rust: https://www.rust-lang.org/
Rust Analyzer: https://rust-analyzer.github.io/
Solana CLI: https://docs.solana.com/cli/install-solana-cli-tools
Anchor: https://www.anchor-lang.com/docs/installation

# log

```
(base) TounoMacBook-puro:tool toukyou$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
info: downloading installer

Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  /Users/toukyou/.rustup

This can be modified with the RUSTUP_HOME environment variable.

The Cargo home directory is located at:

  /Users/toukyou/.cargo

This can be modified with the CARGO_HOME environment variable.

The cargo, rustc, rustup and other commands will be added to
Cargo's bin directory, located at:

  /Users/toukyou/.cargo/bin

This path will then be added to your PATH environment variable by
modifying the profile files located at:

  /Users/toukyou/.profile
  /Users/toukyou/.bash_profile
  /Users/toukyou/.bashrc
  /Users/toukyou/.zshenv

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: x86_64-apple-darwin
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes

1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
>1

info: profile set to 'default'
info: default host triple is x86_64-apple-darwin
info: syncing channel updates for 'stable-x86_64-apple-darwin'
info: latest update on 2023-09-19, rust version 1.72.1 (d5c2e9c34 2023-09-13)
info: downloading component 'cargo'
info: downloading component 'clippy'
info: downloading component 'rust-docs'
 13.7 MiB /  13.7 MiB (100 %)   5.8 MiB/s in  2s ETA:  0s
info: downloading component 'rust-std'
 25.1 MiB /  25.1 MiB (100 %)   3.5 MiB/s in  7s ETA:  0s
info: downloading component 'rustc'
 55.5 MiB /  55.5 MiB (100 %)   5.1 MiB/s in 18s ETA:  0s
info: downloading component 'rustfmt'
info: installing component 'cargo'
info: installing component 'clippy'
info: installing component 'rust-docs'
 13.7 MiB /  13.7 MiB (100 %)   1.2 MiB/s in  7s ETA:  0s
info: installing component 'rust-std'
 25.1 MiB /  25.1 MiB (100 %)   9.1 MiB/s in  2s ETA:  0s
info: installing component 'rustc'
 55.5 MiB /  55.5 MiB (100 %)   9.0 MiB/s in  6s ETA:  0s
info: installing component 'rustfmt'
info: default toolchain set to 'stable-x86_64-apple-darwin'

  stable-x86_64-apple-darwin installed - rustc 1.72.1 (d5c2e9c34 2023-09-13)


Rust is installed now. Great!

To get started you may need to restart your current shell.
This would reload your PATH environment variable to include
Cargo's bin directory ($HOME/.cargo/bin).

To configure your current shell, run:
source "$HOME/.cargo/env"
(base) TounoMacBook-puro:tool toukyou$ sh -c "$(curl -sSfL https://release.solana.com/v1.16.14/install)"
downloading v1.16.14 installer
  ✨ 1.16.14 initialized
Adding 
export PATH="/Users/toukyou/.local/share/solana/install/active_release/bin:$PATH" to /Users/toukyou/.profile
Adding 
export PATH="/Users/toukyou/.local/share/solana/install/active_release/bin:$PATH" to /Users/toukyou/.bash_profile

Close and reopen your terminal to apply the PATH changes or run the following in your existing shell:
  
export PATH="/Users/toukyou/.local/share/solana/install/active_release/bin:$PATH"
```

# 
solana config get

solana config set --url https://api.devnet.solana.com
Config File: /Users/toukyou/.config/solana/cli/config.yml
RPC URL: https://api.devnet.solana.com 
WebSocket URL: wss://api.devnet.solana.com/ (computed)
Keypair Path: /Users/toukyou/.config/solana/id.json 
Commitment: confirmed 



solana config get
Config File: /Users/toukyou/.config/solana/cli/config.yml
RPC URL: https://api.mainnet-beta.solana.com 
WebSocket URL: wss://api.mainnet-beta.solana.com/ (computed)
Keypair Path: /Users/toukyou/.config/solana/id.json 
Commitment: confirmed 
