# lesson4
Where: https://youtu.be/VRhJLGTmXoE?feature=shared

Wen: Today, October 11, 6PM UTC  (you can watch anytime after the premiere)

This lecture will introduce the basics of Program Derived Addresses (PDAs) accounts and implement a simple "bank program" with deposit and withdraw functions to demonstrate PDAs in Anchor programs.

Sample Repository: https://github.com/Ackee-Blockchain/wsos-bank


# 文字起こし
0:00
hello everyone welcome to another lecture of school of salana so in this lecture we'll be
0:08
talking about salana programming model again we'll do some form of recap of our
0:13
previous lecture and then we'll introduce the basics of pdas which are
0:19
program derived addresses please note that we'll only be talking about basics of pdas so pdas are
0:26
quite a complex topic so if you're interested in learning more there are many different sources where you can
0:33
find different details about about pdas and I do recommend you to reading that because this is a pretty important
0:40
Concept in on salana we're also talking we'll be also
0:45
talking about SPL tokens and tokens repository sorry program repository uh
0:52
we briefly introduced SPL tokens in our lecture number one but we'll be talking a little bit in detail about them
0:58
today so after after we have this uh part of the lecture done we'll move on to a Hands-On example where we Implement
1:06
uh where we'll be implementing uh simple uh salana program with
1:12
PDA so let's do a little bit of recap we talk about accounts there are
1:18
two different types of accounts on salana there are program accounts and data accounts for program accounts we're
1:26
talking about accounts that are storing a bite code of our program which mean these programs are executable by Solana
1:34
runtime all of these program accounts do not store any data all of the programs
1:40
on salana are stateless if we want to supply any
1:46
data uh to our program we need to use our data accounts these data accounts
1:51
are not executable and Only Store the data that we use as a input or we want
1:58
to modify them from our program
2:05
only the data accounts owner can modify its data and substract the land ports
2:11
that are currently in the account to prevent the account from being deleted
2:16
we must pay some sort of rent or we pay a certain amount of tokens to be uh set
2:23
as a rent extemp so keep in mind this is something that we talked about in the
2:28
previous lecture there is a big distinction between program and data
2:36
accounts another important part of our previous lectures were
2:41
transactions all of the basic operational unit on salana are instructions one or more instructions
2:48
can be bundled into a transaction and these instructions in one transactions
2:54
are then processed in order and automically this is something similar to any other data to any databases in the
3:01
world so essentially we can form different instructions into one transactions and if all of these
3:07
instructions were executed successfully then the transactions is complete if one
3:13
of these instructions failed that means that the transaction is
3:19
reverted when we are defying these transactions we must forward declare every account we intend to read from or
3:26
write to we also need to be aware of any potential security risks because obviously all of these transactions can
3:33
be constructed by any user of Solana so if you look at our instruction
3:39
format we have some program ID we have all of the accounts we need to supply
3:44
and then some form of 8bit data uh that we supply to the program if we look at
3:51
the accounts we can have we can specify different amount of accounts that we
3:56
need uh in terms of our transaction so if we need to have for example five different accounts
4:02
in this case we have spec we specifi we're specifying five or six different
4:08
accounts uh all of these accounts can be signed not signed writable or also read
4:15
only so now that we have described our Basics let's jump into a
4:21
pdas pdas can be quite hard to understand in the beginning so I will
4:27
only cover the basics and try to cover them in a way that it is easily understandable even to a complete
4:34
beginner so let's just talk about the motivation of creating pdas or the
4:40
motivation of whole concept of pdas on salana let's say we have two different
4:46
users uh on our blockchain we have user a and user B both of these users have
4:52
wallets already create have already created wallets and all of both of them
4:58
own private key to to these wallets so for example if you have F Phantom wallet
5:03
ready in your browser this this wallet in your browser holds your private key
5:09
that you can use to sign transactions on behalf of that particular wallet or that
5:14
particular account so let's just briefly look at it in detail all of the Wallets on salana
5:23
are owned by System Program if we want to do some form of
5:28
transactions from wallet we need to ask System Program to process this transaction or
5:35
process this transfer function and to do that we ask System Program and while
5:41
asking the system program we also Supply our private key that tells the system program that we are actually owner of
5:48
that particular account and we are able to do transactions and transfers on
5:54
behalf of that wallet so that means if if we have two uh distinct user
6:01
on our blockchain both of them holds the private key there is nothing wrong with this we can we are essentially good to
6:09
go but let's talk about a different scenario what if we have or what if we
6:15
want some form of program uh that will hold this program will hold their own
6:21
funds in their in the wallet that that this this program owns so let's say we
6:27
want to create some form of game where we will be sending out tokens to our game and the game will lock these
6:34
tokens or we have some form of program that will create a crowdfunding campaign
6:40
and we will ask different users to deposit ma money in our program to these
6:45
different uh crowdfunding campaigns how do we do that we
6:52
obviously need to have some form of way where program can have its addresses
6:58
where the program can store different amount of salana tokens and can do
7:04
transactions on behalf of that wallet that is owned by the program so let's say we have this form
7:11
of scenario we have a crowdfunding application and the user requests are
7:18
programmed to withdraw funds that are stored in the campaign that the user created that means our program will have
7:25
some form of withdrawal function and in this case user is calling this withdrawal function and the program is
7:32
transferring this money stored in that particular campaign back to the user
7:38
that means that the program needs to have some form of way how to tell System Program look I want to do this
7:45
transaction I want to withdraw all this money that I hold in my PDA and transfer
7:51
it to a user a that called this withdrawal function so how do we do that
7:57
if we take a look at thee that the examp example that we have previously which is this one we're always asking the system
8:04
program to do some form of transfer on our behalf and we need to tell system
8:10
program that this is actually Us by supplying the private
8:16
key this is obviously not possible for programs why uh PDS should pdas should
8:23
not have a private key so we need to have a different signing mechanism why
8:28
we don't want to have a private key stored directly in our program that means that everyone will be able to take
8:35
a look at the source code of our program would be able to know what's the private key for the wallet that we're inter for
8:41
the account that we're interacting in our program so we need to have a different signing
8:49
mechanism so that's where pdas comes in again PDA wallet is just an account
8:56
that is derived from our program address which is our program ID we actually
9:03
worked with programs ID in our previous in our previous lecture where we changed our program ID where when we deployed
9:10
the program so you can tell the so you can take this program ID and we add some
9:15
form of seed so let's say we will call this wallet for example Walt so uh the
9:22
address will be generated from our program ID and that additional seat that we're we're we are adding it to our
9:29
uh that we are adding to a PDA generation so we it can be essentially anything we can think of to generate
9:36
some form of random seat and signing instructions is then
9:41
executed by using invoke invoke sign function in our system program so that
9:48
means our program is calling invoke invoke sign function to a system program
9:55
and we Supply the seeds of the PDA account or the PDA wallet that we want
10:01
to substract so in our case we'll call invoke sign to a system program System
10:07
Program can verify from the actual PDA address if the program if the program
10:13
owns that particular PDA wallet and execute that transaction on
10:19
behalf of our program and we can obviously as I as I
10:25
said before we can do this invoke sign just by uh just by essentially uh specifying the
10:32
seeds that we have used to generate our pdas and without supplying the private
10:38
key for our PDA wallet because in every scenario the PDA does not or the PDA
10:45
address does not have a private key so let's just recap this a little
10:52
PDA programs wants to have an uh wants to be able to sign accounts for Crow
10:58
program invocation uh PDA is program derived address it is
11:04
an actual address of our PDA account on the other hand is a PDA account is an
11:10
account whose address is a PDA now how PDA gets
11:16
derived as I said before the PDA gets derived from our program ID and the
11:22
array of seats that we have specifying and then using sha 256 function we are
11:28
adding it to our program ID and we have a PDA as a
11:34
result now when we have our PDA we're also adding bump or salana is adding a
11:40
bump why are we adding a bump uh PDA needs to be bump of the ecliptic curve
11:47
because we need to be sure that our PDA have no private key so essentially when
11:53
we are for for the whole PDA generation we're just using program ID different
12:00
seats we have a PDA and then we are adding a bump to be sure that we have no
12:06
private key for our generated
12:13
address I hope this is clear to you just as a brief introduction to a
12:19
PDA we will dive a little bit deeper during our Hands-On example to know
12:24
exactly how we can use PDA in our anchor program
12:37
now let's talk a little bit about salana program Library so the advantage of the whole
12:43
concept of the program account where where we have just a program which that
12:49
is ex or for example that we have just an executable account that is storing
12:54
our program without any data we have some form of generic implementation that
13:00
we can use to different uh forms of input or different forms of input data
13:06
so that means that the whole concept of program account model means that we have
13:11
a one generic program that operates on various data and that this applies also
13:17
to Solana program Library if you take a look at Solana program
13:22
Library uh you can find different generic programs that are included in
13:27
salana so for example a governance program that will help you create Dows
13:34
without any form of imp implementation or for example stake pool where that we
13:40
can use to easily create different staking pools or in our case most
13:46
importantly a token program a token program is something that we have interacted in lesson one where we ask
13:54
token program to create different SPO tokens for us and we'll be talking a
13:59
little bit in detail about this in the next
14:04
slides so to briefly introduce salana tokens compared to for example ethereum
14:10
tokens on the ethereum side we have erc20 tokens and that is a token whose
14:16
smart contract uses erc20 standards uh all of the tokens on
14:23
ethereum if you want to use the standardized function are erc20 standard
14:29
uh if we want to create a token on ethereum we can use a Smart contract
14:34
template to create a new token that means that every token on ethereum is a
14:41
separate smart contract and to create a new token we need to deploy a erc20 smart contract on
14:50
chain that means that uh for example developers has a little bit more of
14:56
freedom in creating uh different tokens on ethereum but that also introduced a
15:03
lot of uh security issues on to on Solana we're uh
15:10
essentially labeling tokens as SPL tokens and it is a token created with the Solana token
15:20
program there is a no such a thing as a standard on salana there is a single
15:25
token program that is already pre-deployed for us and we already talk about it how we can interact with SPL
15:32
token via salana CLI but we can obviously interact with with that program with in any other way that we
15:40
want to so to briefly introduce this we have a our token program which is
15:46
predeployment
15:58
system program but we own private keys for this for this wallet so we can
16:03
essentially ask system programs to do transaction on our behalf and let's say we want to create a
16:10
new token on salana which we were doing in the lesson number one so first we ask
16:17
token program to create a mint account a mint account essentially is an account
16:23
that has metadata for the token that we are creating so we can see in the
16:29
account data that we have some form of minth authority that means this is a for
16:35
example the owner of this token that can be us and that person is able to create
16:42
uh can create new tokens or issue any tokens burn them for example
16:47
Etc we also specify the supply of our token which can be for example thousands
16:53
which is the max supply of our token and we also uh specify decimals
17:01
this means the decimals that we have after each token
17:07
issuance so for example let's just say that our wallet that we have created in
17:12
the previous step is a minth Authority for our mint account so the mint
17:17
Authority is our wallet right here which is the pup key of our wallet now our wallet can ask mint
17:27
account to create a token account so let's say we create a token account and
17:34
this token account is then owned by is then owned by token programs and has a
17:41
owner an owner is a wallet or different wallet that is owning this token account
17:47
and this token account is used to store different amount of our tokens so let's
17:53
say our wallet will ask the minid account look
17:59
let's create a token account this token account will be for me and I will and I
18:04
will want you to Mint uh some amount of tokens that will be stored in that token account for me so let's just say mint
18:13
account then calls mint on the token account and our wallet is a owner so now
18:20
we can see that our wallet is the owner of this token account and mint account
18:27
minted some form of amount of tokens into this token account that results in
18:34
that our wallet is now holding some amount of the tokens that we have created but is also a myth Authority for
18:42
this token and can issue or burn different
18:47
amounts of this token so now that we have introduced the
18:53
basics of PDA and also talk a little bit about SPL tokens let's let's jump into a
18:59
Hands-On example where we Implement a simple salana program in Anchor
19:04
framework and we'll be generating a PDA account for this program so we can store
19:10
some form of some form of tokens in that PDA wallet and then transfer it out to a
19:17
different user implementing our first salana program that will be using
19:24
pdas so the process uh to create a Solana and Anor uh program is pretty
19:29
much the same as last week so let's just start it with anchor in it and let's call
19:37
it salana
19:43
pdas this will initialize a new project for us and while the project is initializing let's talk about what we
19:49
are building today so essentially we'll be having a really simple demo of how pdas work and that
19:57
will be a simp simple program for Don naations so let's say we'll have three uh different function the first one will
20:04
be create this one will initialize a new a bank that the other users can call
20:14
deposit so essentially the one wallet creates a new bank other wallets can
20:20
deposit into it and then we will also have a
20:25
withdraw function that only add can call and by calling this withdrawal function
20:31
all of the money or all of the tokens deposit into our PDA accounts for that
20:37
particular bank will be withdraw to the admin or the owner of that
20:43
bank so this is pretty much just like a basis app for defi so we'll be creating
20:48
a PDA so if a user calls create it will create a new bank account this bank
20:55
account will be a PDA and will be able to hold some form of
21:02
balance if the admin or any other user wants to deposit into this Bank he will
21:07
call or he or she will call the deposit function and deposit some form of amount
21:13
of the tokens that will be going or will be transferred into our PDA that we have
21:21
created and we're also adding a withdraw function this function will still be
21:26
publicly accessible but we will have to implement some form of ownership checking inside of it to make sure that
21:34
only the owner of the bank that we are withdrawing from will be able to
21:39
withdraw the actual funds if any other user or any other wallet will try to
21:45
withdraw funds from our PDA it will
21:53
fail so let's jump into our project
22:00
let's just go ahead into a programs that anchor created for us and let's remove
22:05
the initialize function and the account structure that or the Border plate code
22:11
that anchor generated for us and let's just go ahead and start with our create function this create function
22:17
will essentially create a new PDA account for our bank so let's just the
22:24
process pretty much same as last week so let's just call it create create we obviously need some context this
22:31
context will be called create and let's just say we need some
22:38
name for our bank so this name will be string and then we also
22:44
need some return value in our case will be program
22:53
result and now uh essentially the same same uh same situation as last week
23:01
let's just fetch our
23:07
bank sorry uh this bank will be mutable and it will be part of our
23:21
context so this bank account will be a PDA and now during the initialization or
23:28
the creation of the bank let's just set up a name for our bank which we have in
23:34
the function parameters and we also uh since we will
23:41
be holding some funds in our bank let's just also keep track of it uh in one of
23:46
the fields inside our bank so let's just say we have Bank uh
23:54
balance and we'll be setting up that to zero right right now because we're just initializing the bank
24:01
account and as I mentioned before we need to keep track who's the owner of
24:06
this bank so let's just say the bank will have some form of
24:11
owner and to get the owner that we want
24:17
let's just use the signer A P signer's public key so essentially the one who's
24:22
calling the create function will also became the owner of the initialized bank
24:32
account and we could do it again by accessing our context in our context
24:37
accounts we will also we will we will have a user which will be the signer that is calling this function and we'll
24:44
use his key as the owner and now when we're done with that we also need to return that the
24:51
execution was successful to Salon run time and we are doing that by calling
24:57
okay when we're happy with this let's just go ahead and create our context for the
25:04
create function the progress is yet again same
25:10
as last week so we're using diive accounts macro to tell that our structure is derived from the
25:20
account and let's call it
25:26
create
25:35
and now we have our structure and let's just specify the fields of our structure
25:40
so in our case it will be the bank which is the most important thing it will also
25:46
be our PDA in this case so bank is just an
25:53
account of type bank that we will specify later
26:01
and we also need the user which is the signer that is calling our initial or
26:06
our creation function so
26:13
signer and we also need to reference the system
26:26
program so now we have our structure ready but we need to Define some form of macro so
26:33
we need to tell that the bank uh will be that the bank will be uh the PDA so we
26:40
can do it by adding a macro just like we did last week we
26:45
need to uh initialize our account we need to specify the payer that means who
26:52
will be paying for the account initialization so we can do user so that
26:58
will tell that the person that is calling the create function will also be paying for the creation of our bank
27:05
account let's just also specify the space uh that our account will
27:12
allocate let's just do 5,000 we'll be talking a little bit in depth in next
27:17
lectures how to properly calculate space for our accounts but it's pretty easy and now since we're talking about
27:24
PDA we need to specify the seats I have uh told you before in our presentation
27:31
in this lecture that that the pdas are generated from the program ID and some
27:37
seats on top so we can do it by specifying seats and
27:44
the seeds will be a array of different seats that will be used to generate the pda's
27:51
address and let's just add a string uh this one will be called
27:58
Bank bank account but this is obviously not enough
28:03
because this will create a PDA that with a seat of our program ID and a seat bank
28:09
account on top but if you want to create different bank accounts uh using our program we'll be running into some
28:16
issues so let's just add more seeds into our generation so we are so we're
28:23
essentially be making sure that we are generating uh unique pdas for each bank
28:30
account creation and let's just use for example the public key of the signer so
28:37
it's the user key and as
28:46
ref so now we have specified the array uh for the seats uh the first one
28:52
is a string bank account and the other one is the public key of the owner of
28:58
this bank account let's just also add the bump flag the bump flag uh as I told
29:04
you in the lecture uh will make sure that there is no private key for this
29:10
PDA it will essentially bump uh the address of this account off the ecliptic
29:16
curve so we'll be making sure that we have no private key accessible for this PDA and only the actual program can
29:23
access it and now that's pretty much everything
29:29
for our macro we're good to go and this will create our PDA so as you can see that it
29:35
is pretty much the same thing as initializing an account in the previous
29:40
in the previous lecture where we initialize our uh where we initialize
29:46
our uh calculator account but here we're spec specifying seats on top which we
29:52
are explicitly telling anchor that we will be creating an account with the public uh public uh key generated off of
30:01
this seat and the program ID and we're also adding a bump on top to make sure there is no private key for our bank
30:09
account but we are still not done yet with our create context we also need to tell that uh that our users
30:21
account is mutable and this is pretty much the same thing that we did last week
30:30
so yeah we're essentially Set uh with our uh with our create context we just
30:37
need to Define how the bank will look or how the bank account will look and
30:42
that's pretty easy we've already accessed the bank here so we already know that we need some form of name we
30:48
need some form of balance and we need to specify the owner of this bank so we'll probably have just three of these
30:56
fields so let's just do it right now uh let's just specify that this will be an
31:10
account and let's just go ahead and add p uh name which will be the
31:17
string uh we need to add PB uh
31:23
balance that will be unsign integer 64bit integer and we need the
31:30
owner that we have specified here and let's just say it's owner and make sure that the type of the
31:38
owner will be uh the pup key because we are essentially supplying a puup key uh
31:44
to our owner uh to our owner field in our back in our bank account so now we're pretty much Set uh
31:52
we're pretty much set with our create function let's just save it up
31:58
and try to compile our program for the first time if everything's checks out also make sure that if you're using
32:04
program result uh specify that we'll be using a
32:10
program uh result on top of your uh lip.
32:19
RS so now when we have created our create function and we have tested that
32:24
everything compiles just fine let's go ahead and Implement our uh
32:32
Implement our deposit
32:38
function so again we're calling it deposit specifying a context for a deposit
32:52
function and let's just say we are also adding a parameter that we will call A amount which will be the amount in lamp
32:59
ports that the user will be donating in our in our
33:15
bank so if you think about it the all that this function needs to do is essentially initialize a transfer from
33:23
the users account to our PDA account account so let's just call
33:30
it transaction and now we can use anchor
33:37
lank salana program system
33:49
instruction and now we can call a system instruction which in this case is
33:55
transfer the the transfer function requires us to specify two parameters or sorry three parameters which is the uh
34:03
input account the account that we we transferring to and the amount that we're
34:08
transferring so let's just start up with uh the users account which in our case
34:15
will be context accounts user and yet again we'll be
34:23
using the user's key which is the user's public key
34:28
and for Destination we'll be using context
34:33
accounts and this time we'll not be using the users key but our banks key
34:40
which is our uh PDA so let's just type bank and key the last parameter that we
34:47
need to supply is the amount that we're transferring to and we'll just use the amount that is supplied in our functions
34:54
parameters so that's amount
35:10
so let's just say we our our transactions is uh essentially defined using anchor length salana program we're
35:17
calling system instruction that is called transfer and now just invoke the actual
35:24
transaction so let's just type anchor link salana
35:31
program program invoke and what we need to he what we
35:38
need to do here is to actually specify the transaction that we have created in
35:44
the previous step which is txm and just like we're used to we also
35:51
need to supply the account that we will be using for this transaction
35:57
so in our case it will be again context
36:03
accounts user and we'll be using function
36:09
to account
36:16
info this way we have specified that we'll be using the users account but we also will be using the actual bank uh
36:24
bank account which is rpda so let's just do do that too so the process is the
36:30
same but instead of user we'll be using the bank account and again we'll use to
36:36
bank uh two account
36:51
info and now we pretty much initialize the transaction and uh as I've mentioned
36:57
before we're also keeping track of the balance inside inside our bank account
37:03
so uh when all the transactions went through we also need to update the balance uh parameter inside our bank
37:10
account so let's just do it real let's just do it real quick here so uh let's just
37:18
do uh beable context again we're using our
37:25
bank account and
37:31
now let's just rewrite our balance attribute so let's just say
37:38
balance and let's use uh plus
37:46
equal plus equal amount this will essentially uh add the
37:54
amount that the user's donating to to an actual balance of our bank account so
38:00
we're pretty much set with this one so let's just call okay and briefly glaz through what we
38:07
have implemented here so we are constructing a function uh we're using system we we constructing a transaction
38:14
or transfer using a system instruction transfer from some sort of uh from some
38:21
sort of source account to some sort of destination account we're also specifying the amount
38:27
now when we have uh uh now when we have constructed our transaction we need to
38:32
invoke it we're doing that using Solana program program invoke we're specifying
38:38
the transaction and we also just like we're used to do uh need to specify all
38:43
of the accounts we'll be using for this transaction which in this case is the user account and the bank account
38:49
because those are the only accounts that we are reading or writing from or to after that after our transactions
38:57
complete we also need to update the balance uh inside our bank account which we're doing here uh we are using uh
39:06
mutable for our balance attribute and we're adding the amount that the user has donated uh using this function after
39:13
all this complete we're just letting Salon run time know that uh the whole deposit function went through uh
39:23
well let's just rename our context and just go right ahead and add our context right
39:35
here so again let's just add our derive accounts
39:43
macro and create our uh deposit
39:55
context
40:10
so in our case it will be pretty straightforward for uh for the deposit function we essentially uh need to
40:16
supply our bank account and we also need to again Supply the user and the system
40:25
program so let's start with specifying again we're using uh a mutable
40:33
macro and the first thing we'll be specifying is the actual bank account uh
40:38
the bank
40:49
account bank account is type of the bank that we have created
40:54
before and when we're all set with our bank let's just also use the same
41:01
structure that we have used before and that's essentially the user that will be the signer and also referencing the
41:06
system program so we can add it right here and we're pretty much set with our deposit context so again we're specify
41:15
the only thing that we are using in our deposit is our bank account and is the
41:20
actual signer or the user so we're supplying it here both of these uh both
41:26
both of these uh accounts needs to be mutable because we'll be changing
41:33
them and we are pretty much good to go with our deposit function let's just
41:39
let's just test it out real quick sorry made a typo here I'll be
41:45
aware that is not account it's accounts and let's just try to compile
41:52
our program again if everything uh works
42:01
out okay seems like we're good and let's just go right ahead and add our last
42:07
function which will be the withdrawal function the withdrawal function will be a little bit more complicated because we
42:13
need to ensure that we have some checks in place that only admin that actually created the bank account will be able to
42:20
withdraw the funds from our bank account so let's finish up our program
42:28
by adding our last function which will be the opposite of deposit and that's the withdraw function
42:35
the withdraw function uh should essentially take an amount of money that we want to transfer back to admin of
42:43
that particular Bank from the PDA that is storing the
42:49
deposits [Music] so let's do function withraw
42:58
and the process pretty much the same as
43:04
before context
43:09
withdraw and we also need to specify the amount that we want to withdraw uh this
43:14
is pretty much optional we can also create the withdraw function to withdraw all of the funds from the PDA we do have
43:22
both of these options for a reason because we're also storing the
43:27
amount uh the amount that is stored inside the bank account in our balance
43:33
parameter so uh but for this purpose let's add amount which will be an unsign
43:40
64bit integer be lamp P that we want to withdraw from our PDA and again the return Valu is program
43:53
result and now let's think about what we want want to do uh the process pretty much similar uh with the deposit but
44:01
except the uh the transfer the opposite way but we also need to add some checks first
44:09
so uh before we do so we need to access our uh bank account so we'll be
44:16
obviously using our bank account from our context again and we also need to
44:21
use uh our we also need to fetch the uh user account which is the signer that is
44:28
calling the withdrawal function so let's just say user and again it will be the process
44:35
pretty much the same so let's just say mutable
44:41
context accounts uh user which is the signer of
44:46
the transaction that is calling the withdrawal function you can go ahead and
44:52
specify our withdraw function or withdraw context here so it will be
44:58
pretty much the same thing as with deposits let's just call withdraw and we'll
45:04
also yeah pretty much the uh pretty much the the the the
45:10
context Remains the Same for for for our withdrawal function just like as the just like the deposit U you can
45:18
also yeah we can just essentially keep the bank and user account because this is what we'll be using in our in our
45:25
function so let's just say yeah we're accessing Bank we're accessing the user
45:31
and now it's time to do some proper checking so for checking in salana we can just do
45:38
uh for example if statements in Anchor so let's just say our first check would
45:43
be if the caller of this function if the signer is actually the admin of the bank
45:50
that uh we want to withdraw so the check is pretty much straightforward so let's just say we're
45:57
comparing our bank owner and let's just say if the bank's
46:02
owner is not equal uh to the users key which is the user uh pup key we need to throw some
46:11
error and stop the execution of our function we can do that by calling
46:21
return error and specifying the uh error code which let's just
46:30
say will be program
46:36
error incorrect program
46:41
ID you can obviously specify these errors as much as you want you can customize them but uh this will do for
46:48
our example so this is the first ownership check that we are implementing here using a simple if
46:54
statement there is also another thing that we need to check since we are letting the user specifying the amount
47:01
that he wants to withdraw uh if we want to uh let's just
47:06
say uh we need to check if the amount that he's trying to withdraw is actually present in our PDA
47:17
account so let's say another if
47:22
statement and say r Bank to account
47:28
[Music]
47:41
info and we can call Lamp ports borrow which will essentially uh tells us the
47:46
lamp ports that are currently stored in our uh PDA account or in our bank account and we need to check if that
47:54
number is uh if that amount is less than the amount
47:59
that the user is trying to withdraw in this case we need to throw another
48:07
error uh so yeah it's pretty much the same thing as before let's just throw another error but it will be a different
48:14
error let's call it insufficient
48:21
funds so yeah we have insufficient funds
48:26
so right now what we have achieved is the fact that uh only the owner of our
48:34
bank will be able to uh will be able to withdraw or call this function uh if it
48:42
this called by someone who is not the owner of the specified Bank it will throw out an error and also we need to
48:49
make sure if if uh if it's a right owner and he's trying to withdraw a more
48:54
amount that is stored in our PDA it will throw another error so that will stop the execution of our
49:02
function uh you may also point out that we're storing the balance as one of the
49:08
as one of the fields inside our bank account uh we can uh use it to check if
49:14
the amount uh we are withdrawing is lower than the amount stored but I'm also using the lamp ports borrow here to
49:21
demonstrate that you can use this function to get the amount of the Lamport that are currently stored in the
49:27
specified account and now when we're done with the checks the only thing that we need to do
49:34
is initialize the trans uh initialize the transaction or the transfer between the PDA and the admins wallet what we'll
49:43
do here is essentially substracting the um substracting the
49:48
lamp Port from our uh PDA bank and we'll be adding these lamp ports back
49:56
uh to the users account or the admin's account and we can do it pretty easily
50:03
uh we can again uh take our bank to account info and just like we uh access our lamp
50:12
ports here we can call try borrow mutable
50:24
lorts
50:33
sorry and just substract the amount that we want to uh that we want to withdraw
50:39
and now we are substracting uh the L ports uh from our bank account and we
50:44
need to do the same thing just the opposite way to our user that is calling
50:51
the withdrawal function so we're calling user to account info try borrow mutable
50:57
lamp ports but we're not substracting we're adding the lamp ports back to our
51:04
user these functions obviously only work when there is uh we because we're trying
51:10
to borrow the lamp ports so we're make we need to be sure that there are enough lamp ports in our bank account be be
51:17
before we're actually borrowing them and we are making sure by creating this if
51:22
statement be before it where we are actually making sure that the amount that the user is trying to withdraw is
51:28
present in our PDA and after that we're pretty much done with the execution and we can tell
51:34
salana run time that the execution went
51:42
successfully so let's just a I have a typo here let's just check if we are good to
51:51
go okay so it seems like uh seems like our programs pretty much fine and
51:58
compile compiles fine so let's just yeah and also let's just point out and we
52:05
have also mentioned it in the previous lecture that all of the accounts need to
52:10
store some form of rent uh to not get pretty much erased or deleted from from
52:16
salana blockchain let's make sure that uh we will keep enough rent in our PDA so it
52:23
not gets destroyed so we can do that by calculating the rent that is necessary
52:28
to keep our account from lent rent extension so let's just say uh let uh
52:37
rent and we can call Rent
52:46
get minimum
52:52
balance and now we need to supply uh the length of the account where we want to
52:59
calculate uh the minimum balance for the rent so in our case we'll be supplying
53:04
our bank account data's length so let's just say
53:09
bank again we'll be using uh two account
53:16
info and call data
53:23
Len and by calling this is we will get the minimum amount of
53:29
rent that we need to uh keep stored in our PDA accounts for it not to get
53:34
destroyed because we're essentially enabling the uh the admin of our bank account to withdraw any specific amount
53:43
of uh funds from the from the bank account we need to make sure that even
53:49
after the admin withdraws the money from the bank account the bank account still needs to keep uh enough lamp ports to
53:57
pay for his rent and let's just add it to our lorts
54:05
borrow add rent to it and now we are pretty much sure if we do this just try
54:12
if it works out yeah and now we're sure that we can
54:17
only withdraw the amount of money so there is enough rent kept in our PDA to
54:24
not get it destroyed but this is obviously up to your
54:29
implementation because if we for example want to make a withdraw function where
54:34
the withdraw automatically withdraws all of the funds that are stored in the PDA
54:40
we can then uh pretty much uh get all of the funds from rpda and close these
54:45
accounts if we don't want to use them anymore but in this case the admin can withdraw any funds he want and still
54:53
keep his bank running so so essentially he can withdraw just two Soul keep two soul in his bank and other users can
55:00
still deposit money into his bank so this is a little bit more
55:09
flexible yeah so now we're pretty much uh done with all of the three function that we needed uh we have withdraw
55:16
deposit and uh creation of the bank so we have pretty much a standard app that
55:22
represents the defi uh on of or pretty much the the simplest example of a
55:29
defile on salana thank you for attending today's lecture and now I will hand it over to
55:35
my colleague uh to give you details about our next assignment hello everyone
55:41
today you have learned about pdas which is an essential concept used on Solana
55:47
and with the knowledge that you have learned until now you can already create a lot of useful
55:54
programs for the next uh task assignment you will be programming Twitter
55:59
functionality where users can uh create new tweets and others can add reactions
56:05
to the tweets and as usual we will share the GitHub classroom link on
56:12
Discord in the next lecture I will give you some development best practices tips
56:18
and I will also show you a few Hands-On examples how you can debug and uh test
56:25
your programs so uh thank you for today and see you next time


