So, Lecture 1   @here

Where: https://www.youtube.com/watch?v=iMnzwcpI1OE

Wen: Today, September 20, 6PM UTC  (you can watch anytime after the premiere)

About: 
This is an Introduction lecture to the Autumn School of Solana 2023. We will introduce the speakers, and the curriculum structure, set up a local development environment, and talk about the basics of Solana CLI to get you all set up.

# Useful links: 
## Ackee Solana Handbook:
https://ackeeblockchain.com/solana-handbook.pdf
## Development tools :
### Rust: https://www.rust-lang.org/
### Rust Analyzer: https://rust-analyzer.github.io/
### Solana CLI: https://docs.solana.com/cli/install-solana-cli-tools

linux
```
sh -c "$(curl -sSfL https://release.solana.com/v1.17.1/install)"
solana --version

tar jxf solana-release-x86_64-unknown-linux-gnu.tar.bz2
cd solana-release/
export PATH=$PWD/bin:$PATH
```

windows
```

cmd /c "curl https://release.solana.com/v1.17.1/solana-install-init-x86_64-pc-windows-msvc.exe --output C:\solana-install-tmp\solana-install-init.exe --create-dirs"

C:\solana-install-tmp\solana-install-init.exe v1.17.1

solana --version




```
### Anchor: https://www.anchor-lang.com/docs/installation

```
cargo install --git https://github.com/coral-xyz/anchor avm --locked --force

sudo apt-get update && sudo apt-get upgrade && sudo apt-get install -y pkg-config build-essential libudev-dev libssl-dev

avm install latest
avm use latest

anchor --version

```
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

```
solana config set --url https://api.devnet.solana.com
```

```
solana-keygen --version

solana-keygen new

solana-keygen new --help
solana-keygen pubkey

```



Wrote new keypair to /home/jt/.config/solana/id.json
=========================================================================
pubkey: XXXX
=========================================================================
Save this seed phrase and your BIP39 passphrase to recover your new keypair:
own decorate sorry curve kitten void roof phone pulp pledge primary abuse
=========================================================================

```
solana balance
solana airdrop 0.5
solana transfer XXXX 0.2
solana transfer XXXX 0.2  --allow-unfunded-recipient

```

```
cargo install spl-token-cli
```

```
spl-token create-token
spl-token supply YYYYYY
```
Creating token YYYYYY under program TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA

Address:  YYYYYY
Decimals:  9

Signature: 59ruFp6j9uAb5ZmLnNizLwuBTjWR4gbAcN2QwyciXQEatTspFMa2RgGTkqprCSH1pXpVFjhb5yY9YUf9W7V18wDV

```
spl-token create-account YYYYYY
```
Creating account ZZZZZ

Signature: jJmiKubLr6aDixNh5jCoQmJu4DPJddUbJNDqMpLZUQFaBHPsd4uxBvtUtGnDa2cprT7JTNgNEuVcM3VqxcVRGya

```
spl-token balance YYYYYY
spl-token mint YYYYYY 1000
```
(base) jt@jt-PC-VN770HS6W:~/project/solana-release/solana-release$ spl-token mint YYYYYY 1000
Minting 1000 tokens
  Token: YYYYYY
  Recipient: ZZZZZ

Signature: gCoZbcRpRFAZJBRpb73y8nwD4sJDtvPzCgt6VTUKxB7FSpJrsp2GEtVY9yDpXToxHdc41kquV2LjSXrNAj48ALi

```
spl-token accounts
spl-token transfer YYYYYY 50 ZZZZZ
```

```
solana program deploy
```

