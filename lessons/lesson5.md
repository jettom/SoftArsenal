# lesson
Where: https://youtu.be/LzNVVnXSDdo?si=tj0ikiF4WL6KHU9S

Wen: Today, October 18, 6PM UTC  (you can watch anytime after the premiere)

In this lecture, we will show you some best development practices and give you tips and tricks to debug your programs so you can get up to speed quickly.
Sample repository: https://github.com/Ackee-Blockchain/sos-debugging-lecture/
GitHub workflow example: https://github.com/Ackee-Blockchain/sos-debugging-lecture/blob/master/.github/workflows/ci.yml

git branch
anchore test
https://docs.rs/solana-program/latest/solana_program/index.html

# 文字起こし
```
0:01
hello everyone and welcome to the next lecture of school of Solana and uh today
0:06
we will be talking about best development practices and uh debugging so first I will give you some uh quick
0:13
tips um how to keep your code maintainable and how to avoid bugs
0:18
during the development process and uh at the end we will be doing some handson
0:24
debugging and testing of anchor programs so yeah let's jump in
0:34
and the first tip I have for you is modularize your code uh so far uh during
0:40
the school uh mostly our projects were uh only in one file in the lip. RS file
0:47
um but this is not actually the the best approach so it might be suitable for very small programs but uh in most cases
0:55
you don't want to have you know such a big spaghetti code uh so this is an example of one file of more than 1,200
1:03
lines of code with 20 instructions in one file um it really starts uh quite
1:10
quickly um not being very uh maintainable so uh the advice here is to
1:17
modularize your code uh one example uh that you can find
1:22
is in the an course repository so they are actually uh different examples there
1:27
are some basic examples that have only these flat structure but if you will go
1:33
uh in the documentations folder and programs and tic TCT toe uh there you can find a nice example of a structure
1:40
uh that is commonly used um on Solana in uh in general and uh uh with uh anchor
1:51
projects and uh I have opened the repository here so we can go quickly through it so uh on the left side you
1:58
can see the folder structure uh which is a normal or usual anchor program and if
2:06
we will open the project or the the program uh you can find here that uh as
2:12
usual you have the lip. RS uh file which is the main source uh source file uh of
2:20
your library um and uh again as usual you have here the um anur program macro uh
2:29
that BAS basically uh enables you to insert the the
2:35
instructions but the different here is that the instructions are here only as reer functions uh for the actual
2:43
instructions that are in separate files and uh one important thing is here that um if you want to have uh
2:50
some folder structure uh in Rust you have to use so-called modules and you
2:56
have to publish these modules so um here uh the first modules uh is the
3:03
errors modules uh so here uh the the modules are actually searched uh as
3:09
files in uh in the given folder or uh then as uh
3:15
subfolders so here errors uh it is a it is a file and we can check that in the
3:20
errors files there is nothing else than the definitions of the errors that we would like to use within our
3:27
program and uh then we have instructions and state so uh in instructions folder
3:33
on the left side you can see that you have um basically separate files for
3:40
each instruction so if we will open uh one instruction for example the play uh
3:46
you have here the function play that is called uh from the main li. RS file um
3:56
and also you have the context here and the context structure uh so the advantage here is that you can um you
4:03
have everything that you need uh at one place so you can uh see the business logic of the instruction and at the same
4:10
time you can uh you can check uh the constraints that are imposed by the uh
4:18
by the context structure so maybe we will see it better in the other setup game uh
4:25
instruction uh because you can see here that okay so you have the Anor
4:30
constraints so you can directly see okay within this instruction we are
4:36
initializing new account um that should be signed by player
4:41
one so these are the instructions and then we have also the state folder uh
4:47
again uh it's quite practical because usually the states uh you have multiple
4:52
States or um data accounts of your program and uh this way you have that
4:59
them somehow centralized in one folder so in this case there is only one um State called
5:06
game which is here and also this file includes uh different methods uh that uh
5:12
Define the actions that you can use uh on the game
5:17
structure so this is a very common way how
5:24
projects on Solana and also in Anchor are structured uh it is quite practic
5:30
uh even for small projects so in most cases I would recommend to go at least
5:36
this
5:42
way the next tip is that you should always visualize your program flow and
5:48
data flow you will have um security lecture later on so you will
5:56
again see why this is important but anyway it is really good practice to
6:02
visualize uh your program for flow on the left side you can see uh here who
6:09
can basically with some color code uh who can invoke the given instruction uh
6:15
so for example you know directly that admin can involve only these instructions uh so uh you can also test
6:22
it for example in your tests and which is also important is really the flow and
6:28
uh the the sequence of the instructions uh because you can directly see here
6:34
that for example uh you cannot claim tokens before a sale is closed and this
6:42
is also very good for testing uh to have some visual clue because then you can um
6:49
directly see that uh you should test that tokens uh cannot be claimed before
6:55
the sales are closed so this is the program program flow and uh what is also
7:03
very good for testing and for documentation uh for other developers or
7:09
maybe even users um is the data structure so U here you can see an
7:15
example uh of an Associated token account uh that basically it is a PDA uh
7:22
account that is based on the owner uh owner's public key
7:30
uh then the token program ID and the the
7:36
public key of the mint account so you can directly see uh the structure what
7:43
is saved where and how the PDA is
7:56
calculated another tip is to use GitHub workflows and uh basically the
8:04
development process tools that GitHub offers it's uh quite rare to see
8:09
projects to use uh GitHub workflows but um it is um actually quite easy so here
8:15
we have an example um how to set up um automatic uh anchor tests so um uh here
8:24
you have a definition of the job that is called run anchor test uh it runs on the lat
8:29
um Ubuntu uh distribution and uh first um you just check out your uh your
8:37
repository uh then you set up uh here I have a script that you set up Solana uh
8:43
with some specific version this is just um environment variable where you can
8:48
set the version of Solana that you would like to use then you have to set up
8:54
anchor and again with a specific version and once you have that you can just
8:59
execute the aner test uh command uh rust is already installed in the Ubuntu
9:06
distribution so uh that's it what that's all what you have to do uh the only
9:12
thing that is not visible here are the scripts to setup Solana and setup anchor
9:17
uh these are also not very complicated um I will share um a repository after
9:24
the the lecture so you can check it and um yeah also I think in the anchors
9:30
repository they are using also um some automated testing so uh it's a good
9:37
practice to uh you know check also in other projects how they do they do
9:42
stuff so yeah so this is uh very good to you know set up uh some actions for
9:49
example on uh pull requests uh that the pool request has to pass some checks one
9:55
of them uh should be that the anchor test pass this is one point and then of
10:03
course peer reviews uh should be done also so of course if you are the only uh
10:08
developer then uh it's not feasible but uh if you are multiple persons in your
10:14
team uh then I really recommend that you use um that you set up your GitHub uh in
10:21
a way that you cannot merge uh before a second or independent person reviews
10:28
your brick request and that the workflow checks or yeah
10:38
pass and then another tip um on Solana
10:44
the the difference is or compared to other some other blockchains is that you
10:51
cannot control the data that are flowing into your programs uh and over the trans
10:57
transactions that will be sent to your program so the only way uh to check it
11:02
is within your program so your your program is basically public and anyone
11:07
can send anything to your programs so um it is um very naive uh to say that yeah
11:15
very often we uh we hear that some projects say we don't check something in our Solana program because it is checked
11:21
by our back end uh so please don't do that um every time check your data uh
11:30
within your program because anyone can call your program and if you do not check it uh within your program uh then
11:37
there is a high chance that somebody will um exploit
11:43
it and then I cannot emphasize it more but um you should also test test and
11:51
test uh your programs you should uh aim to high test coverage so often um projects that we
11:58
audit uh have either very low uh test coverage uh or in some cases uh no tests
12:06
at all um and uh yeah in most cases the
12:12
projects test uh so-called happip paath scenarios so they basically verify uh
12:18
that um their program works as they would like to to work as so for example
12:23
we have here the simple Ico uh initial coins uh offering and some launch pad
12:30
work workflow uh so the test may be cover this workflow uh but it does not
12:36
cover uh a case where uh the flow would be different so again for example that
12:43
somebody would start to buy tokens before the sales are opened or maybe
12:49
someone would already start to claim uh um uh the tokens before the the sale is
12:56
closed or uh some unexpected scenarios so um actually you know the unhappy path
13:05
scenarios are maybe even more important to to test and uh yeah so this is one thing uh
13:13
you should really change or test different uh program flows but you should also test um that uh you supply
13:23
or someone supplies unexpected accounts to your to your program so uh if you can
13:28
see in this diagram that for example open sales can be done only by the administrator of uh of the Ico uh then
13:37
you should also test that it is really the case that only a specified admin can
13:43
test it and not an unauthorized
13:49
user and speaking about tests uh there are actually different options and a lot
13:54
of options so um I would say that you know you know the anchor integration tests uh using
14:02
local test validator uh this is uh really a must um that every project
14:07
should have so this is uh what you had the chance to see already with uh with
14:13
Andre with my colleague during the lectures and this is also how you test your assignment when you run anchor test
14:21
uh so this is one option uh another uh option is uh also or like on top option
14:28
is to use rust unit tests uh I will show you during the Hands-On how you can do
14:33
it but rust has a very nice feature that you can um test your methods for example
14:40
and uh you can write tests directly in your source code so uh um yeah it is
14:48
also a very good way how to test your methods for example especially if you calculate uh some or if you do some
14:55
mathematical operations uh it's very good to to to test it properly using the
15:00
unit tests um and there are also um other
15:06
Alternatives how to test with rust so either you can use the
15:11
runtime or uh that basically does not spin the whole local validator it's uh
15:18
um I would say faster um to to run the tests uh but uh maybe some features of
15:24
the blockchain uh are not available uh maybe some oper ation with block slots
15:30
uh or sorry with blocks and Slots um are not working as uh in a real um validator
15:40
but usually it's quite sufficient also uh or you can use a local Val validator for the integration tests uh there is uh
15:47
basically a rust crate directly from Solana that you can use and uh I would say like the last
15:55
level of testing uh would be fast testing uh so um not sure if everybody
16:02
heard about fast tests but uh fast testing is basically an automated way uh
16:07
to provide some random inputs to your to your program and uh um the fast test is
16:15
trying ready to find unexpected ways and unexpected data that will crash your
16:21
your program we are uh developing our Tool uh the current name is delnik it's
16:28
so it might be changed in the future but uh this is actually a rust based testing
16:33
framework that helps you to write tests for anchor programs so our Tool uh
16:41
basically generates a program client that helps you to invoke the uh instructions of your program and uh it
16:49
also uh helps you to write fast tests um because it creates some
16:56
um it it provides uh CLI interface to run the fast test and it provides some
17:02
templates so um I will show you uh during the Hands-On how you can do
17:11
that and now it's time to pass to the Hands-On
17:17
examples I have created a GitHub rippo for you so you can follow follow along
17:23
and uh first we will start with this branch uh1 uh but if you would like to jump for
17:30
example in the middle uh then uh you can just check the branches there are multiple branches and you can switch to
17:36
the to the given Branch without having to resolve the uh the previous
17:43
issues so uh as you can see this is U just a normal anchor program structure
17:48
as usual I have a simple program here uh where there is an initialization
17:55
instruction and uh there is one data account where we can save um authorities
18:02
public key and some uh counter which is an unsigned 8bit
18:08
integer and uh in the initialization context structure uh you can see that we
18:15
have a user which is the signer and uh the the user basically signs and pays
18:22
for the creation of a new data account and the instruction itself uh
18:27
doesn't do anything else than just uh you know saving the authority as the
18:33
user pup key and setting the counter to zero and then writing the the data to
18:39
the console and also we have very basic test
18:44
where we only invoke the initialization uh
18:51
instruction and yeah and we actually create the user and data key pairs that
18:56
are passed as accounts into our instruction and the user signs signs the
19:04
transaction so now if we run the test we will see if it
19:13
works and unfortunately it doesn't so now you can see the error it says error
19:19
signature verification failed so uh you might say okay so I have here the
19:26
user it's within the signers if we will go back uh in the program you can see
19:33
also that uh here uh this is the the only signer required by the um signer
19:40
data type um however um if you will find such
19:47
a such a failure failure then you can be sure that something is wrong with with the signers that you uh provide so you
19:56
just have to think uh if you really Supply the correct uh the
20:03
correct account uh that should sign so in this case uh it is correct um but
20:10
then you have to also think if you uh really um passed all the signer signers
20:17
that you are expected to pass and so actually uh in this case we are creating
20:22
a new account it is not a PDA account account if it would be uh a PDA account
20:27
then uh the program itself can uh sign but in this case uh you have to also
20:34
sign uh the the transction using the key pair of the data account
20:40
so if we will do that uh we just have to add the data uh accounts key pair here
20:48
and if we will uh run again the anchor test then we should see that uh it works
20:56
and that this error VIs
21:04
appears and uh it is the case so now actually we have different
21:11
error now that we have successfully resolved the first signature
21:17
failure we have another problem and uh the error said failed to send
21:22
transaction transaction simulation failed so if you will see that the transaction simul failed uh it means
21:29
that uh the transaction was even it was not sent to the to the validator and uh
21:38
already the simulation failed and there is some error during the processing of
21:43
the instruction zero so um yeah it actually says actually
21:49
nothing uh so what options do we have how to debug this this problem and uh I
21:55
can guarantee that you will uh have this uh errors very often so you must know
22:01
how to resolve it uh one thing or the very first thing that you should do is
22:06
to look um in the logs of the local validator and uh if you will use anchor
22:15
uh then one way uh where to check the logs if you uh run the anchor test then
22:21
automatically the logs are stored in the in the hidden Anor folder under program
22:27
logs and uh your program uh then has locks uh corresponding to the pup key of
22:34
your program so if we'll open it uh you can find here some text streaming
22:39
transaction logs but unfortunately the lcks are empty so it will not really
22:44
help us in this case there is a trick what you can do one of the
22:49
options and uh the trick is that you can actually skip the so-call pre-flight
22:55
checks uh so uh here is this RPC method that is uh sending the the transaction
23:02
to the to the validator uh and there are some options that you can use and this
23:07
is the skip pre-flight if you set it to true it will skip the pre-flight checks that are done
23:13
before sending the um the the transaction so if Will if we will uh
23:19
execute now the the test again let's see what
23:26
happens so there is still an error but the error is
23:32
different and now we can uh check the logs and as you can see uh there is
23:39
already something in the logs and it is very important to study carefully what is written uh here so you can see that
23:46
status is error processing instruction Zero Custom program error one this is uh
23:52
actually the same that has been written before but now uh you can see that uh
23:57
there is an error uh within the program 111 this is the system program that
24:04
failed so now you know that the the error actually originated from the uh the system program and not from your
24:10
program uh um not directly from your program and also now we are lucky
24:18
because it is written here that uh it happened during the transfer and there
24:24
is insufficient there are insufficient lamp boards and we need actually this amount of lamp boards and this is
24:30
due to the fact that we are initializing new account and uh therefore we have to
24:36
pay for the creation uh and allocation of for the rent of the new new
24:41
account now that we know that uh some of our accounts does not have enough lamp
24:47
ports we just have to find out which one in this case it is uh quite obvious uh if we will go to the salana program or
24:56
anchor program you can see see here directly that the payer for this uh for the initialization of the program is the
25:04
user account uh but uh in some cases uh it might be not so obvious so what you can
25:11
do for example that uh you can write uh into the lock the the balances so you
25:18
can use here um the get balance um method of the given public key so in
25:25
this case in this case we can run it for the user uh if we will run the test then
25:31
it will print the balance to the to the logs and uh if we scroll up yeah you can
25:40
indeed see that the user balance is zero so the only thing that we have to do now
25:45
is to airdrop some SCE and uh I have here already a little
25:53
repper function so one way to to air drop is to use the before uh hook
26:00
function that actually executes before the the tests and uh
26:06
then uh you can use the here the uh airdrop uh function and it is very
26:13
important also not to forget to await the uh the function this is one thing
26:19
and I also explicitly uh Set uh the
26:25
confirmation uh here that we want uh the transaction to be confirmed uh that way
26:31
we are sure uh that uh the user will have some balance uh before invoking the
26:36
next uh instruction so yeah uh this function will just
26:43
uh uh air drop this amount of lamp ports and now we should pass the test so let's
26:49
try
26:54
it and great so user balance is there and we have passed the
27:00
tests also another uh trick how you could investigate the the issue so uh
27:07
let's uh just delete the the air drobe to reproduce the the error that we
27:13
had and uh so what you can do is that you could just send the uh transaction
27:19
uh not the anchorway but the Ros Solana way let's say so you could just uh
27:25
Delete the RPC method here and you you can just get the uh the transaction that
27:32
you would like to send and uh then uh you can use uh Solana function send and
27:41
confirm transaction and um if we will execute the tests now uh you will see
27:48
that uh the error will
27:56
change
28:04
so now it says failed to send transaction transaction simulation failed attempt to debit an account but
28:10
not found uh but found no record of a prior credit so uh yeah this is another
28:15
trick how you can investigate different uh
28:22
issues now that we have passed our test we would like to try something else
28:28
and uh let's say that we would like to create and initialize a new data account so what we will do now is that we will
28:35
just copy the initialized instruction and uh let's
28:40
uh let's invoke it once again and let's run the test to see what
28:52
happens and so as kind of expected there is an error again it says transaction
28:57
simulation failed and the error is not really user friendly it says custom
29:02
program error uh zero uh X zero uh so we
29:09
can use the same trick as before uh so now it's quite obvious that
29:14
the the problem is in the second instruction uh we can again use the skip
29:20
pre-flight to check the the logs so let's run the
29:26
tests
29:31
and yeah so now we can see the see the log so uh we can see that the first uh
29:37
instruction the status is okay uh the first account was initialized and the program wrote the the the expected data
29:45
in in the logs and then there is a problem in the second invocation of the
29:50
send uh same uh instruction the instruction initialize uh and uh yeah we can see
29:57
that there is a problem during an allocation because the uh address uh
30:02
this address is actually already uh in use so you cannot uh allocate uh the
30:09
data account uh again and uh yeah this is um as expected
30:16
because uh if we check in our program we use here the anchor constraint in it so
30:23
uh it uh it shouldn't be possible to reinitialize the same account so this
30:29
the the behavior is as intended uh what I would like to show
30:34
you is uh in case you don't have the description of the error here in the logs it might happen uh how you can
30:41
investigate the pro the the issue so uh now we can see that uh actually the our
30:48
program failed because uh again the system program failed so the program one
30:53
one uh and so on failed with custom program error
30:58
0x0 so you might ask yourself what is the z0 uh error and uh did the way how
31:05
you have to investigate it is basically to go to the documentation or to the source code um first of the system
31:14
program so I have here uh the documentation that is online of the
31:19
Solana program here and I'm in the file program error and uh here we have uh eneration
31:28
of the program errors which are indexed from zero so this is the first
31:35
error uh with index zero this is uh index one and so on and we can see that
31:42
the uh index zero yeah is uh the custom
31:47
error so it corresponds to uh our our um error
31:54
message and also here you can see that that uh the second number is uh the
32:01
index of the error of uh the other program that uh basically or the the
32:07
sorry the custom uh error that is uh thrown from some other part of the
32:13
system program and uh if we will go back to our program uh it uh is obvious that the
32:21
error is during the processing of instruction zero so uh it will be
32:27
uh an instruction error and again uh you would need to search in the
32:33
documentation we can go now we are in the system program so it will be the system instruction if we will uh go to
32:40
the system instruction. RS file uh here again are another errors specific for
32:48
the instructions and if we will check the index zero that is account already
32:54
in use and this is actually uh the error that we have encountered so um yeah it's
33:00
quite tedious but sometimes it happens that the description is really not obvious or is not there at all uh so you
33:08
have to kind of dive in uh in the code so uh this is the way uh how you can do
33:16
it and uh so now to resolve our issue we have to go to the tests and um
33:23
obviously um yeah the the the thing is that we are trying to
33:29
reinitialize uh the uh the account that we have already initialized the data
33:34
account so again this is a very simple example uh you can uh see that directly
33:41
uh but if not then uh what you can do is that you can for example just uh uh you
33:46
know uh write in the console the public keys of the accounts that you are using
33:51
and then you can uh compare it with the logs because uh it says here that uh you
33:57
know the this uh address uh is already in use so uh that way you can uh connect
34:05
the public key to the accounts that you are
34:10
using yeah so to resolve the issue here uh what we can do for example we will
34:15
just uh create another let's say data account data to and uh we have to of
34:21
course change it also uh here in the instruction and uh if we run uh
34:28
tests then we should
34:33
pass yeah it's green so we are fine I have prepared a new example of
34:40
another bug so we have exactly the same uh test code I have just introduced a
34:47
small bug in the Solana program and uh if we will run the
34:53
tests we will see the aor message so now you can see that the error
34:59
message says already anchor error caused by account data so in this case the error is uh quite uh yeah
35:08
self-explanatory because it says also account did not der deserialize so in
35:13
this case uh the error is not uh in the test script but it is really uh in your
35:19
anchor program and uh therefore we have to go
35:25
uh into our program we will find the data account and it
35:32
says that um the account was not deserialized uh so uh in this case uh it
35:40
means that probably the space uh is not calculated correctly uh we can check it because now
35:47
we have 32 bytes that corresponds to the public key and one bite to the uh
35:53
unsigned 8bit integer counter uh but as you have learned already we also need to
35:59
um account for the discriminant that are 8 bytes so we need to add here eight
36:06
bytes uh the error is uh says that the account cannot be deserialized uh which is maybe a little
36:14
bit counterintuitive but uh it's actually because first anchor uh
36:19
initializes and creates new account with the and allocates the given space and
36:24
then uh within your instruction ction the account uh is deserialized and if
36:31
the space is not sufficient uh then Anor actually throws an error um during the
36:38
the DC serialization so if we run our test now we should pass the
36:54
test and yeah the test is green now we will do uh some small
37:00
modifications to our program uh we will actually uh tell our program that we would like
37:08
to use a PDA account that uh will have the
37:14
seats um for example
37:19
data and uh we also need to uh send the bump there so this is uh how to use a
37:28
PDA and uh we will slightly modify or we will just delete the second
37:34
initialization in our program we don't we don't need it anymore so if we will uh run our tests now let's see what
37:54
happens yeah so we have uh an error that says an unknown signer and uh so we could uh actually
38:02
again write in the console the the public keys of the accounts that
38:07
we are using but in this case uh the the unknown signer it is the data account
38:13
and uh it makes sense because now the data account uh it should be a PDA
38:18
account and uh PDA account does not have a private key uh so it cannot sign the
38:25
the transaction so if we uh will create a new PDA account it is the program
38:30
itself that will sign for the uh creation so we just need to remove this
38:37
signer let's run the test again what
38:46
happens and we have another error that says anchor error caused by account data
38:51
okay so now we know that uh we are already uh in our program and the there
38:56
is some constraint anchor constraint that was violated and if we if we read
39:02
further then we see that uh the constraint seat error occurred uh seats
39:08
constraint was violated so uh it basically means that you are using here
39:15
the uh data account uh which has address that does not correspond to the PDA
39:22
derived from the data or from the seat that you have uh set in your program so
39:28
it says that uh the uh PDA address does not correspond to this uh seats and
39:35
bum so what we have to do is uh we need to calculate uh the correct address and
39:42
uh this is used uh for this we can use uh public
39:49
key function so it get public key uh find program address sync and uh then we need
39:57
to pass uh buffer
40:03
from data so this is the seed and uh then the next uh parameter
40:10
is the program ID so this is program program
40:16
ID all right and uh this function already Returns the public key so you
40:23
can just delete it here
40:29
oh yeah just square brackets here all right so
40:36
let's check if it
40:42
works cool and it works the test is green to show you the last issue today
40:50
we will have to modify our program slightly so um what we are going to to
40:56
do is that we are we will pass a new uh count parameter to our
41:04
instruction and uh then uh we will uh
41:09
let's say uh do some mathematical operations so we will say for example 10
41:14
the counter will be equal to 10 minus the count per
41:20
meter and uh then we can do aner aner
41:25
build it will rebuild uh the program and generate the IDL so we can see that in
41:32
our tests yeah so our test is already complaining so we just have to pass a
41:39
parameter here so uh for now let's pass only one and check if the program
41:54
runs yeah so it it works so what we will try now is uh we will increase the
42:00
number that we will pass to 11 and see what
42:09
happens and there is an error it's a it said failed to send transaction
42:14
transaction simulation simulation failed and it says program failed to complete
42:19
so there is currently there is no other um error code or something like that so
42:27
um definitely there is an error in our program we can use our old trick with
42:33
skip PreFlight to check the logs if there is something more so let's
42:39
execute the test again and open the
42:46
logs and now you can see that it says program lock panicked at attempt to
42:52
substract with overflow and and uh you can see that
43:00
yeah the system program succeeded so there is no uh problem with uh creation
43:06
of new accounts or something like that uh it is really our program that that failed and you can even see directly the
43:13
file and the line where the problem is located so if we will go back it's on
43:20
the line 14 uh and it's obvious here that uh if we pass
43:27
count number greater than 10 then we will have an overflow so uh to fix that
43:35
there are different ways how to how to fix it a very common way is to use
43:41
require macro so like that and we can check that the
43:47
count is uh smaller or less or equal to
43:52
10 and uh if not then uh we we should uh we will return an error uh we don't have
43:59
a custom error now so uh this is something that we can uh
44:05
create uh when we work with anchor programs uh we can use
44:10
um macro called error code and uh we will just create a new
44:17
enumeration let's say my error that will Define our errors uh we can also Define
44:25
um m messages that will be included uh so let's
44:32
say valate count value or something like that and uh then the enumeration variant
44:41
will be invalid
44:46
count for example so this is the error that we will return so my
44:54
error and it count okay so let's try to
45:01
run the program again or the
45:16
tests yeah so there is an error uh but if we will open the logs we
45:24
can see in the logs directly that you know anchor error thrown in program at the given
45:30
location uh and you can see that your error code invalid count is in the logs
45:36
also with the message invalid count value and the error number uh it's uh
45:43
6,000 actually all the custom errors uh from anchor are offset it by 6,000 so uh
45:51
the your invalid count error has index zero so that's why it has also the
45:58
number 6,000 during the introduction I told you
46:04
that it is very important to test so that's why I would like to show you now the different ways how you can test and
46:11
uh we will start with unit testing so uh rust actually supports a very nice way
46:18
for unit tests where you can write your tests directly in the uh source
46:24
files One Way um how you can do that uh
46:30
to test your logic is uh to um let's say wrap uh your functionality
46:38
in separate functions so what I'm going to do is that I uh instead of having
46:44
this inline uh calculation of our counter I will create a new
46:49
function so to save time to save some time I will just copy what I already
46:56
have so um it it will be a function called math function that takes as input
47:03
the um count parameter and it does essentially
47:09
the same it takes 10 unsigned 8 integer
47:14
and it substracts the the count perimeter uh as you can see here we are using uh checked arithmetics so a
47:21
checked subtraction uh that returns an option so
47:28
uh in case there is uh everything is all right uh it returns some uh and some
47:36
variant of the option enumeration with the result and in case of overflow um it
47:43
returns uh non option and to call this uh function uh
47:50
we will
47:59
we just call it like that and uh as it returns uh the option
48:04
type uh we would either need to handle uh the the return options but in that
48:11
case because in this case because we have already the require condition here
48:16
uh then uh actually it will never [Music] be non option so we can just unwrap it
48:24
so it's uh uh it's ritten done here but it's just for the purpose of this uh exercise so
48:31
once we have this uh function we can very easily tested using um rust unit
48:37
tests and uh for that um from the documentation you can easily uh copy uh
48:44
this uh snippet so there is a a test configuration mcro that uh tells
48:53
um that uh this part part is related to tests uh then the tests are in a
48:58
separate module and um you can basically write your tests using um additional
49:06
test macro and we are also importing the the main uh trade here uh the super
49:15
uh sorry not the trade but the the crate uh so that we can use the functions
49:20
defined in this uh in this crate or in this file um and uh to test our function
49:27
uh you can use we can use the assert uh macro again so for example
49:32
assert equals and uh we can say that for example the math function of and if we
49:41
were pass two uh it should be equal to 10 minus 2 it's 8 and our function
49:48
Returns the sum option and the result will be eight
49:56
and we can try to test another uh case uh where we will pass for example 11
50:03
where the overflow will happen and our function should return none and that's
50:09
all what you can then do is just to uh for example here in VSCO automat code
50:15
you can see directly uh this link so you can click run
50:20
test and it will run the test that you can see uh test math function it's okay
50:27
and it passed and also here you can uh see the
50:33
command that has been executed to run the test so if you just uh copy uh this
50:39
uh and run it from the terminal that then it will execute the same test or uh
50:44
also you can just uh run uh cargo test uh like that and it will
50:51
automatically execute all the integration tests rust integration ation test and also the unit
50:57
tests so these are the unit tests and uh
51:02
then now we will extend our integration tests from uh typescript client so what
51:11
are we going to do that we will test Also let's say for some errors so we
51:18
will just copy this uh this uh test and
51:24
we will change the name and uh uh we will name it for
51:29
example uh cannot
51:35
initialize within uh correct data
51:40
account and uh in the previous issues that I have showed you uh was that if we
51:48
will uh pass let's say some uh non PDA account then we will get a anchor
51:53
constraint so uh this is something that we would like to test for example so we will create a new
52:02
um account just uh generate a random one so
52:09
it is uh not a PDA as
52:15
expected and then now we will uh pass this account here and uh so now we know
52:24
that uh and will return an error um with the error code constraint seats but we
52:31
would like also to test it so what you can do you can wrap uh your uh
52:36
invocation of the instruction to a try catch
52:43
block something like that and then we will uh catch the
52:52
error and uh and Anor provides uh simple
52:59
parser of the errors we would we can use so it's like this
53:06
parse and uh it actually parses uh the error from the
53:13
logs like that and uh then uh again we can use the uh we can use assert to
53:23
assert that uh we have re received the expected
53:30
error and also one important thing is that uh it might happen that in your program you expect to to receive an
53:39
error uh but this uh try and catch uh block uh actually will uh pass correctly
53:47
if there is no um error in your program and uh therefore the assert here will
53:53
never get executed and if so so if there is no error in your program the test will just pass so this is not what you
54:00
want so um one uh one thing what you can do is that
54:05
just after the the RPC call you will add let's say a a fail call that uh that
54:14
this this will always uh fail if it does not fail before and if it fails here
54:21
then it will be catched in your block but your in the catch block but your test will uh not pass because uh the
54:29
fail uh the error code will not be equal to the constraint
54:35
seats all right so let's try if it
54:54
works okay it does not work but yeah it's
55:00
because we skipped the pre flight and uh also uh we have here this
55:07
parameter that will cause the area in our program so this is not what we want now and we will also skip the second
55:14
test for now so let's try it
55:24
again and yes it's
55:29
working one last thing that I would like to show you is how to verify the onchain
55:35
data so for that we will use our second test so we will just delete the skip
55:40
here we don't need a console here anymore um and uh yeah so when you are
55:46
testing it's not enough to only invoke uh the given instruction uh that and
55:52
verify that there is no error uh you also Al want to in most cases uh you want to verify that the data written on
56:00
chain are really the expected data and uh what you can do is fetch the
56:06
uh the given account so in this case uh uh we would like to fetch the data
56:12
account that we have stored our data and you can uh do it like so that
56:19
you will await the promise from um program uh account then it's the my data
56:28
account and then you will fetch the data and here you have to pass the public key
56:33
uh which is the data up
56:38
key sorry so it's the PDA so like that uh so this line will just uh fetch uh
56:46
the data from this address and deserialize it based on this um account
56:52
structure so here you can see uh the the structure from the IDL and once we have that we can use
57:01
assert as before so assert uh if we would like to compare the um public keys
57:09
for example then we can use deep equal and uh then use the data account
57:16
Authority uh and the authority that was saved on chain uh should be the user POP
57:23
key and then also we would like to verify the value of the
57:29
counter so again we will use assert uh then strict
57:34
equal and uh now uh we will have the data account uh and the counter and so now we
57:43
are passing here 11 uh which would then return an error but if we will return 10
57:49
then our function in the program should return zero because it will be 10 minus
57:55
10 and it's zero so um also what might
58:02
be useful sometimes is to change the uh commitment here during the uh the RPC uh
58:10
call that should wait for the confirmation so here uh you can pass
58:18
commitment confirmed and uh that way you are sure that once you await this RPC this RPC
58:26
call and the the instruction or the transaction will be confirmed so if you will read the data uh later on uh the
58:35
data will be already up to date so let's try to run our test and check if it
58:48
passes and the test are green today we have disc discussed some
58:55
best development practices and I show you showed you a way and my tips how you can deback your tests and programs and
59:03
uh you can be sure that you will encounter this uh these situations quite often during the development so uh do
59:09
not hesitate to go back to this lecture uh however don't worry over the time you
59:14
will find yourself more comfortable uh to resolve the the common issues um we have decided not to give
59:22
you a task assignment after this lecture so so there will be nothing to submit for the next week however my colleague
59:28
Andre prepared a bonus lecture about SPL tokens where he will show you a Hands-On
59:35
example how to create a simple program with SPL tokens and uh as tokens are
59:41
also a crucial feature we would like you to watch this bonus lecture not only
59:47
tokens are used in uh most salana programs but uh it will also give you
59:52
more space and more ideas to to think about your final project uh where you
59:58
might use tokens uh yeah so the task for the next week will be to watch this bonus lecture
1:00:05
uh there will there will be no grades and it is voluntary but uh I can still
1:00:10
highly recommend it so thank you for today's lecture I hope that now you will be more confident
1:00:17
during the development and uh see you next time

```