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

## install anchor in windows
https://stackoverflow.com/questions/72037340/install-anchor-cli-on-windows-using-cargo

error: package `solana-program v1.16.15` cannot be built because it requires rustc 1.68.0 or newer, while the currently active rustc version is 1.62.0-dev
```
solana-install update
```

# 文字起こし
0:01
hey everyone welcome to the lecture 3 of winter School of Solana today we'll be talking about Solana programming model
0:09
so let's briefly introduce these lectures and the upcoming lectures going forward
0:15
so about this lecture we'll be talking about a brief introduction to Solana programming model that means making a
0:21
brief overview talking about accounts and transactions and those are pretty much the basic Core Concepts that we
0:27
need to know to start up our programming Journey on Solana we'll also be doing a Hands-On example
0:33
which means setting up a new anchor project and then writing your first Solana program in it which will be a
0:39
calculator and we'll also write some of the tests in mocha testing framework
0:45
going forward we'll be also learning about pdas which are program derived
0:51
accounts and also work a little bit on our front-end and typescript and next.js to interact with our Solana program
0:58
as a result of that we'll be building out our project which will be your first proper Solana program a Twitter clone
1:05
with the Tipping functionality and we'll also write a proper testing in our own
1:10
testing framework that we call turnstile
1:15
so let's talk a little bit about the core concept of Solana the app interacts with Solana cluster by
1:22
sending in transactions with one or more instructions uh the Solana runtime passes those instructions to program and
1:29
the pro the programs are deployed by app developers beforehand instructions are then executed
1:36
sequentially and automatically for each transaction if any instruction is invalid all of the account changes in
1:43
the transactions are discarded so some of you can spot an immediate uh
1:49
or immediate or recognize some of the database aspects if you ever work with for example SQL databases
1:57
so if we talk about the Solana program it is essentially a piece of code that is run by Solana blockchain
2:05
programs in Solana are stateless meaning out you can't store any data in them this is a significant difference between
2:12
smart contracts on ethereum and programs on Solana because for example if you're writing ethereum program you can create
2:19
variables you can store some data directly in a smart contract this does not hold true on Solana on Solana we
2:27
have a clear distinction between accounts that are containing the program and accounts that are containing the
2:33
user data user data or a different account is then supplied to the program
2:38
during the initializing initialization of the execution and yeah so essentially we use accounts
2:46
to store both programs code or what we call bytecode and user data we can
2:51
definitely imagine them as separate files on the blockchain
2:56
so yeah our first core concept is accounts and there are three different kinds of
3:03
accounts we have data accounts that are used to store data we have program
3:09
accounts that are used to store executable or some form of executable payload or bytecode
3:15
and we have native accounts that indicates native programs on Solana that
3:21
are fundamental part of all the validators such as system stake BPF loader
3:28
so yeah at the bottom we can see a bit of a visualization how different fields
3:33
in the accounts look and we'll be talking about each of them in detail later
3:40
so here is a clear distinction between ethereum and Solana if we have for
3:45
example a really simple counter of it increment and decrement Feature Feature on ethereum we have some form of smart
3:52
contract account that contains data and some executable evm byte code on the
3:57
other hand if we look at our Solana visualization we have our program account that is executable and has some
4:04
form of executable byte code in the data and we have a data account and this data
4:09
account uh contains some form of user data and there is a clear distinction between the
4:17
executable bytecode and the user data we are supplying to the program
4:24
uh there within those data counts uh there are also two types one of them is
4:30
system-owned accounts and BDA or program derived address accounts and each
4:36
account uh is uh different in some form of way and
4:42
we'll be talking a little bit more about bdas in our next lecture so yeah accounts can only be owned by
4:49
programs owner of these accounts has a full autonomy over the owned accounts and it
4:55
is up to programs Creator to limit this autonomy and up to the users of the
5:00
program to verify if the program's creator has really done so
5:07
so let's uh briefly talk about all the fields that are usually stored in the accounts in Solana
5:14
so uh the main is essentially a key which is a pub key that is used to
5:19
identify an account it is 256 bit long and it is usually a public key pair
5:28
another one is a program owner which is another Pub Key that indicates who's the
5:34
owner of this account and the only account that can write the data into this account
5:40
only the owner of the account May assign a new owner owner and after it has been
5:45
fully zeroed out which means the data payload needs to be zeroed out before the owner assigns a new owner
5:52
essentially transferring the ownership of the account another important one is Lan ports it is
5:59
a number of Lan ports owned by this account and only the owner of this account made
6:05
subtract its landforce everyone can credit the account which means we can send Lan ports to any any account we
6:12
want but if we want to subtract this data or subtract the lime ports or essentially
6:18
spend them in any way we need to be an owner of this account
6:25
and then obviously the data payload which is essentially a raw data byte
6:31
array stored by this account it can be a user data or it can be an executable
6:37
payload it is up to 10 megabytes of mutable storage and can only be written
6:42
by the owner of the account and cannot be resized currently
6:49
so we also have some of the really important Flags one of them is a flag
6:55
called executable and it essentially marks if the account is executable
7:01
during uh deployment process now we marked that during a deployment
7:06
process and it tells the Solana blockchain that the data of this account is essentially a byte code that Solana
7:12
can execute executable accounts are fully immutable once they are marked as final so
7:18
essentially if we deploy them the data payload is not immutable in any way and it is or they are owned by a BPF
7:26
loader program uh there is also something that is
7:32
called rent and storing data on their own accounts costs sold to maintain and
7:38
it is funded by what what we call rent if you maintain a minimum balance
7:43
equivalent to two years of rent payment in an account your account will be extended from Wrangler rent
7:49
uh you can retrieve rent by closing the account so essentially if the account is no longer necessary the owner can close
7:56
this account and it will send back the Lan ports back to your wallet
8:03
uh rent is paid during two different timings uh when it is referenced by
8:08
transaction and wants an epoch a percentage of rent is collected by
8:14
accounts uh and the percentage of the rent collected by accounts is destroyed while the rest
8:20
is distribute to vote Accounts at the end of every slot if the account does not have enough to
8:26
pay the rent the account will be deallocated and the data will be removed
8:33
so essentially that tells us we have to maintain some form of balance to keep
8:39
our account valid so this introduced the concept of essentially quote-unquote
8:44
garbage collection so if some of the accounts does not have enough rent to be paid it will be automatically
8:50
deallocated freeing up the space on the Solana blockchain another really important flag is is
8:58
signer flag which essentially is indicating if the account has signed the transactions it is not uh actually
9:06
stored in the account but it's just a runtime metadata another runtime metadata is is writable
9:13
flag and it is indicating if the account is writable
9:20
so you have to tie all of this down we have some of the seven basic rules for Solana accounts
9:26
so first is each account has a unique unique address and a unique owner owner
9:32
has a full autonomy over the owned account and only the data's accounts owner can modify its data and debit Lan
9:40
ports the program as I mentioned don't store any data we have separate accounts for
9:46
that and accounts must pay rent to stay alive and not to be deallocated from
9:51
Solana anyone is allowed to credit Lan ports their data account but if you want to
9:57
spend them and you need to be the account owner the owner of the account May assign a
10:03
new owner if the data if the accounts data is zeroed out so if you want to transfer the ownership of the account we
10:10
need to essentially erase the data contained in that particular account let's talk about transactions
10:18
the basic operational unit on Solana is called instruction
10:23
usually contains the program ID of the intended program we're calling an array of all accounts we intend to
10:31
read from or write to which ties ties to our previous chapter about accounts
10:37
we're essentially supplying some form of user data to the cult program and the
10:43
instruction data which is a byte array that is specific to the intended program
10:49
so just like in any form of SQL databases uh we can bundle multiple instruction
10:57
into something that we call transaction if we are forming transaction uh we're
11:04
essentially supplying an array of all accounts we intend to read or write to one or more instructions
11:11
a recent block hash this is really important and one or more signatures for that particular transaction
11:18
we also specifying a writable signer which is the account that is serialized first and will be the fee pair for the
11:25
whole transaction so let's just uh let's just talk a bit
11:31
about about the Deep dive into a transactions
11:39
so uh the Solana runtime requires both instructions and transactions to specify
11:45
the list of all accounts which we can see right here uh when the transaction is submitted to
11:52
a cluster the runtime will process this instructions in order and atomically
11:58
and for each instruction the receiving program will interpret its data array
12:03
and operate on its specific accounts that we're supplying the program can have or can obviously
12:11
have two results if if it goes well the whole transaction is submitted on the
12:16
other hand uh if we got some form of error code and the error is returned the entire
12:22
transaction will fail immediately so even though if we are create we are uh
12:28
we are doing multiple uh instructions and one of those instructions fails the
12:33
whole transaction is reverted um any transaction that aims to debit an
12:42
account or modify its data requires the signature of the specific account holder any account that will be modified is
12:50
automatically marked as writable uh use uh via the Solana runtime an account can be credited without the
12:57
holder's permission so long as the transaction fee pair covers the necessary rent and transaction cost
13:06
Also let's get back to a recent blog hash
13:11
before the submission all of the transactions must reference the recent blockage for a very good reason
13:18
it is used to prevent duplications and eliminate the stale transaction and for
13:24
each transaction the maximum age is about 150 blocks which is about one and
13:29
one minute 30 seconds uh but that obviously varies uh as we go
13:36
but essentially if the transaction is marked as stale uh or or over its max
13:43
age it is automatically uh eliminated not processed and reverted back
13:51
so yeah let's just sum it up instructure instructions in one
13:56
transactions are processed in order and atomically if any part of the instruction fails the entire transaction
14:03
fails we have some form of limit for a transaction and to prevent the program
14:09
from abusing the computational resources each transaction is giving a compute
14:14
budget uh there are five really important
14:20
things that we need to know about transactions uh we can think about this that all of the
14:26
program inputs can be potentially malicious uh for a few reasons any user
14:32
can obviously compose these transactions that means uh it can be whatever instruction in the
14:39
transaction and user also provides all of the accounts so what we need to do here from from the developers
14:45
perspective we need to check the signers we need to check the owner and we need
14:51
to be Beware of the unexpected order of instructions within within the transaction we also obviously need to
14:58
cover any form of invalid input from a side of the user
15:05
and also think of the compute budget when we are designing these transactions
15:10
in our program so now that we know about accounts and
15:17
transaction let's just set up our first anchor project
15:23
so let's just go ahead and create a new anchor project after we create our
15:29
anchor project we'll just go briefly through different folders of our project and introduce what they mean in our
15:35
project and how we'll be working with them so I believe all of you have probably
15:40
followed the instruction we have given in the lecture number one but if you didn't please uh switch back to lecture
15:47
number one and install all of the necessary tooling in case you will have any issues with
15:53
your yarn package manager uh please install it using this command because I
15:59
believe that anchor is using a yarn package manager and we have not mentioned that in we have not mentioned
16:05
that in our lecture number one however when we're ready uh something
16:12
really similar to npm package manager in JavaScript or typescript we can just go ahead and type anchor in it and the name
16:19
of our Solana program let's just call our Solana program hello world or for
16:24
example calculator I'll call it calculator because we'll be expanding our hello world sample into a
16:32
full calculator a little bit later so right now the anchor will initialize
16:38
the whole project it creates a new anchor workspace you can move into after the initialization
16:45
is complete and there are some of the really important files in our project folder
16:52
so let's just go ahead and switch to our calculator project
16:58
and now that we are in our project we we can see that we have a couple of files we need to talk about uh so uh
17:06
a couple of interesting ones uh we'll have an uh dot anchor folder this will include you this will include the most
17:13
uh recent program blocks and also local local Ledger that we'll be using for
17:19
testing we have a app folder app folder is essentially an empty
17:25
folder that you can use to hold your front end uh if we'll be using a mono repo to kind of
17:31
host our full full stack solution into one GitHub repository so yeah we'll be definitely using that
17:37
later we'll be creating a separate typescript or next to JS next.js
17:43
solution here in the app folder we have a programs folder this is the
17:49
most interesting one for us it's essentially the folder that will contain your Solana program
17:54
uh it can contain multiple programs but initially we'll be just working with a
18:01
single program and we also has a test folder and the test folder is will be containing all of
18:08
our test uh developed in typescript using a mocha testing framework
18:15
we also have a migrations folder migrations folder we can save our deploy
18:21
and migration scripts for our program and a really important one is anchor.tamil
18:28
anchor.dominal is essentially the file that configures your whole workspace
18:33
for your program we also have a cargo.domo which includes
18:39
all of the packages we're using in our programs workspace
18:48
so now when our anchor workspace is all set up let's just go ahead and open it
18:54
up in our preferred IDE I'll be using visual studio code AS mentioned in lecture number one
19:01
and before we get into an actual code let's just briefly talk about the whole
19:07
development process uh you can use different ways how to
19:12
test out your program I recommend you to run something that is
19:18
called local local Ledger this will essentially
19:24
uh local Ledger is best basically a simulation of the Solana cluster inside
19:29
your local machine so when building locally we don't actually want to send anything to the
19:35
Solana blockchain so this is exactly what we want uh unfortunately for us running a local
19:42
Ledger is uh really easy so before we actually run the local Ledger uh let's
19:48
just set up our Solana CLI to talk with the local host or the local
19:54
Ledger and we can do that by calling Solana config set URL to local Ledger so
20:00
we're be essentially uh using an RPC for our local Ledger that will be running in
20:06
a different terminal so let's just set that up we'll get a confirmation for our RPC URL and our websocket URL it should
20:14
be set to the Local Host so and yeah before we actually run The
20:20
Ledger let's just verify we have a keypad ready so let's just call Solana address
20:25
and as you can see I have my key pair already generated but in case you don't have one you can just run Solana Keygen
20:32
new as mentioned in lecture number one so now uh when our Solana CLI is uh
20:38
talking with our local Ledger let's just spin one up so we can do it by creating
20:44
a new terminal instance for example I can just create new one in our IDE and after we are in our new terminal
20:51
let's just run comma command called Solana Dash test Dash validator
20:58
this will initialize a essentially a simulation of Solana on our local machine you can notice that it will generate a
21:05
folder that is called test Dash Ledger and this one essentially contains the state of your local ledger so for
21:13
example if you stop your Ledger and you resume it after you get back to your development it will load up the state
21:18
from this folder but please be aware that the test Ledger folder grows with
21:23
time obviously so now that we are all set up with our
21:29
local cluster we can just verify that we have some soul on our account
21:35
by calling Salon a balance and as you can see I have some soul airdropped to
21:40
my account from our local Ledger you'll probably have a lot of soul there so
21:45
you're essentially good to go but the whole development process is as follows uh during your development
21:52
you'll be using a local validator to test out everything that you need and when you're happy with your program you
21:59
can just essentially swap up your RPC deployed to the local net or sorry a
22:05
devnet or testnet test it out there and essentially invite other users to test
22:10
out your program and when you're happy with that you can ship into a production by essentially deploying to the mainnet
22:19
yeah so now we're pretty much ready and we just need to know a couple of commands how we'll be working with stuff
22:24
here so before we'll be actually deploying the program we need to compile
22:29
it into a byte code that is uh in that can be interbred by Solana runtime and
22:36
we can do it by calling anchor build
22:42
uh you can see you can you can see a couple of errors but that's not really interesting for us right now during the
22:48
first run it will probably compile all of the dependencies so it will take some time but uh yeah essentially you should
22:55
be greeted with finished uh in yeah some sort of time but when you
23:02
do your ankle build you can then essentially deploy your program so let's just run anchor
23:09
deploy and you can see that it's sending out 177 transactions to deploy our program
23:17
uh it will say deploy success and you will get your program ID
23:22
so now when we completed completed our initial deployment and we get our program ID in the terminal what we need
23:30
to do right now is update our program ID in our workspace so that's because before our initial
23:38
deployment we simply don't have any idea what will be the public address of our program after the deployment
23:45
so when we complete our initial deployment let's just go ahead to our anchor.tamil file and you can see we
23:53
have some form of pre-generated ID of our program so let's just go ahead and replace it with our program ID from the
24:00
deployment uh save that one and we also need to
24:05
update our ID in lib.rs which is stored in the programs folder and it's our
24:11
entry point for our program so yeah let's just update that
24:17
and yeah finally we just need to build and deploy one more time and make sure
24:22
that our program is compiled uh with the right identifier so let's just run anchor build
24:32
so we're good we're finished and then we just run anchor the boy
24:43
yeah and now let's just let's just verify that our program ID matches the
24:48
program ID in our lib.rs and in our anchor.tomo file
24:54
let's just check out the script section as you can see we are defining a test script and we can run all these test
25:01
script using a command anchor run and the name of the command which in our case will be pre-generated and it will
25:09
say test uh it will be run through yarn and it will execute all of the typescript files in our test folders if
25:16
you check out the test folder you can see that anchor already uh
25:22
created a test for us that will check if the program is initialized
25:28
so yeah we can just go ahead and run anchor run test
25:34
it will connect to our local validator and as you can see it's passing the
25:39
initialization test and you should get really familiar with this process because you'll be running
25:44
tests a lot during the development because the usual process is writing
25:50
tests for all of your programs features before you actually get into writing the
25:55
whole front end that will be interacting with your Solana program you know how to work with our anchor workspace let's
26:02
jump back into the lib.rs file and try to or start working on our calculator so
26:10
let's just Begin by uh with erasing some of the boilerplate code that the anchor generated for us
26:16
erase the account structure and the initialize function and in our case let's just create a new
26:23
create function that will essentially just create a new instance of our Solana
26:29
calculator so we can do that by putting in uh Pub FN essentially what we know
26:35
from our last rust lecture and let's just call it create and now for our function parameters we
26:42
need something that we will call context context in Anchor will essentially help us uh access the accounts that the user
26:51
is supplying while calling this function so yeah let's just um context of a type create
26:58
uh we'll get back to it a little bit later it's really important and now
27:04
add init message init message will be just a string that will be fetching and
27:10
then uh essentially setting the value of this init message to one of the accounts that
27:17
the user is supplying to this function and now we just need a return value for a function which will be program result
27:24
uh in case of anchor
27:29
so yeah uh we have created for and skeleton for our create function and
27:38
our create function takes context as all of you already know Solana is stateless
27:43
so we have to supply all the accounts that we want to work with we will be accessing them using our context and
27:50
we're also having an init message parameter that will essentially take our
27:55
string in our parameter and assign it to one of these accounts and so now if we want to access these
28:02
accounts let's just create a new variable we'll call it calculator
28:08
make it immutable because we'll be working with the data assigning a new data to our accounts and then we can
28:14
just call CTX which is our context accounts and the name of the account that we want
28:21
to fetch in our case it's calculator and now we have our account in our
28:28
variable and we want to set the value uh in some of the fields in our account
28:34
so we can just access it calculator just call it the greeting
28:39
and set it to our edit message so now we have assigned our init message
28:47
to our greeting in our account in our calculator account and we need to let Solana know that the execution went
28:53
through successfully and the function is complete essentially and we can do it by
28:58
calling an OK statement okay statement with curly brackets
29:05
inside of it this will let the Solana runtime know that the function is
29:11
essentially over and is successfully completed the execution uh so now we know how to define a new
29:18
function in anchor and we just need to know a little bit more about the context
29:23
and how we'll be defining the structure of all of these accounts that we'll be working with
29:30
we have created our create function and we need to dig a little bit deeper into the context so context is essentially a list of
29:37
accounts that the user will be supplying when invoking this function and we can create our context by using a macro that
29:44
is called derive so let's just put in a hashtag
29:50
derive and our contacts will be derived from accounts
29:57
now we can just essentially Define our context using a structure just like we learned in our rust lecture
30:05
so let's just do a public structure that we will call create
30:12
and now we can just put in all the fields that we want to have in our context
30:17
so first of the accounts that we are accessing in our function is the calculator account so let's just add
30:23
that one in and it will be a type of account
30:37
foreign type of the calculator account
30:42
you'll obviously need to Define that one later the really important thing uh here is
30:48
that we are trying to initialize our calculator account here so the calculator account does not exist at the
30:55
time of the invocation so we need to specify that this account needs to be created or initialized and
31:02
we can do it by specifying another macro
31:10
and specifying the init we want to initialize the account we
31:16
need to specify the pair for the initialization will be in our case will be user and we also need to specify
31:22
amount of space that our calculator will allocate so let's just put like
31:28
264 in but it's obviously recommended to calculate calculate how much space your
31:34
account will need to kind of save up on the space on Solana
31:40
so now the other accounts that we need is the is the user which will be essentially the signer of the create
31:47
function and also the system program so let's just Define our Pub user which
31:55
will be a type of signer and we also need to reference the system
32:02
program we have already mentioned that in when
32:08
we showed our when we showed account structure in this lecture so we'll be referencing a program
32:15
system
32:20
yeah so essentially that's how you define uh context for your function using a
32:26
rust structure and now we need to go ahead and create our calculator account
32:31
that we are referencing right here so let's we can do it again by setting
32:38
up a macro a hashtag account and then leveraging rust structures to define a
32:44
structure for our calculator account so let's just do public struct that we
32:50
call a calculator and let's just put all the fields that we need inside our calculator account so
32:56
we are accessing the greeting inside our calculator here in the create function
33:01
so let's just add greeting in our calculator it will be a type of string
33:07
and let's just also add result which will be integer 64 in our case
33:13
and we'll be adding result into our calculator account because we'll be saving all of the results of the all
33:20
operation that we will integrate inside our result inside the calculator account
33:26
so when the user does some form of application or some form of calculation using our Solana calculator the result
33:33
will be always saved inside a calculator account that he's owner of
33:39
we know how to create a function an appropriate context for a function and also how to define a calculate like how
33:46
to define a structure for an account so I have added another function to our
33:51
calculator which is essentially an addition function and you can see that I'm following the same concept as before
33:58
setting up a context I've created an addition context and I'm also
34:04
letting users Supply number one and number two both of them integer 64. and
34:10
what I'm doing I'm yet again accessing a calculator using a CTX
34:16
accounts calculator and then I'm adding it to a result essentially adding these
34:22
two numbers in our function parameters after that I'm saying to Solana runtime
34:28
that the calculation went through and the function is essentially over
34:34
as you can see I'm creating a separate context for our addition for our add
34:40
function that I called addition if we take a look at the addition the
34:45
only account that we are supplying in our context here is the calculator and
34:51
as you can see we are supplying a mutable account that is already created in our initialize function
34:58
so if user wants to access all of the features of our calculator he needs to
35:04
call to create function first to actually initialize his calculator account pay for the initialization and
35:12
allocate all the space necessary for us to save all of the data from all the operation we're planning to do using our
35:19
calculator
35:25
so now when we're happy with our implementation in the Solana program we
35:30
need some way to test out our implementation before we get into implementing a whole front end or
35:36
deploying it to devnet test net or eventually into the domain net you have
35:41
to write a proper test to test out all the functions so we can do it using the internal
35:47
testing framework in Anchor using the maca and that is done by creating a
35:54
typescript of testing scenarios as I've shown before anchor is already
35:59
pre-generating your testing scenario for the hello world program that we've shown before
36:05
but I have prepared a testing scenario for our calculator so it works in a way of creating a
36:13
predescribed collection of it blocks so in this case I've created a
36:19
collection of tests which I call calculator which is aimed to test all the functionality in our calculator
36:25
program
36:30
before we start defining any of the test uh in test it blocks we have to set the
36:36
provider for for our for our for our test in this case we're setting up the
36:41
provider to a local cluster that we're running on our computer after that we need to reference the
36:47
program itself this creates some form of abstraction that allows us to call methods in our soul program
36:53
so I'm doing that by creating a constant program and then referencing our workspace name which is calculator in
37:00
this case after after we have a reference to our program we need to start generating a
37:06
key better for our calculator account as I said before we have our calculator account that is storing the greetings
37:13
message and the rest result for all the operation we're doing with our calculator
37:21
so yeah we obviously need to generate the key pair because we'll be interacting with interacting with the same calculator account in different uh
37:29
in different testing scenarios or different test it blocks
37:35
after that I'm just creating a constant text that I'll be using in our create function to store it inside the inside
37:42
the calculator account so after we have all this ready we're
37:48
pretty much set to Define all of our it testing blocks the first test blocks that I'm creating is
37:55
um is a test block that will verify our create function so I'm calling it creating calculator
38:01
instance so then we can use program methods to
38:07
call different methods in our program so we are essentially referencing the
38:12
program we did here before at the line 13.
38:18
so now you can see I'm calling the method create and I'm supplying my text which is expected because uh we expect
38:25
user to send out some initialization message here in the function parameters
38:32
and we also need to supply all of the accounts we want to fit into the context of our create function
38:39
so we are adding our calculator which is using the calculator pair or
38:46
the keypad that we have generated before we're also referencing the user which is
38:52
the public key of the wallet that is interacting with the tests and also
38:57
referencing the system program using the system program.program ID which is a
39:02
constant directly in testing framework after that we also specifying all of the
39:08
signer Rich assigners which in this case is the calculator pair then using the RPC method this will send
39:15
out a this will essentially call out function in the Solana program using an RPC in this case using an RPC to
39:23
localhost after we successfully uh
39:29
I call this function we need some form of verification if everything went okay
39:34
so we are doing that by fetching our calculator account back so yet again
39:40
we're using the calculator pair public key we have generated before to fetch
39:46
the contents of the particular account after we have the content of the particular account we can use the expect
39:53
functionality to kind of compare the two different values in our case we're comparing the content
40:00
of our account which is the greeting if it's equal to the text text we have
40:06
sent out before using our RPC to our program if this condition is met then the test
40:14
it block passes however if these two values are not equal then the
40:22
whole test block fails so after we test out our calculator
40:29
creating a calculator instance we're going up to another it block which is a different uh different different test
40:37
and all these tests will be executed in order so right now we're testing addition function
40:43
so I'm essentially doing the same thing as in the previous IT block but instead of calling the create function I'm
40:49
calling the add function we have defined in our program in this case we're not expecting string
40:56
but we're expecting to a different integer64 numbers
41:02
so as you can see I'm passing out two numbers using anchor BM so we have a number two and number three
41:11
which essentially means if we call this function with number two and three and expected output should be should be 5
41:18
and that should be stored in our calculator account we're also supplying accounts for our
41:24
context for the add functionality which in our case is just a
41:30
calculator account that we have generated in the previous step so yet again I'm passing the calculator
41:36
pair public key as our kind of calculator account that we'll be writing are a result into
41:43
yet again I'm executing the function using our RPC and then doing the same thing as before
41:50
fetching the account data back and checking if the expected result is
41:57
equal to 5 or 6 in our case it should be five if you want to pass the test
42:02
now when we're happy with our test the same situation as before we're just
42:08
trying to run anchor run tests and it will run throughout all of the test blocks we have defined in our
42:14
typescript so now we can see that creating
42:19
calculator instance went okay and the addition was the same result and it went okay too
42:25
but for example if you want to demonstrate how the failing how the failing tests work
42:31
we have an addition of two numbers two M3 and let's just say we expect an output of 6 which is obviously wrong and
42:38
it will result in a failed test so if I try to execute the test right now
42:45
our first it block passes essentially creating a new calculator instance but when we're trying to test the audition
42:52
it will start to fail why because in our case the expected output is 6 however the program works
42:59
correctly and stores number five in the account data and we can see it right here the
43:06
expected output should be six but the actual output was 5. so this is essentially how we can very
43:14
easily Define different test blocks to test out if our program implementation on Solana blockchain is correct
43:21
so after we're happy with all of our tests let's just say we switch it back to five
43:28
and we run the test again and all of the tests are passing then we
43:34
can switch up from our local test validator to for example test that a
43:40
devnet and deploy the program there when we're happy with the functionality on on the definite or test net we're good to
43:46
go into the production and deploy the game on the magnet
43:53
so if you're interested in exploring these test scenarios even further I'll
43:58
be sharing my GitHub repo with all the calculator and tests and you can try to add your own
44:06
functionality into the calculator for example multiplication and stuff like that and
44:12
then write appropriate tests for these for these functions too but essentially you'll be just doing the
44:18
same thing all over again instead of just executing addition you'll be just multiplying two different
44:25
numbers speaking of lecture three in Solana or vendor School of Solana uh
44:31
I hope you learned something about how to implement basic calculator program on
44:36
slana blockchain that's why I started doing calculator in the previous lecture I kind of wanted you to see the
44:43
difference between raw rust implementation outside of Solana and porting out the same program to a Solana
44:50
blockchain also don't forget to check out the check
44:56
out the task for this lecture We'll be asking you to implement more functionality into our calculator sample
45:04
that you can get on our GitHub and after you're happy with your program
45:09
don't forget to submit it at the end of the Sunday of this week
45:14
starting next week we'll be doing a little bit more complicated program we'll be implementing our own Twitter
45:20
clone using Solana we'll be also talking a little bit about PDA accounts and yeah
45:27
that pretty much ties down to our lecture about the introduction into a
45:32
Solana programming model and I hope to see all of you next week and if you have any feedback on our
45:38
lecture please don't forget to submit it using our Google form thank you again and see you next time
45:46
thank you