# 文字起こし
0:01
hello everyone and welcome to the Autumn School of Solana 2023 organized by eki
0:07
blockchain security in this first lecture we will give you an introduction to this course and what
0:13
awaits you will also set up the Solana tool chain and everything you will need for the
0:20
development and after that we will show you the materials that we have prepared
0:26
for you yeah but before we begin I would like to introduce myself my name is Adam and I'm
0:34
Solana auditor at a key blockchain and I will give you two lectures in this run
0:42
I'm really proud that we are the educational partner of Solana foundation
0:49
and that yet again we had many applicants in this run
0:54
and yeah I'm really looking forward and excited to share our knowledge and I
1:00
hope that you two will enjoy the the lectures and that even after a graduation that you will decide to
1:08
develop on Solana and that you will integrate this vibrant Solana community
1:17
yeah so really excited and now I will hand over to the stage to my colleagues
1:23
so they can make their own introduction and tell you more about a key blockchain
1:31
hey everyone I'm Andre and I will be the main speaker of school of Solana I am a
1:37
Aki blockchain fan I have worked as a Solana security Auditor in the past and
1:43
also as a full stack software engineer in both fep2 and web3 and I will do my
1:50
best to guide you through the complexities of Solana ecosystem and hopefully give you the right start to
1:57
become the next big Solana developer or security auditor so I wish you guys the
2:05
best of luck during this course and I see you during the finals
2:11
hi guys I'm Joseph I'm the co-founder and CEO of a key blockchain and I'm
2:17
happy that you joined our school of Solana I'll just briefly tell you what is the
2:23
Aki blockchain about so Aki blockchain is a cyber security company we are Auditors and researchers we are auditing
2:30
Two Chains Solana and ethereum but besides the auditing work we are also
2:36
big Believers in open source we are producing some pretty cool tooling so
2:42
for the Ethereal world it's a vs code extension called tools for solidity and
2:47
on Solana I'm happy that we've introduced the first open source fuzzer called turdonic
2:53
also we are very happy to be helping others with education uh my background
2:59
is that I am the assistant professor of Czech Technical news in Prague and we are teaching subjects blockchain uh at a
3:06
university and we are also happy that uh solar Foundation is partnering with us
3:11
it is cool and has given us the grant to be able to do this school for you for
3:17
free so I'll I hope you will have a good time and that you will succeed and you are in a good company uh yes Aki
3:24
blockchain are working with the Peer Industry players from both Solana and ethereum Wards so fingers crossed and
3:30
enjoy the school hello guys my name is Andre and I'm Solana auditor here in a keyboard chain
3:37
I will be your guide during this school of Solana run and quick motivation for
3:43
you I also participated in the previous run of school of Solana which then led
3:48
into my first Victory security job so wish you luck
3:53
hi there I'm Sasha Community manager at Accu blockchain and I welcome every one
3:58
of you to iron School of Salon in 2023 congrats for making it here should you
4:05
have any organizational questions that hit me up on Discord and good luck to all of you
4:10
and now let's jump straight in and I will give you more information about the
4:16
course and to begin I have a very important question so do you have your acceptance
4:22
badge it is very important so please verify that you have your badge in your
4:29
wallet if not then get in touch with Sasha and she will help you
4:36
it's very important because you will use this badge to verify yourself using
4:42
metrica on our Discord server and on our Discord server we will share
4:50
all the necessary information that you will need for the school so we will
4:56
share there uh the video links the tasks and most importantly you will be able to
5:03
connect with other students so you will be able to discuss
5:10
um ask questions and help each other so once again please verify that you
5:16
have your acceptance badge what is this course about
5:23
so we will be speaking about the introduction to Solana and about Solana
5:30
Core Concepts Solana programming model and about the
5:35
ecosystem we will also speak about rust but it is
5:43
it will be a brief introduction to rust and we will speak about anchor framework
5:50
that is used on Solana it is basically a standard to to develop on Solana
6:00
also we will speak about the programs in Solana on Solana we don't say smart
6:08
contracts but programs and most importantly
6:13
we hope that we will have fun and that you will build a community and that you
6:20
will be able to work together on the other hand what is this course
6:27
not about so it is not an introduction to blockchain so we expect that you have at
6:34
least some basic knowledge about blockchain or that you will be able to read some
6:44
articles about blockchain in advance it is also not an advanced rust or
6:51
Solana programming course so rust is very complicated programming
6:58
language with a steep learning curve so we will be able to touch only the basics
7:05
and the same is for Solana so the the
7:11
goal of this course is to get you started as quickly as possible but we won't be able to go in deep
7:20
details and also yeah unfortunately it is not a
7:26
recipe how to get rich in nine weeks but yeah you never know what you will uh do
7:33
uh with that what you will learn in this course
7:38
there are some prerequisites for this course uh one of them is basic
7:43
familiarity uh with CLI so we expect that you can use your terminal
7:51
that also you have basic programming knowledge in any language so most of the
7:58
applicants have experience with JavaScript or a typescript so Andre will
8:06
try to compare a rust and JavaScript and
8:12
typescript but yeah he will certainly not focus
8:17
only on these developers so don't worry if you have any other experience
8:25
and uh it's what I already said so we expect that you have at least some basic
8:31
overview of what blockchain is uh if not please try to study a little bit uh some
8:41
basic information about blockchain before the next lecture
8:49
so how does the whole school work we have
8:55
pre-recorded lessons or lectures that will be premiered on YouTube every
9:01
Wednesday and uh yeah so you will get the links in
9:08
advance all the time on a Discord on Discord they will there will be separate
9:15
channels for each lecture so you can expect to have all the information there
9:25
then similarly to the submission form that you had to fill in and then you had
9:33
to do the task on GitHub also the tasks during the school will be handled via a
9:41
GitHub classroom so after each lecture you will have a task
9:48
and again at the end of each lecture we will
9:54
tell you what is the next task in the video and finally finally we will share
10:01
the links on Discord so you will get all
10:06
the information necessary foreign will be through Discord so we uh we have
10:15
uh created the separate channels for each um for each lesson and also there will
10:24
be an issues Forum uh where you will be able to basically post your questions uh
10:33
it should be quite easy to search and filter uh you will be able to tag your
10:40
your questions based on topics and tasks so yeah we expect that most of the
10:49
questions should be clarified on Discord maybe if there will
10:55
be many open points we will schedule some on-demand ask me anything sessions
11:01
where we will go through the open points but this will be also announced on
11:09
Discord and yeah one important point is that we
11:17
have different students of course with different experience so uh yeah if you feel
11:23
confident that you already know something or that you already have some previous experience maybe with rust or
11:30
Solana then yeah just do the course and
11:36
do the lectures on your own pace you can even skip the the videos if you are
11:44
confident enough the only requirement is to submit the tasks and work together so
11:54
uh we decided to have the lectures pre-recorded because then you can easily
12:01
go back and review the the lecture whenever it is
12:07
[Music] whenever you are available
12:12
and if it is too slow or too fast then
12:19
it really depends on you how you will watch the the lectures or not
12:29
foreign School you will receive
12:35
a certificate certificate if you will satisfy the the requirements
12:43
and basically there will be seven lectures and some bonus lectures
12:50
the seven lectures will be graded based on tasks that you will receive after
12:57
each lecture um the deadline will be
13:03
always on Tuesday end of the day if we will not tell anything else so it
13:12
might be that in some rare cases we will extend the deadline but you should
13:19
expect that the deadline will be on Tuesday end of the day so you
13:26
will have basically nearly one week to to finish the tasks
13:33
bonus lectures uh will be then
13:39
presented later on also on Discord but these lectures will
13:45
not be graded and uh yeah so if you will successfully
13:52
uh submit the tasks uh at the end you will receive an nft badge uh this nft is
14:03
obviously issued by a key blockchain and recognize also why Solana Foundation
14:10
it will be frozen to your wallet at the end with your name or nickname as
14:16
metadata and you will be able to use this badge
14:22
to enter other courses from our partners and it will be also nice asset for for
14:30
example job interviews if you will be looking for a job in web 3 in the future
14:38
uh yeah and as I said before feel free to skip lectures uh if you feel that you
14:46
already know the basics but please do not forget to submit the
14:54
tasks
14:59
one last important point before we will go to the technical part
15:05
where you can meet us in real life so usually we try to attend most of the
15:14
events around Europe so you can find us on hacker houses
15:21
also we were twice this year in Berlin uh on hackathons
15:29
and this year we will also have a security workshop at Solana breakpoint
15:35
in Amsterdam so uh yeah if you will attend also breakpoint feel free to come
15:43
and say hello it will be a pleasure to meet you in person
15:50
and uh now I will hand over to Andre that will
15:56
give you a technical introduction to Solana
16:02
so yeah let's talk about uh introduction to Solana I guess that most of you
16:09
already know but Solana was founded by Anatolia comenco in 2017 and the Solana
16:14
maintenance beta went live officially in March 2020 uh the native token on Solana
16:20
is so uh Solana have some pretty sweet offerings obviously uh the first of it
16:27
is definitely scalability uh right now it's sitting in comfy 4 000 transactions
16:32
per second uh which is way above uh any different uh altcoin or L1 networks in
16:40
blockchain uh what is really important with about Solana is that uh Solana scales natively
16:46
with Moore's Law uh that means as Hardware get more powerful the Solana
16:51
gets more powerful with it so technically Solana can
16:56
reach speeds up to 50 000 TPS and as we see more progress with for example
17:03
Solana fire dancer we will probably see uh even much more than that or exceptionally more than that
17:11
another important aspect about Solana scalability is there is no additional complexity through sharding or uh Layer
17:20
Two Solutions so Solana is pretty scalable and uh there is no needs to
17:25
create any abstractions to kind of make Solana more powerful more Speedy Etc as
17:31
we've seen in ethereum ethereum had some scaling issues in the past and going
17:38
forward so uh ethereum proposed many different uh Frameworks of improving the
17:45
performance which is uh which will definitely not be happening on Solano
17:50
another really sweet offering is a pretty good decentralization even though
17:56
a lot of the people love to say that Solana is not a decentralized or a centralized
18:02
the current Nakamoto coefficient is 31 Which is higher than all of the
18:07
different altcoin or L1 um uh L1 ecosystems
18:14
uh you can check uh current Nakamoto coefficient at knackerflow.io if you're
18:20
not familiar with Nakamoto coefficient it's essentially a number that
18:27
tells you how decentralized that particular network is and another really important fact is an
18:34
expensive execution so a really low gas fees which makes Solana uh really good
18:41
for more interactive applications or applications where a lot of execution
18:46
needs to happen a lot of transactions needs to happen Etc
18:51
so if we make like a brief uh comparison between Solana and ethereum uh both
18:59
networks are currently uh essentially a proof of stake except Solana is a proof
19:04
of stake with proof of History we'll be talking about that a little bit in more in in detail later
19:11
uh the block times are 400 milliseconds on Solana compared to 13 seconds on uh
19:17
ethereum another really huge difference between a smart contracts on ethereum
19:23
and programs on Solana is that the programs on Solana are stateless they are not storing any state all of the
19:30
state or data are stored in the different accounts on the other hand ethereum is stateful
19:37
uh the main programming language used on Solana is rust and then there is
19:43
solidity on ethereum solid it is more of a scripting language rust is a little bit more of a robust package but we'll
19:50
definitely have advantages with using for example anchor framework that will
19:55
help you with security and implementing your applications but also we'll see another language is coming up to Solana
20:03
uh like python via seahorse and Etc
20:08
so yeah and then there's obviously the speed difference in transactions per second without any scaling Solutions
20:14
Solana can reach uh a really high number of DPS uh it's really scalable with the
20:22
more slides I mentioned on the other hand the ethereum is uh kind of stuck at about 15 transactions per second
20:29
let's talk about Aki Solana handbook we have created the 49 pages of
20:36
introduction to Solana it is created specifically for school of Solana and it
20:42
is a perfect way uh to get yourself invested into the Solana ecosystem you
20:48
can get it for free on this URL you can get it in our Discord and it is probably will be attached to this video in the
20:55
description uh the handbook should be kind of your Bible during this course it
21:01
is structured into the seven different categories and all of the categories are
21:06
kind of covered during the school of Solana course we were obviously be
21:12
starting with Solana introduction The Core Concepts and then during the third fourth and fifth lecture we'll be
21:18
talking about the Solana programming model um as we go uh during this course I kind
21:25
of recommend you to study all of these chapters separately because uh if you
21:31
kind of go through these chapters you will be perfectly prepared for each lesson
21:40
before we go any further with the lessons we obviously need to install a proper tooling uh there are a few tools
21:46
that uh you need to have installed to kind of get into the Solana development I will not try to force you to use any
21:54
specific ID I'll just provide the recommendation of what I'm using and what we will be using uh during the
22:01
whole uh winter School of Solana so for the ID I definitely recommend a visual
22:07
studio code you can get Visual Studio code on the
22:12
code.visualstudio.com and you can download a particular binary for your specific platform it is really easy to
22:19
install so I will not go into the details here so when you have your ID all set up
22:25
uh the next uh important thing that we need is rust uh thankfully uh rust is
22:32
providing something that is called rust up which is uh really simple installation script that will guide you
22:39
through the whole process so anything uh that you need to do is go to the rust
22:44
slash slang.org and copy this script into your terminal uh this will download
22:51
the up-to-date installer and kind of guide you through the installation process in Fairly interactively I will
22:59
not do I will not go through this process because
23:05
uh because I I'm already set up then that's uh rust up will also install
23:12
what is called a cargo cargo is a package manager for rust it is something
23:19
that is really similar to MBM in the JavaScript ecosystem so uh we'll be kind
23:25
of get it will be kind of used to uh import and install different packages
23:30
into your project so cargo is a really important aspect but you don't need to
23:36
install cargo manually because it is already a part of the rust up process so it will set you up automatically
23:44
uh when you arrest the environment is all set up I definitely recommend you to use a rust analyzer uh plugin for visual
23:52
studio code you can find it in the visual studio Marketplace and this is like a really crucial part in terms of
23:59
rust development for a good reason it kind of provides a full support for rust
24:05
programming language to your Visual Studio installation including the code
24:11
completion import insertion uh cement semantic Sun syntax highlighting and a
24:18
lot of really important stuff that will help you with the development in the
24:23
rust uh with this whole rust package installed I definitely recommend you to
24:30
install node.js if you don't have that already since most of you are JavaScript
24:36
developers uh node.js will be extremely useful for running up tests for your
24:43
Solana program because tests are usually uh are usually written in typescript and
24:50
then executed in node environment we'll be also using node into the in a in a
24:57
lecture in the lecture number six where we'll be working on developing a front-end for your Solana programs in
25:04
typescript so when all of that is already set up uh we are pretty much good to go to
25:11
install Solana we'll need what is called Solana tool suit or Solana CLI and if you are on Mac
25:20
or in Linux you can essentially install Solana with just a single command so you
25:26
can just copy this command and paste it into your terminal and very similar to rust up it will kind of guide you
25:34
through the whole installation process it will automatically download the
25:39
latest stable release and help you kind of install the whole uh Solana tools
25:46
suit Suite that we need if you're done with installing Solana uh
25:53
there is a last piece of puzzle that we will need and that is anchor anchor
25:59
framework will be kind of working with anchor framework as we go into the in the different lectures it will
26:05
essentially help you in writing Solana programs and specifically writing secure
26:12
Solana program so it is extremely uh import and framework that we'll be
26:18
working with again it is um it is really simple to install but you
26:25
need to have rust installed already uh so try to install all of this Tooling in
26:30
this particular order because anchored is installed uh using a cargo package
26:36
manager we will install something that is called anchor version manager that will kind of
26:42
help you manage and be up to date with anchor releases
26:47
when all of the tooling is installed uh let's introduce how we can use Solano
26:53
CLI for interacting with Solana blockchain to ensure that all of the Solana tools
27:01
are properly installed we can use command Solana version this will return
27:07
the current version of your Solana CLI installed on your machine if you have any problems with a calling
27:14
Solana version please verify that you properly installed everything in the
27:19
Solana installation script when interacting with Solana we're into
27:24
interacting uh with different clusters there are different clusters in Solana
27:30
available to us that is a mainnet beta test net and devnet uh if we're
27:37
developing we'll be probably working with uh Solana devnet or testnet where we can
27:43
kind of faucet uh Solana tokens that we we can use during the development these
27:50
tokens have no particular value we can use different faucet mechanics to kind
27:55
of obtain these tokens and use them for development uh if we want to connect to
28:02
the quote-unquote Real Solana we'll be using a mainnet which is uh the
28:07
production environment for Solana we can achieve that via different RPC servers
28:14
or RPC connectors these RPC servers provides a Gateway for
28:20
us to connect to the Solana ecosystem we can verify what's our current
28:26
configuration using a Solana config get which will tell us where is our config
28:32
file located what is the current RPC URL that we are using to interact with so on
28:40
the blockchain what is the websocket URL for that particular RPC and uh what is the key
28:47
pair uh let's briefly talk about all of these uh the config file is not that
28:54
particularly interesting to us right now what is interesting is the RPC URL uh
29:00
we'll be setting up the RPC to connect to a different clusters that I mentioned
29:05
uh and we can achieve that by using Solana config set URL to set up uh or to
29:14
set our Solana CLI to connect to a particular RPC and that RPC is
29:20
connecting to a certain cluster in Solana ecosystem so if we want to connect for example to
29:27
Solana devnet we'll set Solana config config set URL to api.defnet.solana.com
29:37
so if we use that we are automatically connected to devnet we can find these
29:43
different RPC connectors all around the web there are different RPC providers we
29:49
can set up a private RPC notes or we can pay uh different RPC providers like
29:56
quick note to set up a private RPC connector for us there are various
30:03
advantages of using a private RPC over uh over public RPC and that's
30:11
particularly in uh there are no throttling for requests so for example
30:16
if you're using a public RPC and uh you are sending a lot of the requests and
30:22
you might get throttled or some of the rec requests might not get through RPC
30:27
to a Solana cluster so yeah but for a development uh we are
30:34
pretty much set with using uh the public RPC connector for testnet and defnet
30:43
different uh what's the difference between a devnet and test net uh defnet
30:48
kind of serves as a playground for everyone who wants to take Solana for a
30:54
test drive as a user token holder app developer or validator
31:01
application developers should definitely Target devnet because we'll be using the
31:06
same uh release of Solana as it is running on the mainnet if we're talking
31:12
about testnet testnet is more aimed for Solana core contributors where they can
31:18
stress test recent releases and features that are not already live on a mainnet
31:27
or devnet clusters uh test net and definite tokens are
31:32
obviously not real compared to a mainnet those are only the test token that you
31:38
can foster for free and use them for development our RPC connection all set
31:43
up let's talk a little bit about creating a Solana wallet uh this is
31:49
obviously a little bit different from using a Solana uh Solana wallet for a
31:55
browser but uh we can use uh a Solana CLI key generation tool to kind
32:03
of create our own wallet that we'll be using in Solana CLI and for Solana development so
32:11
for that uh we'll be using what is called Solana kitchen if we want to
32:17
verify if we have Solana kitchen we can again use Solana kitchen uh version to
32:23
check out if we have Keygen installed there are a few features that we can use
32:30
uh for example we can use Solana Kitchen New Solana Kitchen New will generate a
32:38
new key pair for us that we'll be using in Solana CLI if you will be using Solana Kitchen New and you already have
32:45
a generated key pair it will tell you that it will not override that key bear
32:51
if you want to override that keeper you can use a force flag to do that
32:58
that will ask you to add a bib39 passphrase if we want to if we don't
33:04
want to do that we can just press enter and it will generate a new key pair for us
33:09
it will show you your pup key and it will also show your seed phrase that you
33:16
can use to recover this POP key
33:21
if you want to explore uh what are the different commands that we can use with
33:27
Solana Keygen we can use Solana kitchen help and it will tell us all of the available
33:34
comments comments sorry so we can use grind grind
33:40
kinda helps us grind our vanity key pairs it will Brute Force through a key pair generation and will create us a
33:48
wallet that has like a specify beginning or end so we can kind
33:56
of create a custom Pub keys but this however takes some time to grind it depends on your Hardware
34:02
you can use the new command that we already used or you can use a POP key
34:07
command popkey command is extremely useful because we can just type Solana Keygen popkey
34:13
and Solana kitchen will tell us what is our popkey that we are currently using
34:19
in Solana CI we can also use Solana recover uh which then we can use a bit
34:27
39 passphrase or seed phrase to recover a key fair or we can verify if a keeper
34:33
can sign and verify or then verify a message our wallet already set up uh the
34:41
next thing we will probably want to do is check what is our current balance of Solana tokens uh we can do that by
34:48
calling Solana balance
34:53
this will show us our current balance inside that particular wallet that we are using right now as I mentioned
34:59
before in a definite or test net you can use airdrop or faucet to get yourself
35:07
some free Solana tokens that you can use for development but obviously these are not real and are or should be used only
35:15
for development to do that we can use command Solana airdrop and specify
35:21
amount of salt that we want to get air dropped so for example here I'm requesting a
35:28
half a soul it will show us a signature for that transaction and then it will
35:33
verify that uh it will verify if we get that particular airdrop this however May sometimes fail
35:41
if that fails try to specify a lower amount for airdrop so for example if I try to airdrop 100 so it will probably
35:48
fail yeah you can see that our my balance uh
35:56
remain unchanged so if you want to gather a bit more uh Solana test net
36:03
tokens you can do that by airdropping a smaller amount
36:11
so now that we passed through two of our airdrops of each airdrop for half a soul
36:17
we can check Solana balance and verify that we actually received
36:22
those tokens that we can use for development now that our wallet is properly set up in
36:28
Solana CLI and we have some of the balance inside our wallet uh let's talk
36:34
about transferring uh our tokens to a different wallet using a Solano CLI again it's really simple we can call
36:41
Solana uh transfer so let's say we want to transfer zero
36:49
points all 0.2 soul to this particular wallet we usually call Solano transfer
36:55
the Target wallet and the amount of Solana that we want to send
37:02
now we can see it errored out and it aired out for a reason that Target wallet is a new wallet and it's not
37:09
funded properly so uh we want to uh if we want to send some Solana to a new
37:16
wallet or a wallet that is not already funded for that particular token we can
37:21
add allow and found it unfounded recipient flag to that transfer function that
37:28
means that the sumana CLI will first fund the wallet by creating an account for that particular token and then
37:35
transfer the target amount [Music] now we can see that the transaction the
37:42
transaction went through and we can see the signature that we can verify using a Solano Explorer or a different tool that
37:49
we like to use we know how to interact with the native Soul token uh let's talk a little bit
37:54
about SPL tokens uh SPO tokens on Solana is something very similar to erc20
38:00
tokens on ethereum so outside of interacting with the native token which
38:06
is used for uh generally all of the interaction on Solana we can create our
38:12
own tokens on Solana that we can name as uh as we like we can set the supply for
38:21
the token we can send it out to everyone and we can use that token for example in
38:26
our own programs in Solana uh you can for example usdc usdt uh like
38:34
stable coins on Solana are also SPL tokens or any meme coins that you can
38:40
think about like Blanc Samo or woof on Solana are also SPL tokens if we want to
38:47
interact with the with the token program on Solana we have to install uh another
38:54
tool using cargo which is called SPL token CLI uh this will kind of give us
39:00
an CLI to interact with the SPL token program on Solana
39:05
so use your cargo that you installed to install this cargo crate and
39:12
then after the installation is done uh
39:17
we can use the SPL token to or call the SPL token
39:23
and for example just just call SPL token to kind of get help on all the sub
39:29
commands flags and options that you can use so let's just go briefly over how to create
39:35
your own SPL token directly from Solana CLI set up the supply for that token a
39:41
minute out and send out to a different wallet so if we want to do that we can
39:47
call an SPL token create token function this will automatically create a token
39:52
for us we can also Supply different flags to specify for example decimals for that particular token but you can
39:59
see with one simple command I have created and a token on this particular address
40:05
if we want to check what's the supply for the token we can call SPL token
40:11
Supply and we can use the address of that token to kind of get the current supply of
40:18
that token we can see it's zero we have created the token but the token have no supply for now
40:25
so if uh if we want to interact uh with the token that we have just created we
40:32
need to create an account for that token uh account for that token will store uh
40:38
the particular amount of that token in our own wallet so if we want to do that we can call create an account function
40:45
so let's just call SPL token create account and specify
40:50
uh the token address that will be creating the account for so we will be
40:55
creating an account for a token that we created in the previous commands
41:02
so now uh we have an account on this address that kind of represents a r wallet or
41:11
our account that will be holding those tokens in our own wallet so if you want to check what's the
41:18
balance of that particular account we can for example use SPL token balance
41:27
and uh use the token address that we created
41:33
now we can see that our balance is zero obviously the balance is zero because the supply is still a zero but since we
41:40
created an account we can now hold this token in our own wallet
41:46
so let's just go ahead and Min some so since we are the deployer or the
41:52
authority of uh that token that we have created we can call SPL token min
41:58
and uh again we'll be specifying the address of the token that we want them
42:05
in and we want them in for example thousands of them
42:19
so now uh our token is minted so we can see that it will mint 1000 tokens that
42:26
we ask for it will be minting a token of uh the token on this address and the
42:32
recipient uh you can see that the recipient will be the account that we have created for
42:40
this token and now we have received a 1000 tokens
42:46
or 1000 tokens of that token that we created and we can
42:54
yet again call the SPL token balance and we can we can check that we do have
43:01
thousands of these tokens that we just minted and even if we call SPL token
43:11
Supply
43:17
we can see that the supply is right now one thousand uh this obviously counts
43:23
the whole supply of that token so that does not mean that it's the only Supply that we have in our own wallet but it's
43:30
the total supply of that token across all of the accounts and across all the different walls that that holds these
43:37
different accounts so now that we have verified that we do
43:43
have uh we we do have 1000 tokens that we have that that we have minted right now
43:50
we can for example check all of the accounts that we have so if I
43:55
call SPL token accounts it will show us a list of all of the accounts that we
44:01
have for different SPL tokens and their balances and we can see that the token
44:07
that we have just minted we have 1000 of them foreign
44:12
SPL token uh maybe you want to send it to another wallet and we'll be doing
44:18
that pretty much the same way as just with transferring the native Soul token but instead of it interacting with
44:25
Solana CLI directly we'll be interacting with SPL token uh SPL token CLI again so
44:32
if we check to help we can see that we do have a transfer function so let's do
44:39
let's just do SPL token transfer
44:46
and now we can check what are the required parameters that we need to specify so we will be specifying a token
44:54
mint address and we'll be specifying a token amount and we will be specifying a recipient wallet
45:00
so let's just do it right now
45:05
we want to transfer SPO token that we have created previously
45:14
which is this one so let's just do transfer
45:20
we'll do our wallet we'll specify the amount uh where do our account and we
45:27
specify the Target wallet or the recipient wallet so yeah let's just do that
45:33
and you can see that we have the same error as with transferring the sole token before and
45:41
again we need to fund the recipient for a good reason the recipient that we're sending to does not have an account that
45:49
will be holding our SPL token so uh we can do that by just adding a fund
45:55
recipient flag again
46:05
so now that we do that we see that the transaction went through and we have a signature for that transaction so let's
46:11
just verify that the token was actually sent and checked the SPL token uh
46:18
balance for our token and we can see we have 950 right now but still if we check the sbl
46:26
token Supply
46:32
we can see that the supply remains 1000 because I hold 950 in this wallet and
46:37
now I hold 50 in the Target recipient wallet and why I'm kind of uh talking about
46:43
this Solana CLI but there is a good reason for that when we'll be working with uh or developing a Solana program
46:51
we'll be using a Solana CLI to kind of deploy the program so when we have a Solana program ready
46:58
uh we can call Solana program deploy
47:05
and the program file path to specify and if we do that the Solana CLI will deploy
47:11
the program and will tell us our program ID as a result so this was just a brief introduction to
47:18
Solano CLI there are obviously much more features that you can use and I do
47:24
recommend you to kind of read through docsolana.com I'll be sending all the links to all of the links uh to you and
47:31
you can kind of explore what Solana CLI can do but yeah you can kind of Imagine That Solana CLI is just a bit of a
47:40
Gateway from your system to Salama blockchain
47:46
thank you for attending today's lecture and now I will hand it over to my
47:52
colleague to give you details about our next assignment so now you now you had the introduction
47:58
to to Solana and you have learned how to use the CLI and how to set up the the
48:04
tool chain and I would like to present you the uh
48:09
the first task um Andre already mentioned the Solana handbook that we have prepared for you
48:18
um you will again find the link in Discord so you can download it
48:25
and we would like that you read the
48:31
first three chapters so the blockchain terminology Solana introduction and The
48:37
Core Concepts especially the Core Concepts are important to understand the unique
48:44
features of Solana which are the proof of History Tower bft turbine Gulf Stream
48:52
sea level pipelining cloud break and archivers and the first task after the first
49:00
lesson uh will be multiple choice questions
49:07
um so you will again find the link uh on Discord to GitHub classroom where you
49:15
will be able to clone your or the the repository for the first task and where
49:22
you will have to answer a few basic questions uh from uh here from the first
49:30
three chapters please only pay attention that you
49:35
should reply with a single character so that we can easily evaluate your your
49:45
answers so that's it for today
49:51
um I'm very happy that we have so many students I hope that you have learned
49:56
something something new and next time Andre will
50:02
give you introduction to rust um and uh yeah I'm looking forward to
50:12
the next lecture goodbye