## 
0:00
大家好，欢迎来到萨拉纳学校的另一场讲座，所以在这次讲座中我们将
0:08
再次谈论 salana 编程模型，我们将以某种形式回顾一下我们的
0:13
上一讲，然后我们将介绍 PDA 的基础知识，它们是
0:19
程序派生地址请注意，我们只会讨论 PDA 的基础知识，因此 PDA 是
0:26
这是一个相当复杂的主题，因此如果您有兴趣了解更多信息，可以使用许多不同的来源
0:33
查找有关 pda 的不同详细信息，我建议您阅读该内容，因为这是非常重要的
0:40
我们也在谈论萨拉纳的概念，我们也会
0:45
谈论 SPL 令牌和令牌存储库抱歉程序存储库呃
0:52
我们在第一讲中简要介绍了 SPL 代币，但我们将详细讨论它们
0:58
今天，在我们完成讲座的这一部分之后，我们将继续进行实践示例，我们将在其中实现
1:06
呃，我们将在那里实施呃简单的呃萨拉纳计划
1:12
PDA 所以让我们回顾一下我们谈论的帐户有
1:18
salana 上有两种不同类型的帐户，即程序帐户和数据帐户。
1:26
谈论存储我们程序的咬代码的帐户，这意味着这些程序可由 Solana 执行
1:34
运行时所有这些程序帐户不存储所有程序的任何数据
1:40
如果我们想提供任何东西，萨拉纳上都是无国籍的
1:46
数据呃我们的程序我们需要使用我们的数据帐户这些数据帐户
1:51
不可执行，仅存储我们用作输入或我们想要的数据
1:58
从我们的程序中修改它们
2:05
只有数据帐户所有者才能修改其数据并减去陆路口岸
2:11
当前在帐户中，以防止帐户被删除
2:16
我们必须支付某种租金或者我们支付一定数量的代币才能设置
2:23
作为临时租金，所以请记住这是我们在
2:28
上一讲程序和数据之间有很大的区别
2:36
我们之前讲座的另一个重要部分是
2:41
salana 上所有基本操作单元的交易都是指令 一个或多个指令
2:48
可以捆绑到一笔交易中，并且这些指令在一个交易中
2:54
然后按顺序自动处理，这与数据库中任何其他数据类似。
3:01
所以本质上我们可以将不同的指令形成一个交易，如果所有这些
3:07
指令成功执行，则交易完成，如果
3:13
这些指令失败，这意味着该交易
3:19
当我们拒绝这些交易时，我们必须转发声明我们打算读取的每个帐户或
3:26
写信给我们，我们还需要意识到任何潜在的安全风险，因为显然所有这些交易都可以
3:33
由 Solana 的任何用户构建，因此如果您查看我们的说明
3:39
格式 我们有一些程序 ID 我们有我们需要提供的所有帐户
3:44
然后我们向程序提供某种形式的 8 位数据，如果我们看一下
3:51
我们可以拥有的帐户我们可以指定我们可以拥有的不同数量的帐户
3:56
就我们的交易而言，如果我们需要拥有五个不同的账户
4:02
在这种情况下，我们有规范，我们指定我们指定五到六种不同的
4:08
帐户呃所有这些帐户都可以签名但不能签名可写或也可读取
4:15
现在我们已经描述了我们的基础知识，让我们开始吧
4:21
pdas 一开始可能很难理解，所以我会
4:27
只涵盖基础知识，并尝试以即使是完整的人也容易理解的方式来涵盖它们
4:34
初学者，所以让我们谈谈创建 pda 的动机或
4:40
salana 上的掌上电脑整个概念的动机 假设我们有两种不同的
4:46
用户呃在我们的区块链上我们有用户 a 和用户 B 这两个用户都有
4:52
已经创建的钱包 已经创建了钱包，并且全部都创建了
4:58
这些钱包拥有自己的私钥，例如，如果您有 F Phantom 钱包
5:03
在您的浏览器中准备好，您浏览器中的这个钱包保存着您的私钥
5:09
您可以用它来代表该特定钱包或该钱包签署交易
5:14
特定帐户，所以让我们简单地详细了解 salana 上的所有钱包
5:23
如果我们想做某种形式的操作，则由系统程序拥有
5:28
来自钱包的交易我们需要要求系统程序处理此交易或
5:35
处理这个传递函数，为此我们询问系统程序，同时
5:41
询问系统程序，我们还提供我们的私钥，告诉系统程序我们实际上是
5:48
该特定帐户，我们可以在该帐户上进行交易和转账
5:54
代表该钱包，这意味着如果我们有两个不同的用户
6:01
在我们的区块链上，他们都持有私钥，这没有任何问题，我们可以，我们基本上可以
6:09
走吧，让我们讨论一个不同的场景，如果我们有的话，或者如果我们有的话会怎么样？
6:15
想要某种形式的程序，呃，它将举行这个程序将举行他们自己的
6:21
该程序拥有的钱包中的资金，所以假设我们
6:27
想要创建某种形式的游戏，我们将向我们的游戏发送代币，并且游戏将锁定这些代币
6:34
代币或者我们有某种形式的程序来创建众筹活动
6:40
我们会要求不同的用户在我们的程序中存入钱给这些
6:45
不同的众筹活动我们如何做到这一点
6:52
显然需要有某种形式的方式让程序可以拥有它的地址
6:58
该程序可以存储不同数量的 salana 代币并且可以执行以下操作
7:04
代表该程序拥有的钱包的交易，所以假设我们有这种形式
7:11
我们有一个众筹应用程序，用户请求是
7:18
编程为提取存储在用户创建的活动中的资金，这意味着我们的程序将
7:25
某种形式的提款函数，在这种情况下，用户调用该提款函数，程序是
7:32
将存储在该特定活动中的资金转回给用户
7:38
这意味着程序需要有某种形式的方式来告诉系统程序我想这样做
7:45
交易 我想提取我在 PDA 中持有的所有资金并进行转账
7:51
它发送给调用此提现函数的用户 a 那么我们该怎么做
7:57
如果我们看一下我们之前的示例，就是这个，我们总是询问系统
8:04
程序代表我们进行某种形式的传输，我们需要告诉系统
8:10
通过提供私人程序，这实际上是我们
8:16
关键这对于程序来说显然是不可能的为什么呃 PDS 应该 pdas 应该
8:23
没有私钥，所以我们需要有不同的签名机制，为什么
8:28
我们不想将私钥直接存储在我们的程序中，这意味着每个人都可以获取
8:35
查看我们程序的源代码就可以知道我们要访问的钱包的私钥是什么
8:41
我们在程序中交互的帐户，因此我们需要不同的签名
8:49
机制，这就是 pda 再次发挥作用的地方 PDA 钱包只是一个帐户
8:56
这是从我们的程序地址派生出来的，它实际上是我们的程序 ID
9:03
在我们之前的讲座中，我们在部署时更改了程序 ID
9:10
程序，以便您可以告诉您，以便您可以获取该程序 ID，我们添加一些
9:15
种子的形式，所以我们称这个钱包为 Walt，所以呃
9:22
地址将从我们的计划 ID 生成，并且我们正在将其添加到我们的附加席位
9:29
嗯，我们正在添加 PDA 生成，因此我们基本上可以生成任何我们能想到的东西
9:36
然后是某种形式的随机座位和签署说明
9:41
通过在我们的系统程序中使用invoke调用标志函数来执行，以便
9:48
表示我们的程序正在调用系统程序的invoke调用标志函数
9:55
我们提供我们想要的 PDA 帐户或 PDA 钱包的种子
10:01
减去，因此在我们的例子中，我们将调用系统程序 System 的调用符号
10:07
程序可以从实际的 PDA 地址验证程序是否
10:13
拥有该特定 PDA 钱包并执行该交易
10:19
代表我们的计划，我们显然可以像我一样
10:25
在我们可以通过 uh 执行此调用符号之前说过，只需通过本质上 uh 指定
10:32
我们用来生成我们的 PDA 且不提供私人的种子
10:38
我们的 PDA 钱包的密钥，因为在每种情况下 PDA 都没有或 PDA
10:45
地址没有私钥，所以让我们回顾一下这一点
10:52
PDA 程序希望拥有一个呃希望能够为 Crow 签署帐户
10:58
程序调用 uh PDA 是程序派生地址
11:04
另一方面，我们的 PDA 帐户的实际地址是 PDA 帐户是
11:10
地址是 PDA 的帐户现在 PDA 如何获取
11:16
正如我之前所说，PDA 是从我们的程序 ID 和
11:22
我们指定的座位数组，然后使用 sha 256 函数
11:28
将其添加到我们的程序 ID 中，我们就有一个 PDA 作为
11:34
结果现在当我们有了 PDA 时，我们还添加了凹凸或萨拉纳添加了
11:40
凹凸 为什么我们要添加凹凸 呃 PDA 需要是黄道曲线的凹凸
11:47
因为我们需要确保我们的 PDA 没有私钥，所以本质上当
11:53
对于整个 PDA 一代，我们只是使用不同的程序 ID
12:00
座位上我们有一个 PDA，然后我们添加一个凸块以确保我们没有
12:06
ou 的私钥r 生成
12:13
我希望这对您来说是清楚的，就像对
12:19
我们将在实践示例中更深入地了解 PDA
12:24
我们如何在我们的主播节目中使用 PDA
12:37
现在让我们来谈谈salana程序库的整体优势
12:43
程序帐户的概念，其中我们只有一个程序
12:49
是 ex 或者例如我们只有一个可执行帐户正在存储
12:54
我们的程序没有任何数据，我们有某种形式的通用实现
13:00
我们可以使用不同的呃形式的输入或不同形式的输入数据
13:06
所以这意味着程序帐户模型的整个概念意味着我们有
13:11
一种对各种数据进行操作的通用程序，这也适用
13:17
如果您查看 Solana 程序，请访问 Solana 程序库
13:22
图书馆呃你可以找到不同的通用程序包含在
13:27
salana 是一个治理计划，可以帮助您创建 Dows
13:34
没有任何形式的 imp 实施，或者例如我们需要的权益池
13:40
可以用来轻松创建不同的质押池，或者在我们的例子中大多数
13:46
重要的是，代币计划 代币计划是我们在第一课中互动的东西，我们问
13:54
代币程序为我们创建不同的 SPO 代币，我们将讨论
13:59
接下来会详细介绍这一点
14:04
幻灯片简要介绍了 salana 代币与以太坊等的比较
14:10
在以太坊方面，我们有 erc20 代币，该代币的
14:16
智能合约使用erc20标准呃所有代币
14:23
ethereum如果要使用标准化功能都是erc20标准
14:29
呃，如果我们想在以太坊上创建代币，我们可以使用智能合约
14:34
创建新代币的模板，这意味着以太坊上的每个代币都是
14:41
单独的智能合约并创建一个新的代币，我们需要在其上部署一个erc20智能合约
14:50
链这意味着呃，例如开发人员有更多的
14:56
在以太坊上创建呃不同的代币的自由，但这也引入了
15:03
Solana 上存在很多呃安全问题，我们呃
15:10
本质上将代币标记为 SPL 代币，它是使用 Solana 代币创建的代币
15:20
程序上没有这样的东西作为萨拉纳的标准只有一个
15:25
已经为我们预先部署的令牌程序，我们已经讨论过如何与 SPL 交互
15:32
通过 salana CLI 获取令牌，但我们显然可以通过任何其他方式与该程序进行交互
15:40
想简单介绍一下，我们有一个代币计划，它是
15:46
预部署
15:58
系统程序，但我们拥有该钱包的私钥，因此我们可以
16:03
本质上是要求系统程序代表我们进行交易，假设我们想创建一个
16:10
萨拉纳上的新标记是我们在第一课中所做的，所以首先我们要问
16:17
用于创建铸币账户的代币程序 铸币账户本质上是一个账户
16:23
其中包含我们正在创建的令牌的元数据，因此我们可以在
16:29
帐户数据，我们拥有某种形式的敏敏权限，这意味着这是一个
16:35
例如，该令牌的所有者可以是我们并且该人能够创建
16:42
例如，呃可以创建新的代币或发行任何代币并烧毁它们
16:47
等等，我们还指定了代币的供应量，例如数千
16:53
这是我们代币的最大供应量，我们还指定了小数
17:01
这意味着每个标记后面的小数
17:07
例如，我们创建的钱包
17:12
上一步是我们的铸币账户的铸币权限，所以铸币
17:17
权威是我们的钱包，这是我们钱包的小狗钥匙，现在我们的钱包可以询问薄荷
17:27
account 创建一个令牌帐户所以假设我们创建一个令牌帐户并且
17:34
该令牌帐户随后由令牌程序拥有，并且具有
17:41
所有者 所有者是拥有此代币帐户的钱包或其他钱包
17:47
这个代币账户用于存储不同数量的代币，所以让我们
17:53
说我们的钱包会询问迷你账户看看
17:59
让我们创建一个代币帐户 这个代币帐户将属于我，我会并且我
18:04
会希望你铸造一些代币，这些代币将存储在我的代币帐户中，所以我们就说铸造吧
18:13
然后 account 调用 token 帐户上的 mint，我们的钱包是所有者，所以现在
18:20
我们可以看到我们的钱包是这个代币账户和铸币账户的所有者
18:27
将某种形式的代币数量铸造到该代币账户中，从而导致
18:34
我们的钱包现在持有一定数量的我们创建的代币，但也是一个神话
18:42
该代币可以发行或燃烧不同的代币
18:47
这个代币的数量现在我们已经引入了
18:53
PDA 的基础知识以及一些关于 SPL 令牌的知识让我们开始吧
18:59
我们在 Anchor 中实现一个简单的 salana 程序的实践示例
19:04
框架，我们将为该程序生成一个 PDA 帐户，以便我们可以存储
19:10
PDA 钱包中某种形式的某种形式的代币，然后将其转移到
19:17
不同的用户实施我们的第一个 salana 程序，该程序将使用
19:24
pdas 所以创建 Solana 和 Anor 程序的过程非常漂亮
19:29
与上周大致相同，所以让我们以锚点开始，然后调用
19:37
伊特萨拉纳
19:43
pdas 这将为我们初始化一个新项目，在项目初始化时让我们谈谈我们要做什么
19:49
今天正在构建，所以本质上我们将有一个非常简单的演示，展示 pda 的工作原理
19:57
对于唐国家来说，这将是一个简单的程序，所以假设我们将有三个呃不同的功能，第一个将
20:04
创建这个将初始化一个新的银行，其他用户可以调用
20:14
存款所以本质上一个钱包创建一个新的银行其他钱包可以
20:20
存入其中，然后我们也会有一个
20:25
只有add可以调用的withdraw函数，通过调用这个withdraw函数
20:31
为此，将所有资金或所有代币存入我们的 PDA 账户
20:37
特定银行将提款给该银行的管理员或所有者
20:43
银行，所以这几乎就像 defi 的基础应用程序一样，所以我们将创建
20:48
一个 PDA，因此如果用户调用 create 它将在该银行创建一个新的银行帐户
20:55
帐户将是一个 PDA，并且能够保存某种形式的
21:02
余额如果管理员或任何其他用户想要存入该银行，他将
21:07
调用或者他或她将调用存款功能并存入某种形式的金额
21:13
将要转移或将转移到我们拥有的 PDA 中的代币
21:21
创建了，我们还添加了一个提款函数，该函数仍然是
21:26
公开可访问，但我们必须在其中实施某种形式的所有权检查，以确保
21:34
只有我们提款的银行的所有者才能
21:39
如果任何其他用户或任何其他钱包尝试提取实际资金
21:45
从我们的 PDA 中提取资金
21:53
失败了，所以让我们开始我们的项目
22:00
让我们继续进入为我们创建的锚点程序，然后删除
22:05
初始化函数和帐户结构或边框板代码
22:11
为我们生成的锚点，让我们继续从我们的创建函数开始
22:17
本质上会为我们的银行创建一个新的 PDA 帐户，所以让我们
22:24
过程与上周几乎相同所以我们就称之为创建创建我们显然需要一些上下文
22:31
context 将被称为 create ，假设我们需要一些
22:38
我们银行的名称，所以这个名称将是字符串，然后我们也
22:44
在我们的例子中需要一些返回值将是程序
22:53
结果现在呃基本上和上周一样的情况一样
23:01
让我们来获取我们的
23:07
银行 抱歉呃，这家银行将是可变的，它将成为我们的一部分
23:21
上下文，因此该银行帐户将是 PDA，现在正在初始化或
23:28
银行的创建让我们为我们的银行设置一个名称
23:34
函数参数，我们也呃，因为我们将
23:41
在我们的银行持有一些资金，让我们也用其中之一来跟踪它
23:46
我们银行内的字段所以我们就说我们有银行呃
23:54
余额，我们现在将其设置为零，因为我们刚刚初始化银行
24:01
帐户，正如我之前提到的，我们需要跟踪谁是帐户的所有者
24:06
这家银行所以我们只能说银行将有某种形式的
24:11
所有者并获得我们想要的所有者
24:17
让我们只使用签名者 A P 签名者的公钥，所以本质上就是
24:22
调用create函数也将成为初始化bank的所有者
24:32
帐户，我们可以通过在我们的上下文中访问我们的上下文来再次执行此操作
24:37
帐户，我们还将有一个用户，该用户将是调用此函数的签名者，我们将
24:44
使用他的密钥作为所有者，现在当我们完成后，我们还需要返回
24:51
沙龙运行时执行成功，我们通过调用来做到这一点
24:57
好吧，当我们对此感到满意时，让我们继续创建我们的上下文
25:04
创建函数，进度再次相同
25:10
和上周一样，我们使用 diive 帐户宏来告诉我们的结构源自
25:20
帐户，我们称之为
25:26
创造
25:35
现在我们有了结构，让我们指定结构的字段
25:40
所以在我们的例子中，银行是最重要的，它也会
25:46
在这种情况下是我们的 PDA，所以银行只是一个
25:53
我们稍后将指定的银行账户类型
26:01
我们还需要调用我们的首字母或字母的签名者的用户
26:06
我们的创造函数是这样的
26:13
签名者，我们还需要引用系统
26:26
程序现在我们已经准备好了结构，但我们需要定义某种形式的宏，以便
26:33
我们需要告诉银行呃将是PDA所以我们
26:40
可以通过添加宏来做到这一点，就像我们上周所做的那样
26:45
需要呃初始化我们的帐户，我们需要指定付款人，这意味着谁
26:52
将支付帐户初始化费用，以便我们可以进行用户操作，以便
26:58
会告诉调用创建函数的人也将为我们银行的创建付费
27:05
帐户 让我们也指定我们的帐户将要使用的空间
27:12
分配让我们只做 5,000 我们将在接下来深入讨论
27:17
讲座如何正确计算我们帐户的空间，但这非常简单，现在我们正在讨论
27:24
PDA 我们需要指定我之前在演示中告诉过您的座位
27:31
在本讲座中，PDA 是根据程序 ID 和一些信息生成的
27:37
座位在顶部，所以我们可以通过指定座位来做到这一点
27:44
种子将是一系列不同的座位，用于生成 PDA
27:51
地址，让我们添加一个字符串，呃，这个将被调用
27:58
银行银行账户但这显然还不够
28:03
因为这将创建一个带有我们的程序 ID 席位和席位库的 PDA
28:09
帐户位于顶部，但如果您想使用我们的程序创建不同的银行帐户，我们会遇到一些问题
28:16
问题所以让我们为我们这一代添加更多的种子，这样我们就这样
28:23
本质上是确保我们为每家银行生成独特的 PDA
28:30
创建帐户，让我们使用签名者的公钥为例
28:37
这是用户密钥
28:46
ref 所以现在我们已经为第一个座位指定了数组
28:52
一个是字符串银行账户，另一个是所有者的公钥
28:58
这个银行账户让我们也添加凹凸标志凹凸标志呃正如我所说
29:04
你在讲座中会确保没有私钥
29:10
PDA 本质上会将该帐户的地址从黄道上移开
29:16
曲线，因此我们将确保我们没有可供该 PDA 访问的私钥，并且只有实际程序可以
29:23
访问它，现在这几乎就是一切
29:29
对于我们的宏，我们很高兴开始，这将创建我们的 PDA，以便您可以看到它
29:35
与前面的初始化帐户几乎相同
29:40
在上一讲中我们初始化了我们初始化的呃
29:46
我们的呃计算器帐户，但这里我们指定了我们上面的座位
29:52
明确告诉锚点，我们将使用生成的公共呃公共密钥创建一个帐户
30:01
这个席位和计划 ID，我们还在顶部添加了一个凸起，以确保我们银行没有私钥
30:09
帐户，但我们还没有完成创建上下文，我们还需要告诉我们的用户
30:21
帐户是可变的，这与我们上周所做的几乎相同
30:30
所以是的，我们本质上是用我们的 uh 设置 uh 和我们的创建上下文，我们只是
30:37
需要定义银行的外观或银行账户的外观以及
30:42
这很容易，我们已经访问了这里的银行，所以我们已经知道我们需要某种形式的名称
30:48
需要某种形式的余额，并且我们需要指定该银行的所有者，因此我们可能只有其中三个
30:56
字段，所以让我们现在就做，呃，让我们指定这将是一个
31:10
帐户，让我们继续添加 p uh 名称，这将是
31:17
字符串呃我们需要添加PB呃
31:23
余额将是无符号整数 64 位整数，我们需要
31:30
我们在这里指定的所有者，我们只说它的所有者并确保该类型
31:38
所有者将是 uh pup key，因为我们本质上是提供一个 puup key uh
31:44
到我们的所有者，到我们银行帐户后面的所有者字段，所以现在我们几乎已经设置了，呃
31:52
我们的创建函数已经设置完毕，让我们保存它
31:58
如果一切都检查完毕，并尝试第一次编译我们的程序，并确保如果您正在使用
32:04
程序结果呃指定我们将使用
32:10
将呃结果写在你的呃嘴唇上。
32:19
RS 所以现在当我们创建了创建函数并且我们已经测试了它
32:24
一切都编译得很好让我们继续实现我们的呃
32:32
实施我们的存款
32:38
函数，因此我们再次将其称为存款，指定存款的上下文
32:52
函数，假设我们还添加了一个参数，我们将其称为 A amount，它将是 lamp 中的金额
32:59
用户将在我们的中捐赠的端口
33:15
银行所以如果你想想我这个函数需要做的就是初始化一个传输
33:23
用户帐户到我们的 PDA 帐户帐户所以我们只需调用
33:30
它交易，现在我们可以使用锚
33:37
兰克萨拉纳程序系统
33:49
指令，现在我们可以调用系统指令，在本例中是
33:55
传输 传输函数要求我们指定两个参数或者抱歉三个参数也就是呃
34:03
输入账户 我们要转入的账户以及我们要转入的金额
34:08
转移所以让我们从用户帐户开始，在我们的例子中
34:15
将是上下文帐户用户，我们将再次
34:23
使用用户的密钥，即用户的公钥
34:28
对于目的地，我们将使用上下文
34:33
帐户，这次我们不会使用用户密钥，而是使用银行密钥
34:40
这是我们的呃 PDA，所以让我们输入 Bank 并键入我们要使用的最后一个参数
34:47
需要提供的是我们要转入的金额，我们将只使用函数中提供的金额
34:54
参数，这就是金额
35:10
所以我们只能说我们的交易本质上是使用锚定长度 salana 程序定义的
35:17
调用称为传输的系统指令，现在只需调用实际的
35:24
交易所以我们只需输入锚链接 salana
35:31
程序程序调用以及我们需要什么
35:38
这里需要做的是实际指定我们在其中创建的事务
35:44
上一步是 txm，就像我们习惯的那样
35:51
需要提供我们将用于此交易的帐户
35:57
所以在我们的例子中，这将再次是上下文
36:03
帐户用户，我们将使用函数
36:09
记账
36:16
通过这种方式，我们已经指定我们将使用用户帐户，但我们也将使用实际的银行呃
36:24
银行帐户是 rpda，所以我们也这样做，所以过程是
36:30
相同，但我们将使用银行帐户而不是用户，并且我们将再次使用
36:36
银行呃两个账户
36:51
信息，现在我们几乎初始化了交易，呃，正如我所提到的
36:57
在我们还跟踪银行帐户内的余额之前
37:03
所以呃当所有交易完成后我们还需要更新银行内的余额呃参数
37:10
帐户所以让我们真正地做吧让我们在这里快速地做所以呃让我们就这样
37:18
再次做一下我们正在使用的上下文
37:25
银行账户和
37:31
现在让我们重写我们的余额属性所以我们就说
37:38
平衡，让我们使用呃加
37:46
等加等量这基本上会加上
37:54
用户捐赠到我们银行帐户的实际余额的金额，以便
38:00
我们已经基本准备好了，所以让我们简单地回顾一下我们所做的事情
38:07
已经在这里实现了，所以我们正在构建一个函数，我们正在使用我们构建交易的系统
38:14
或使用系统指令进行传输从某种呃从某种
38:21
某种源帐户到某种目标帐户，我们还指定了金额
38:27
现在，当我们构建交易时，我们需要
38:32
我们正在使用 Solana 程序调用我们指定的程序调用
38:38
交易，我们也就像我们习惯做的那样，呃需要指定所有
38:43
我们将用于此交易的帐户，在本例中是用户帐户和银行帐户
38:49
因为这些是我们在交易之后读取或写入的唯一帐户
38:57
完成后，我们还需要更新我们的银行帐户内的余额，我们正在这里执行，我们正在使用呃
39:06
我们的余额属性是可变的，我们将在之后使用此函数添加用户捐赠的金额
39:13
所有这一切都完成了，我们只是让沙龙运行时知道整个存款功能已经完成了
39:23
好吧，让我们重命名我们的上下文，然后继续添加我们的上下文
39:35
在这里，我们再次添加我们的派生帐户
39:43
宏观并创建我们的呃存款
39:55
语境
40:10
所以在我们的例子中，对于我们基本上需要的存款功能来说，这将非常简单
40:16
提供我们的银行帐户，我们还需要再次提供用户和系统
40:25
程序所以让我们首先再次指定我们正在使用一个可变的
40:33
宏，我们要指定的第一件事是实际的银行帐户呃
40:38
银行
40:49
account 银行帐户是我们创建的银行的类型
40:54
在我们与银行做好准备之前和之后，我们也可以使用相同的
41:01
我们之前使用过的结构，本质上就是将成为签名者的用户，并且还引用
41:06
系统程序，因此我们可以在此处添加它，并且我们已经基本设置了存款上下文，因此我们再次指定
41:15
唯一的我们在存款中使用的是我们的银行账户，并且是
41:20
实际签名者或用户，所以我们在这里提供这两个呃两个
41:26
这两个帐户都需要是可变的，因为我们将进行更改
41:33
他们和我们的存款功能都非常好，让我们
41:39
让我们快速测试一下抱歉，这里打错了，我会的
41:45
意识到这不是帐户，而是帐户，让我们尝试编译
41:52
如果一切正常的话，我们的程序会再次出现
42:01
好吧，看来我们做得很好，让我们继续添加最后一个
42:07
函数，这将是取款函数 取款函数会稍微复杂一点，因为我们
42:13
需要确保我们进行了一些检查，只有实际创建银行帐户的管理员才能
42:20
从我们的银行帐户中提取资金，让我们完成我们的计划
42:28
添加我们最后一个函数，该函数与存款相反，即取款函数
42:35
提款功能本质上应该是取走我们想要转回给管理员的一笔钱
42:43
PDA 中存储的特定银行
42:49
存款[音乐]所以让我们做功能withraw
42:58
并且过程几乎相同
43:04
在上下文之前
43:09
提款，我们还需要指定我们要提款的金额，呃这个
43:14
几乎是可选的，我们还可以创建提款功能，以从我们拥有的 PDA 中提取所有资金
43:22
这两个选项都是有原因的，因为我们还存储了
43:27
金额 呃，我们余额中银行账户中存储的金额
43:33
参数所以呃，但为了这个目的，让我们添加金额，这将是一个无符号
43:40
64 位整数是我们要从 PDA 中取出的灯 P，返回值又是程序
43:53
结果，现在让我们考虑一下我们想要做什么呃这个过程与存款非常相似呃但是
44:01
除了呃以相反的方式转移但我们还需要先添加一些检查
44:09
所以呃，在我们这样做之前，我们需要访问我们的呃银行账户，这样我们就可以
44:16
显然，再次从我们的上下文中使用我们的银行帐户，我们还需要
44:21
使用呃我们还需要获取呃用户帐户，这是签名者
44:28
调用提款功能，所以我们只说用户，这将是过程
44:35
几乎相同，所以我们只说可变的
44:41
上下文帐户呃用户是签名者
44:46
调用提款功能的交易您可以继续
44:52
在这里指定我们的提现函数或提现上下文，这样它将是
44:58
与存款几乎相同，我们只需调用提款即可
45:04
也是啊 差不多了 呃 差不多了
45:10
我们的提款功能上下文保持不变，就像存款 U 一样
45:18
也是的，我们基本上可以保留银行和用户帐户，因为这是我们将在我们的应用程序中使用的
45:25
函数所以我们只是说是的，我们正在访问银行，我们正在访问用户
45:31
现在是时候做一些适当的检查了，所以为了检查萨拉纳，我们可以这样做
45:38
呃，例如 Anchor 中的 if 语句，所以我们的第一次检查会
45:43
如果签名者实际上是银行的管理员，则此函数的调用者为
45:50
呃，我们想提款，所以支票非常简单，所以我们就说我们是
45:57
比较我们的银行老板，我们只说银行是否
46:02
所有者不等于用户密钥，这是我们需要抛出一些的用户密钥
46:11
错误并停止我们函数的执行，我们可以通过调用来做到这一点
46:21
返回错误并指定呃错误代码，让我们
46:30
说将是节目
46:36
错误 程序不正确
46:41
ID，您显然可以根据需要指定这些错误，您可以自定义它们，但是呃，这适用于
46:48
我们的示例，因此这是我们在这里使用简单的 if 实现的第一个所有权检查
46:54
声明中，我们还需要检查另一件事，因为我们让用户指定金额
47:01
他想退出呃如果我们想呃我们就这样
47:06
呃，我们需要检查他试图提取的金额是否确实存在于我们的 PDA 中
47:17
帐户所以让我们说另一个如果
47:22
声明并说 r 银行账户
47:28
[音乐]
47:41
信息，我们可以调用 Lamp ports 借用，这基本上会告诉我们
47:46
当前存储在我们的呃 PDA 帐户或银行帐户中的灯端口，我们需要检查是否
47:54
如果该金额小于金额，则数字为 uh
47:59
在这种情况下，用户试图退出，我们需要抛出另一个
48:07
错误呃所以是的，它与之前几乎相同，让我们抛出另一个错误，但它会有所不同
48:14
错误我们称之为不足
48:21
资金所以是的，我们资金不足
48:26
所以现在我们所取得的成就是，呃，只有我们的所有者
48:34
银行将能够呃将能够取款或调用此功能呃如果
48:42
由不是指定银行所有者的人调用它会抛出错误，而且我们还需要
48:49
确保是否是正确的所有者并且他正在尝试提取更多
48:54
存储在我们的 PDA 中的金额将引发另一个错误，从而停止我们的执行
49:02
功能呃，您可能还指出，我们将余额存储为其中之一
49:08
作为我们银行帐户中的字段之一，我们可以用它来检查是否
49:14
我们提取的金额低于存储的金额，但我也使用这里借用的灯端口
49:21
演示您可以使用此函数获取当前存储在中的 Lamport 数量
49:27
指定的帐户，现在当我们完成检查后，我们唯一需要做的就是
49:34
初始化交易 初始化 PDA 和管理员钱包之间的交易或传输 我们将做什么
49:43
这里所做的本质上是减去 um 减去
49:48
来自我们呃 PDA 库的灯端口，我们将重新添加这些灯端口
49:56
呃到用户帐户或管理员帐户，我们可以很容易地做到这一点
50:03
呃，我们可以再次获取我们的银行帐户信息，就像我们呃访问我们的灯一样
50:12
这里的端口我们可以调用尝试借用可变的
50:24
洛茨
50:33
抱歉，只需减去我们想要提取的金额
50:39
现在我们从我们的银行账户中减去 L 个端口，然后我们
50:44
需要以与正在调用的用户相反的方式执行相同的操作
50:51
提款功能，因此我们调用用户帐户信息尝试借用可变的
50:57
灯端口，但我们不是减去，而是将灯端口添加回我们的
51:04
用户这些功能显然只有在有呃我们的时候才起作用，因为我们正在尝试
51:10
借用灯端口，因此我们需要确保我们的银行帐户中有足够的灯端口
51:17
在我们实际借用它们之前，我们通过创建这个 if 来确保
51:22
在其之前声明我们实际上要确保用户尝试提取的金额是
51:28
出现在我们的 PDA 中，之后我们几乎完成了执行，我们可以告诉
51:34
执行执行的 salana 运行时间
51:42
成功了，所以让我们来看看，我这里有一个拼写错误，让我们检查一下是否可以
51:51
好吧，看起来呃，我们的程序非常好，
51:58
编译编译得很好，所以让我们只是说是的，也让我们指出，我们
52:05
在上一讲中也提到过，所有的账户都需要
52:10
存储某种形式的租金，以免被删除或删除
52:16
萨拉纳区块链让我们确保呃我们会在我们的 PDA 中保留足够的租金，这样它
52:23
不会被破坏，所以我们可以通过计算必要的租金来做到这一点
52:28
为了让我们的帐户免受租借延期的影响，所以我们只能说，呃，让呃
52:37
租金，我们可以打电话给 Rent
52:46
得到最小值
52:52
余额，现在我们需要提供我们想要的帐户长度
52:59
计算呃租金的最低余额所以在我们的例子中我们将提供
53:04
我们的银行帐户数据的长度所以我们就说
53:09
再次银行我们将使用呃两个帐户
53:16
信息和通话数据
53:23
Len，通过调用它，我们将得到最小数量
53:29
我们需要将租金存储在我们的 PDA 帐户中，以免收到
53:34
被摧毁是因为我们本质上是让我们的银行账户管理员能够提取任何特定金额
53:43
来自银行账户的呃资金，我们需要确保即使
53:49
管理员从银行账户提款后，银行账户仍然需要保留呃足够的灯端口
53:57
支付他的租金，然后将其添加到我们的土地中
54:05
借钱加租金现在我们非常确定我们是否这样做只是尝试
54:12
如果成功的话，是的，现在我们确信我们可以
54:17
只提取金额，这样我们的 PDA 中就有足够的租金
54:24
不要把它毁掉，但这显然取决于你
54:29
实现，因为如果我们想要创建一个提款函数，其中
54:34
提款会自动提取 PDA 中存储的所有资金
54:40
然后我们就可以从 rpda 获得所有资金并关闭这些项目
54:45
如果我们不想再使用帐户，但在这种情况下，管理员可以提取他想要的任何资金，并且仍然
54:53
保持他的银行运转，所以本质上他只能提取两个灵魂，在他的银行中保留两个灵魂，其他用户可以
55:00
仍然把钱存入他的银行所以这有点多
55:09
灵活是的，所以现在我们已经完成了我们需要的所有三个功能
ed 呃我们已经撤回了
55:16
存款和银行的创建，所以我们几乎有一个标准的应用程序
55:22
代表 defi 呃或者几乎是最简单的例子
55:29
defile on salana 感谢您参加今天的讲座，现在我将把它交给
55:35
我的同事呃给大家介绍一下我们下一个任务的详细信息大家好
55:41
今天您已经了解了 pda，这是 Solana 上使用的基本概念
55:47
凭借迄今为止所学到的知识，您已经可以创造出许多有用的东西
55:54
下一个任务分配的程序，您将编写 Twitter 程序
55:59
用户可以创建新推文，其他人可以添加反应的功能
56:05
到推文，像往常一样，我们将分享 GitHub 课堂链接
56:12
Discord 在下一讲我会给你一些开发最佳实践技巧
56:18
我还将向您展示一些如何调试和呃测试的实践示例
56:25
谢谢你今天的节目，下次再见