0:01
大家好，欢迎来到 Solana 冬季学校第三讲，我们将讨论 Solana 编程模型
0:09
让我们简单介绍一下这些讲座以及即将举行的讲座
0:15
因此，在本次讲座中，我们将讨论 Solana 编程模型的简要介绍，这意味着制作一个
0:21
关于账户和交易的简要概述，这些几乎是我们所讨论的基本核心概念
0:27
需要知道如何在 Solana 上开始我们的编程之旅，我们还将做一个实践示例
0:33
这意味着建立一个新的锚定项目，然后在其中编写您的第一个 Solana 程序，这将是
0:39
计算器，我们还将在摩卡测试框架中编写一些测试
0:45
展望未来，我们还将学习由程序派生的 PDA
0:51
帐户，并在我们的前端、typescript 和 next.js 上进行一些工作，以与我们的 Solana 程序进行交互
0:58
因此，我们将构建我们的项目，这将是您的第一个正确的 Solana 程序（Twitter 克隆）
1:05
使用小费功能，我们还将在我们自己的中编写适当的测试
1:10
我们称之为旋转门的测试框架
1:15
那么让我们来谈谈 Solana 的核心概念，应用程序通过以下方式与 Solana 集群交互：
1:22
使用一条或多条指令发送交易，Solana 运行时将这些指令传递给编程并
1:29
专业版程序由应用程序开发人员预先部署，然后执行指令
1:36
如果任何指令无效，则对每笔交易按顺序自动执行所有帐户更改
1:43
交易被丢弃，所以你们中的一些人可以立即发现呃
1:49
或者如果您曾经使用过 SQL 数据库等，则可以立即了解或了解一些数据库方面的知识
1:57
因此，如果我们谈论 Solana 程序，它本质上是由 Solana 区块链运行的一段代码
2:05
Solana 中的程序是无状态的，这意味着您无法在其中存储任何数据，这是两者之间的显着差异
2:12
以太坊上的智能合约和 Solana 上的程序，因为例如，如果您正在编写以太坊程序，您可以创建
2:19
变量，您可以直接在智能合约中存储一些数据，但这在 Solana 上不成立，我们在 Solana 上
2:27
包含该程序的帐户和包含该程序的帐户之间有明显的区别
2:33
然后将用户数据或不同的帐户提供给程序
2:38
在执行的初始化期间，是的，所以本质上我们使用帐户
2:46
为了存储程序代码或我们所说的字节码和用户数据，我们可以
2:51
绝对可以将它们想象为区块链上的单独文件
2:56
所以是的，我们的第一个核心概念是账户，有三种不同的类型
3:03
帐户 我们有数据帐户，用于存储我们有程序的数据
3:09
用于存储可执行文件或某种形式的可执行负载或字节码的帐户
3:15
我们有本地帐户，表明 Solana 上的本地程序
3:21
是所有验证器的基本组成部分，例如系统权益 BPF 加载器
3:28
所以是的，在底部我们可以看到一些不同领域的可视化
3:33
在帐户中，我们稍后将详细讨论每个帐户
3:40
所以如果我们有的话，以太坊和 Solana 之间就有明显的区别
3:45
例如，一个非常简单的计数器，它的增量和减量功能在以太坊上我们有某种形式的智能
3:52
合约帐户，包含数据和一些可执行的 evm 字节代码
3:57
另一方面，如果我们查看 Solana 可视化，我们的程序帐户是可执行的并且具有一些
4:04
数据中可执行字节代码的形式，我们有一个数据帐户和该数据
4:09
帐户呃包含某种形式的用户数据，并且之间有明显的区别
4:17
可执行字节码和我们提供给程序的用户数据
4:24
呃，在这些数据计数中，呃还有两种类型，其中之一是
4:30
系统拥有的帐户和 BDA 或程序派生的地址帐户以及每个
4:36
帐户呃在某种程度上不同并且
4:42
我们将在下一堂课中更多地讨论 bda，所以是的，帐户只能由以下人员拥有
4:49
这些帐户的程序所有者对其拥有的帐户拥有完全的自主权，并且
4:55
由程序创建者来限制这种自主权，并由程序的用户来限制
5:00
程序来验证程序的创建者是否真的这样做了
5:07
那么让我们简单谈谈 Solana 帐户中通常存储的所有字段
5:14
所以呃 main 本质上是一个密钥，它是一个 pub key，用于
5:19
标识一个帐户，长度为 256 位，通常是公钥对
5:28
另一个是程序所有者，它是另一个公共密钥，表明谁是
5:34
该帐户的所有者，也是唯一可以将数据写入该帐户的帐户
5:40
只有自己的帐户的 r 可以分配一个新的所有者 所有者，并且在它被分配后
5:45
完全清零，这意味着在所有者分配新所有者之前需要将数据有效负载清零
5:52
本质上是转移帐户的所有权另一个重要的是 LAN 端口
5:59
该帐户拥有的多个 LAN 端口，并且仅由该帐户的所有者创建
6:05
减去其土地力量，每个人都可以存入该帐户，这意味着我们可以将 LAN 端口发送到我们的任何帐户
6:12
想要但是如果我们想减去这个数据或减去石灰端口或本质上
6:18
以我们成为该帐户所有者所需的任何方式使用它们
6:25
然后显然是数据有效负载，本质上是原始数据字节
6:31
该帐户存储的数组可以是用户数据也可以是可执行文件
6:37
有效负载 最多 10 MB 的可变存储并且只能写入
6:42
由帐户所有者创建，当前无法调整大小
6:49
所以我们还有一些非常重要的标志，其中之一是标志
6:55
称为可执行文件，它本质上标记该帐户是否可执行
7:01
在呃部署过程中，现在我们在部署过程中标记了这一点
7:06
它告诉 Solana 区块链这个账户的数据本质上是 Solana 所记录的字节码
7:12
可以执行可执行帐户一旦被标记为最终帐户就完全不可变
7:18
本质上，如果我们部署它们，数据负载在任何方面都不是不可变的，并且它是或它们由 BPF 拥有
7:26
加载程序呃还有一些东西是
7:32
称为租金和在自己的帐户上存储数据的成本，用于维护和出售
7:38
如果您保持最低余额，它的资金来源是我们所说的租金
7:43
相当于帐户中两年租金的支付，您的帐户将从 Wrangler 租金中延长
7:49
呃，您可以通过关闭帐户来收回租金，所以本质上，如果不再需要该帐户，所有者可以关闭
7:56
这个帐户，它会将 LAN 端口发送回您的钱包
8:03
呃租金是在两个不同的时间支付的呃当它被引用时
8:08
交易并希望在一个纪元中收取一定比例的租金
8:14
账户呃，账户收取的租金的百分比被销毁，而其余的
8:20
如果账户没有足够的资金，则在每个时段结束时分配给投票账户
8:26
支付租金，帐户将被取消分配，数据将被删除
8:33
从本质上讲，这告诉我们必须保持某种形式的平衡才能保持
8:39
我们的帐户有效，因此这引入了本质上引用-取消引用的概念
8:44
垃圾收集，因此如果某些帐户没有足够的租金来支付，它将自动进行
8:50
解除分配以释放 Solana 区块链上的空间另一个非常重要的标志是
8:58
签名者标志，本质上表明该帐户是否已签署交易，但实际上不是
9:06
存储在帐户中，但它只是一个运行时元数据，另一个运行时元数据是可写的
9:13
flag 表示该帐户是否可写
9:20
因此，您必须将所有这些联系起来，我们有 Solana 帐户的七个基本规则
9:26
所以首先是每个帐户都有一个唯一的地址和一个唯一的所有者owner
9:32
对所拥有的账户拥有完全的自主权，只有数据的账户所有者才能修改其数据并借记Lan
9:40
正如我提到的，端口程序不存储我们拥有单独帐户的任何数据
9:46
并且帐户必须支付租金才能生存并且不能被重新分配
9:51
Solana 任何人都可以将其数据帐户记入 Lan 端口，但如果您愿意
9:57
花费它们并且您需要成为帐户所有者帐户的所有者可以分配一个
10:03
新的所有者如果数据如果帐户数据被清零所以如果您想转移帐户的所有权我们
10:10
需要从根本上删除该特定帐户中包含的数据让我们来谈谈交易
10:18
Solana 上的基本操作单元称为指令
10:23
通常包含我们正在调用的预期程序的程序 ID，该数组包含我们打算调用的所有帐户
10:31
读取或写入与我们之前有关帐户的章节相关的关系
10:37
我们本质上是向邪教程序和
10:43
指令数据是特定于预期程序的字节数组
10:49
所以就像任何形式的 SQL 数据库一样，我们可以捆绑多个指令
10:57
如果我们正在形成交易，那么我们称之为交易
11:04
本质上提供了我们打算读取或写入一个或多个指令的所有帐户的数组
11:11
最近的区块哈希值，这非常重要，并且该特定交易的一个或多个签名
11:18
我们还指定了一个可写签名者，它是首先序列化的帐户，并且将成为
11:25
整个交易所以让我们来谈谈吧
11:31
关于 ab深入研究交易
11:39
所以呃 Solana 运行时需要指令和事务来指定
11:45
当交易提交到时我们可以在这里看到的所有帐户的列表
11:52
一个集群，运行时将按顺序和原子地处理这些指令
11:58
对于每条指令，接收程序将解释其数据数组
12:03
并在我们提供的程序可以拥有或显然可以的特定帐户上进行操作
12:11
如果顺利的话整个交易都会提交到
12:16
另一方面，如果我们得到某种形式的错误代码并且错误会返回整个
12:22
事务将立即失败，所以即使我们创建了，我们也是呃
12:28
我们正在执行多个呃指令，其中一个指令失败了
12:33
整个交易都会被还原，任何旨在借记的交易
12:42
帐户或修改其数据需要特定帐户持有人的签名任何将被修改的帐户
12:50
自动标记为可写 uh 通过 Solana 运行时使用 uh，无需
12:57
持有者的许可，只要交易费用对涵盖必要的租金和交易成本
13:06
另外让我们回到最近的博客哈希
13:11
在提交之前，所有交易都必须参考最近的阻塞，这是有充分理由的
13:18
它用于防止重复并消除陈旧的事务，并用于
13:24
每笔交易的最大年龄约为 150 个区块，大约为 1 和
13:29
一分 30 秒 呃，但随着我们的进展，情况显然会有所不同
13:36
但本质上如果交易被标记为过时呃或或超过其最大值
13:43
年龄它会被自动消除，不会被处理并恢复回来
13:51
所以，是的，让我们将其总结为一个结构说明
13:56
如果指令的任何部分导致整个事务失败，事务将按顺序自动处理
14:03
如果失败，我们对交易有某种形式的限制并阻止该程序
14:09
避免滥用计算资源，每笔交易都提供计算
14:14
预算呃有五个非常重要
14:20
关于交易我们需要了解的事情呃我们可以考虑一下所有的
14:26
由于某些原因，任何用户的程序输入都可能是潜在的恶意的
14:32
显然可以组成这些交易，这意味着呃它可以是
14:39
交易和用户还提供了所有帐户，因此我们需要开发人员在这里做什么
14:45
从角度来看，我们需要检查签名者，我们需要检查所有者，我们需要
14:51
要注意交易中意外的指令顺序，我们显然还需要
14:58
覆盖来自用户一方的任何形式的无效输入
15:05
当我们设计这些交易时还要考虑计算预算
15:10
在我们的程序中，现在我们了解了帐户和
15:17
交易让我们建立我们的第一个锚定项目
15:23
因此，在创建我们的项目后，让我们继续创建一个新的锚项目
15:29
锚项目，我们将简要浏览一下项目的不同文件夹，并介绍它们在我们的项目中的含义。
15:35
项目以及我们将如何与他们合作，所以我相信你们所有人都可能已经
15:40
遵循我们在第一堂课中给出的说明，但如果您不这样做，请切换回讲座
15:47
第一，安装所有必要的工具，以防出现任何问题
15:53
你的纱线包管理器呃请使用这个命令安装它，因为我
15:59
相信锚正在使用纱线包管理器，我们没有提到我们没有提到
16:05
在我们的第一堂课中，但是当我们准备好时，嗯
16:12
与 JavaScript 或 Typescript 中的 npm 包管理器非常相似，我们可以继续在其中输入锚点和名称
16:19
我们的 Solana 程序让我们将 Solana 程序称为 hello world 或 for
16:24
示例计算器 我将其称为计算器，因为我们将把 hello world 示例扩展为
16:32
稍后会有完整的计算器，所以现在锚点将初始化
16:38
整个项目创建了一个新的锚定工作区，您可以在初始化后移入其中
16:45
已完成，我们的项目文件夹中有一些非常重要的文件
16:52
所以让我们继续切换到我们的计算器项目
16:58
现在我们在我们的项目中，我们可以看到我们有几个需要讨论的文件，所以呃
17:06
一些有趣的呃我们将有一个呃点锚文件夹这将包括你这将包括大多数
17:13
呃最近的程序块以及我们将使用的本地本地账本
17:19
测试我们有一个应用程序文件夹应用程序文件夹本质上是一个空的
17:25
文件夹，你可以用它来保存你的前端，如果我们要使用单声道存储库的话
17:31
主持我们的完整将完整的堆栈解决方案集成到一个 GitHub 存储库中，所以是的，我们肯定会使用它
17:37
稍后我们将创建一个单独的打字稿或在 JS next.js 旁边
17:43
解决方案在应用程序文件夹中我们有一个程序文件夹，这是
17:49
对我们来说最有趣的一个本质上是包含 Solana 程序的文件夹
17:54
呃，它可以包含多个程序，但最初我们只会使用一个
18:01
单个程序，我们还有一个测试文件夹，测试文件夹将包含所有
18:08
我们的测试使用 mocha 测试框架在 typescript 中开发
18:15
我们还有一个迁移文件夹 迁移文件夹我们可以保存我们的部署
18:21
以及我们程序的迁移脚本，其中一个非常重要的脚本是anchor.tamil
18:28
anchor.dominal 本质上是配置整个工作空间的文件
18:33
对于您的程序，我们还有一个cargo.domo，其中包括
18:39
我们在程序工作区中使用的所有包
18:48
现在，当我们的锚工作区全部设置完毕后，让我们继续打开它
18:54
在我们首选的 IDE 中，我将使用第一讲中提到的 Visual Studio Code
19:01
在我们进入实际的代码之前，让我们简单地讨论一下整个过程
19:07
开发过程呃你可以使用不同的方式如何
19:12
测试你的程序我建议你运行一些东西
19:18
称为本地本地账本，这本质上是
19:24
呃，本地 Ledger 基本上是 Solana 集群内部的模拟
19:29
您的本地计算机，因此在本地构建时，我们实际上不想将任何内容发送到
19:35
Solana 区块链所以这正是我们想要的，不幸的是我们运行本地
19:42
Ledger 非常简单，所以在我们实际运行本地 Ledger 之前，让我们
19:48
只需设置我们的 Solana CLI 即可与本地主机或本地主机对话
19:54
Ledger，我们可以通过调用 Solana 配置将 URL 设置为本地 Ledger 来做到这一点
20:00
我们本质上是在使用 RPC 来运行我们的本地账本
20:06
一个不同的终端，所以让我们进行设置，我们将得到 RPC URL 和 websocket URL 的确认
20:14
在我们实际运行之前设置为本地主机
20:20
Ledger 让我们验证一下我们是否已准备好键盘，以便我们调用 Solana 地址
20:25
正如您所看到的，我已经生成了密钥对，但如果您没有密钥对，您可以运行 Solana Keygen
20:32
正如第一讲中提到的，现在我们的 Solana CLI 是 uh
20:38
与我们本地的 Ledger 交谈，让我们启动一个 Ledger，这样我们就可以通过创建来做到这一点
20:44
例如，一个新的终端实例，我可以在 IDE 中创建新的实例，然后进入新终端
20:51
让我们运行名为 Solana Dash 测试 Dash 验证器的逗号命令
20:58
这将在我们的本地计算机上初始化 Solana 的模拟，您可以注意到它将生成一个
21:05
名为 test Dash Ledger 的文件夹，该文件夹本质上包含本地分类帐的状态，因此对于
21:13
例如，如果您停止 Ledger，并在返回开发后恢复它，它将加载状态
21:18
从此文件夹中删除，但请注意，测试 Ledger 文件夹随着时间的推移而增长
21:23
显然时间到了，现在我们都已经准备好了
21:29
本地集群我们可以验证我们的帐户上是否有一些灵魂
21:35
通过称沙龙为平衡，正如你所看到的，我有一些灵魂空投到
21:40
我的本地账本账户里可能有很多灵魂，所以
21:45
你基本上已经可以开始了，但是在你的开发过程中整个开发过程如下
21:52
您将使用本地验证器来测试您需要的所有内容，当您对程序感到满意时，您就可以
21:59
基本上可以交换部署到本地网络的 RPC，或者抱歉
22:05
开发网或测试网对其进行测试，并邀请其他用户进行测试
22:10
编写您的程序，当您对此感到满意时，您可以通过部署到主网来将其交付到生产环境中
22:19
是的，现在我们已经准备好了，我们只需要知道几个命令我们将如何处理东西
22:24
在这里，在我们实际部署我们需要编译的程序之前
22:29
将其转换为字节码，可以通过 Solana 运行时进行杂交，并且
22:36
我们可以通过调用锚点构建来做到这一点
22:42
呃，你可以看到你可以看到一些错误，但这对我们来说并不是很有趣。
22:48
第一次运行它可能会编译所有依赖项，因此需要一些时间，但是呃，是的，本质上你应该
22:55
是的，在某个时间受到完成呃的欢迎，但是当你
23:02
完成你的脚踝构建后，你就可以基本上部署你的程序了，所以让我们开始锚定
23:09
部署，您可以看到它发送了 177 笔交易来部署我们的程序
23:17
呃，它会说部署成功，您将获得您的程序 ID
23:22
所以现在当我们完成时完成了我们的初始部署，我们在终端中获得了我们需要的程序 ID
23:30
现在要做的是更新工作区中的程序 ID，这是因为在我们最初的
23:38
部署后我们根本不知道部署后我们的程序的公共地址是什么
23:45
因此，当我们完成初始部署后，让我们继续查看anchor.tamil 文件，您可以看到我们
23:53
我们的程序有某种形式的预先生成的 ID，所以让我们继续将其替换为我们的程序 ID
24:00
部署呃保存那个，我们还需要
24:05
更新 lib.rs 中的 ID，该 ID 存储在程序文件夹中，这是我们的
24:11
我们程序的入口点所以是的，让我们更新它
24:17
是的，最后我们只需要再构建和部署一次并确保
24:22
我们的程序是用正确的标识符编译的，所以让我们运行锚构建
24:32
所以我们很好，我们完成了，然后我们就锚定男孩
24:43
是的，现在让我们验证一下我们的程序 ID 是否与
24:48
lib.rs 和anchor.tomo 文件中的程序ID
24:54
让我们看看脚本部分，你可以看到我们正在定义一个测试脚本，我们可以运行所有这些测试
25:01
使用命令锚运行的脚本和命令的名称，在我们的例子中将预先生成，并且它将
25:09
说测试呃它将通过纱线运行并且它将执行我们的测试文件夹中的所有打字稿文件如果
25:16
你查看测试文件夹，你可以看到该锚点已经呃
25:22
为我们创建了一个测试来检查程序是否已初始化
25:28
所以是的，我们可以继续进行锚定运行测试
25:34
它将连接到我们的本地验证器，正如您所看到的，它正在通过
25:39
初始化测试，您应该非常熟悉这个过程，因为您将运行
25:44
在开发过程中进行了大量测试，因为通常的过程是编写
25:50 下午
在真正开始编写程序之前测试所有程序功能
25:55
将与您的 Solana 程序交互的整个前端您知道如何使用我们的锚工作区让我们
26:02
跳回 lib.rs 文件并尝试或开始使用我们的计算器
26:10
让我们从删除锚点为我们生成的一些样板代码开始
26:16
删除帐户结构和初始化函数，在我们的例子中，让我们创建一个新的
26:23
create 函数本质上只是创建 Solana 的一个新实例
26:29
计算器，所以我们可以通过输入 uh Pub FN 基本上我们所知道的来做到这一点
26:35
从我们上一次 Rust 讲座开始，我们将其称为“创建”，现在对于我们的函数参数，我们
26:42
需要我们在 Anchor 中称为上下文 context 的东西，本质上会帮助我们访问用户的帐户
26:51
在调用这个函数时提供，所以是的，让我们创建一个类型的上下文
26:58
呃，我们稍后再讨论这件事，这真的很重要，现在
27:04
添加初始化消息初始化消息将只是一个将被获取的字符串
27:10
然后呃本质上将此初始化消息的值设置为其中一个帐户
27:17
用户正在向该函数提供内容，现在我们只需要函数的返回值，该函数将作为程序结果
27:24
呃，如果有锚的话
27:29
所以是的呃我们已经为我们的创建函数创建了框架并且
27:38
我们的创建函数需要上下文，因为大家都知道 Solana 是无状态的
27:43
所以我们必须提供我们想要使用的所有帐户，我们将使用我们的上下文来访问它们
27：50
我们还有一个初始化消息参数，它本质上将采用我们的
27:55
参数中的字符串并将其分配给这些帐户之一，所以现在如果我们想访问这些帐户
28:02
账户让我们创建一个新变量，我们称之为计算器
28:08
使其不可变，因为我们将使用数据将新数据分配给我们的帐户，然后我们可以
28:14
只需调用 CTX，这是我们的上下文帐户和我们想要的帐户的名称
28:21
在我们的例子中获取它的计算器，现在我们的帐户在我们的
28:28
变量，我们想要在帐户的某些字段中设置值 uh
28:34
这样我们就可以访问它计算器，只需将其称为问候语即可
28:39
并将其设置为我们的编辑消息，所以现在我们已经分配了我们的初始化消息
28:47
我们的计算器帐户中的帐户中的问候语，我们需要让 Solana 知道执行已进行
28:53
成功通过，功能基本完成，我们可以这样做
28:58
调用 OK 语句 用大括号调用 OK 语句
29:05
在它的内部，这会让 Solana 运行时知道该函数是
29:11
基本上结束并成功完成执行，所以现在我们知道如何定义一个新的
29:18
锚点中的函数，我们只需要了解更多有关上下文的信息
29:23
以及我们将如何定义结构我们将使用的所有这些帐户的真实性
29:30
我们已经创建了 create 函数，我们需要更深入地了解上下文，因此上下文本质上是一个列表
29:37
用户在调用此函数时将提供的帐户，我们可以使用宏来创建上下文
29:44
被称为“导出”，所以我们只需放入一个主题标签
29:50 29:50
派生，我们的联系人将从帐户派生
29:57
现在我们可以使用一个结构来定义我们的上下文，就像我们在 Rust 讲座中学到的那样
30:05
所以让我们创建一个公共结构，我们称之为 create
30:12
现在我们可以在我们的上下文中输入我们想要的所有字段
30:17
所以我们在函数中访问的第一个帐户是计算器帐户，所以我们只需添加
30:23
里面的一个，这将是一种帐户
30:37
计算器帐户的外国类型
30:42
显然你需要定义一个稍后真正重要的事情是
30:48
我们正在尝试在这里初始化我们的计算器帐户，以便计算器帐户不存在
30:55
调用的时间，因此我们需要指定需要创建或初始化该帐户，并且
31:02
我们可以通过指定另一个宏来做到这一点
31:10
并指定我们要初始化帐户的 init
31:16
需要指定初始化对，在我们的例子中将是用户，我们还需要指定
31:22
我们的计算器将分配的空间量，所以让我们像这样
31:28
264 英寸，但显然建议计算一下您的空间有多少
31:34
帐户需要节省 Solana 上的空间
31:40
所以现在我们需要的其他帐户是用户，它本质上是创建的签名者
31:47
函数和系统程序所以让我们定义我们的 Pub 用户
31:55
将是一种签名者，我们还需要引用系统
32:02
节目中我们已经提到过，当
32:08
我们在本次讲座中展示了帐户结构，因此我们将引用一个程序
32:15
系统
32:20
是的，本质上这就是你如何使用 a 为你的函数定义呃上下文
32:26
Rust 结构，现在我们需要继续创建计算器帐户
32:31
我们在这里引用，所以我们可以通过设置再次做到这一点
32:38
创建一个宏标签帐户，然后利用 Rust 结构来定义
32:44
我们的计算器帐户的结构，所以让我们做公共结构
32:50
调用计算器，让我们将所需的所有字段放入计算器帐户中，这样
32:56
我们正在创建函数中访问计算器内的问候语
33:01
所以让我们在计算器中添加问候语，它将是一种字符串
33:07
我们还添加结果，在我们的例子中它将是整数 64
33:13
我们将把结果添加到我们的计算器帐户中，因为我们将保存所有的结果
33:20
我们将在计算器帐户内的结果中集成的操作
33:26
因此，当用户使用我们的 Solana 计算器执行某种形式的应用程序或某种形式的计算时，结果
33:33
将始终保存在他拥有的计算器帐户中
33:39
我们知道如何创建一个函数，一个函数的适当上下文，以及如何定义一个计算，例如
33:46
定义帐户的结构，因此我向我们的
33:51
计算器本质上是一个加法函数，你可以看到我遵循与之前相同的概念
33:58
设置上下文我创建了一个附加上下文，而且我还
34:04
让用户提供第一和第二，它们都是整数 64。并且
34:10
我正在做什么 我再次使用 CTX 访问计算器
34:16
帐户计算器，然后我将其添加到结果中，本质上是添加这些
34:22
之后我对 Solana 运行时说的是函数参数中的两个数字
34:28
计算已经完成并且函数基本上已经结束
34:34
正如你所看到的，我正在为我们的添加创建一个单独的上下文
34:40
我称之为加法的函数如果我们看一下加法
34:45
我们在上下文中提供的唯一帐户是计算器和
34:51
如您所见，我们提供了一个已在初始化函数中创建的可变帐户
34:58
因此，如果用户想要访问我们计算器的所有功能，他需要
35:04
首先调用创建函数来实际初始化他的计算器帐户并支付初始化费用
35:12
分配我们所需的所有空间来保存我们计划使用我们的操作执行的所有操作的所有数据
35:19
计算器
35:25
所以现在，当我们对 Solana 计划的实施感到满意时，我们
35:30
在我们开始实现整个前端之前需要某种方法来测试我们的实现或者
35:36
将其部署到 devnet 测试网或最终部署到 dom艾因网你有
35:41
编写一个适当的测试来测试所有功能，这样我们就可以使用内部
35:47
使用 Maca 在 Anchor 中测试框架，这是通过创建一个
35:54
正如我在锚点之前所示的测试场景的打字稿已经
35:59
为我们之前展示的 hello world 程序预先生成测试场景
36:05
但我已经为我们的计算器准备了一个测试场景，因此它可以创建一个
36:13
预先描述的 it 块集合，因此在本例中我创建了一个
36:19
我称之为计算器的测试集合，旨在测试计算器中的所有功能
36:25
程序
36:30
在我们开始定义 test it 块中的任何测试之前，我们必须设置
36:36
提供者 对于我们 对于我们的测试 在这种情况下，我们正在设置
36:41
之后我们需要引用我们在计算机上运行的本地集群的提供程序
36:47
程序本身创建了某种形式的抽象，允许我们调用灵魂程序中的方法
36:53
所以我通过创建一个常量程序然后引用我们的工作区名称（即计算器）来做到这一点
37:00
在这种情况下，在我们引用了我们的程序之后，我们需要开始生成一个
37:06
正如我之前所说，我们的计算器帐户的密钥更好，我们有存储问候语的计算器帐户
37:13
消息以及我们使用计算器进行的所有操作的其余结果
37:21
所以是的，我们显然需要生成密钥对，因为我们将在不同的呃中与同一个计算器帐户进行交互
37:29
在不同的测试场景或不同的测试中它会阻止
37:35
之后，我只是创建一个常量文本，我将在创建函数中使用它来将其存储在内部
37:42
计算器帐户所以在我们准备好所有这些之后
37:48
几乎设置为“定义我们所有的 it 测试块”，我正在创建的第一个测试块是
37:55
um 是一个测试块，将验证我们的创建函数，所以我将其称为创建计算器
38:01
实例，然后我们可以使用程序方法
38:07
在我们的程序中调用不同的方法，所以我们本质上是引用
38:12
我们之前在第 13 行执行过的程序。
38:18
所以现在你可以看到我正在调用方法 create 并且我正在提供预期的文本，因为呃我们期望
38:25
用户在函数参数中发送一些初始化消息
38:32
我们还需要提供所有想要融入创建函数上下文的帐户
38:39
所以我们添加我们的计算器，它使用计算器对或
38:46
我们之前生成的键盘我们还引用了用户
38:52
与测试交互的钱包的公钥以及
38:57
使用系统程序引用系统程序。程序 ID 是
39:02
直接在测试框架中恒定，之后我们还指定了所有
39:08
签名者 丰富的分配者，在本例中是计算器对，然后使用 RPC 方法发送
39:15
本质上，这将使用 RPC 调用 Solana 程序中的函数，在本例中使用 RPC
39:23
成功后 localhost 呃
39:29
我称此函数为“如果一切顺利的话，我们需要某种形式的验证”
39:34
所以我们通过再次取回我们的计算器帐户来做到这一点
39:40
我们使用之前生成的计算器对公钥来获取
39:46
特定帐户的内容在我们获得特定帐户的内容后，我们可以使用期望
39:53
在我们的例子中比较两个不同值的功能，我们正在比较内容
40:00
我们帐户的问候语（如果它等于我们的文本文本）
40:06
在使用我们的 RPC 到我们的程序之前发送出去，如果满足此条件则进行测试
40:14
它会阻止通过，但是如果这两个值不相等，则
40:22
整个测试块失败，所以在我们测试计算器之后
40:29
创建一个计算器实例，我们将进入另一个 it 块，这是一个不同的、不同的测试
40:37
所有这些测试都将按顺序执行，所以现在我们正在测试附加功能
40:43
所以我本质上做的是与之前的 IT 块相同的事情，但我不是调用创建函数
40:49
调用我们在程序中定义的 add 函数，在这种情况下我们不需要字符串
40:56
但我们期望不同的integer64数字
41:02
正如你所看到的，我使用锚 BM 传递了两个数字，所以我们有第二个和第三个
41:11
这本质上意味着如果我们用数字 2 和 3 调用这个函数，并且预期输出应该是 5
41:18
这应该存储在我们的计算器帐户中，我们还为我们的计算器提供帐户
41:24
添加功能的上下文，在我们的例子中只是一个
41:30
我们在上一步中生成的计算器帐户所以我再次传递计算器
41:36
将公钥配对作为我们将要写入的计算器帐户的结果
41:43
我再次使用 RPC 执行该函数，然后执行与之前相同的操作
41:50
取回帐户数据并检查是否是预期结果
41:57
在我们的例子中等于 5 或 6 如果你想通过测试应该是 5
42:02
现在，当我们对测试感到满意时，情况与之前相同，我们只是
42:08
尝试运行锚运行测试，它将运行在我们定义的所有测试块中
42:14
打字稿所以现在我们可以看到创建
42:19
计算器实例运行良好，加法结果相同，也运行良好
42:25
但例如，如果您想演示失败的测试如何工作
42:31
我们添加了两个数字 2 M3，假设我们期望输出为 6，这显然是错误的，
42:38
这将导致测试失败，所以如果我现在尝试执行测试
42:45
我们的第一个它块实际上创建了一个新的计算器实例，但是当我们尝试测试试镜时
42:52
它会开始失败，因为在我们的例子中，预期输出是 6，但程序可以正常工作
42:59
正确地将数字 5 存储在帐户数据中，我们可以在这里看到它
43:06
预期输出应该是 6，但实际输出是 5。所以这本质上就是我们如何能够非常
43:14
轻松定义不同的测试块来测试我们在 Solana 区块链上的程序实现是否正确
43:21
因此，当我们对所有测试感到满意后，我们将其切换回五个
43:28
我们再次运行测试，所有测试都通过了，然后我们
43:34
可以从我们的本地测试验证器切换到例如测试
43:40
当我们对确定网络或测试网络上的功能感到满意时，开发网络并在那里部署程序
43:46
进入制作并在磁铁上部署游戏
43:53
因此，如果您有兴趣进一步探索这些测试场景，我会
43:58
与所有计算器和测试共享我的 GitHub 存储库，您可以尝试添加自己的
44:06
计算器的功能，例如乘法和类似的东西
44:12
然后也为这些函数编写适当的测试，但本质上您只需执行以下操作
44:18
重复同样的事情，而不是仅仅执行加法，您将只是将两个不同的相乘
44:25
数字谈到 Solana 或 Solana 供应商学院的第三讲呃
44:31
我希望您了解如何在上实现基本计算器程序
44:36
slana 区块链，这就是我在上一讲中开始做计算器的原因，我想让你看看
44:43
Solana 外部的原始 Rust 实现与将相同程序移植到 Solana 之间的区别
44:50
区块链也不要忘记检查支票
44:56
完成本次讲座的任务我们将要求您在我们的计算器示例中实现更多功能
45:04
当您对您的程序感到满意后，您可以在我们的 GitHub 上获取它
45:09
不要忘记在本周日结束时提交
45:14
从下周开始，我们将做一些更复杂的程序，我们将实现我们自己的 Twitter
45:20
使用 Solana 克隆我们还将讨论一些 PDA 帐户，是的
45:27
这几乎与我们关于介绍的讲座有关
45:32
Solana 编程模型，希望下周见到大家，如果您对我们有任何反馈
45:38
讲座请不要忘记使用我们的 Google 表单提交，再次感谢您，下次再见
45:46
谢谢