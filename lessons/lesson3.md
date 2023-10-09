# lesson3
In this lecture, we will discuss two core Solana programming model concepts: Accounts and Transactions.

We will set up our first project in Anchor, write our first simple calculator program and show how to verify if our program is correct using tests.

Recommended content to read: https://solanacookbook.com/
Sample code: https://github.com/Ackee-Blockchain/wsos-calculator

## solana wiki
https://solana.wiki/zh-cn/docs/account-model/
## anchor doc
https://docs.rs/anchor-lang/latest/anchor_lang/derive.Accounts.html
## Solana Development Course
https://www.soldev.app/course

```
mkdir solanaProject
cd solanaProject
anchor init calculator
```

```
solana config set --url localhost

solana address
```
B3G88A4LcWFA1yC9gtybMhs9gPsGAx6YfiBcBoZkqMzN

``` not work
solana-test-validator
```

```
anchor build
anchor deploy
anchor deploy --provider.cluster devnet

anchor run test

anchor test ---skip-local-validator
```

error: package `solana-program v1.16.15` cannot be built because it requires rustc 1.68.0 or newer, while the currently active rustc version is 1.62.0-dev
```
solana-install update
```