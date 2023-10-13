# lesson3
In this lecture, we will discuss two core Solana programming model concepts: Accounts and Transactions.

We will set up our first project in Anchor, write our first simple calculator program and show how to verify if our program is correct using tests.

Recommended content to read: https://solanacookbook.com/
Sample code: https://github.com/Ackee-Blockchain/wsos-calculator


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

## install anchor in windows
https://stackoverflow.com/questions/72037340/install-anchor-cli-on-windows-using-cargo

