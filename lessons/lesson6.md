# lesson6
Where: https://youtu.be/FAJbwhUeheA?feature=shared

Wen: Today, October 25, 6PM UTC  (you can watch anytime after the premiere)

In this lecture, we will show how to implement a simple frontend for our Bank app using the official Solana scaffold.

Download the scaffold here: https://github.com/solana-labs/dapp-scaffold

# 文字起こし
```
0:00
hello everyone welcome to another lecture of school of Solano uh today
0:06
we'll be talking about front end for your salana D app so this will act as a
0:12
brief intro on how you can create a simple front end for your salana program uh we will deploy our program to
0:20
defet and we will use salana scaffold uh on their GitHub repo to Kickstart our
0:27
project so keep in mind that this is a brief intro this is pretty complex topic
0:33
uh it is a whole another world right now uh compared to the salana programs so we
0:39
will just cover the basics on how you can set up your uh or how you can set up
0:44
front end for your app easily in just a couple of minutes and as a demo we'll be using our
0:52
banking app we have created in a previous lecture so uh essentially we'll create a simple
0:59
interface where user uh can uh use the default wallet that he's using in the
1:06
browser to interact with our program and also with all the associated pdas with
1:13
our program so the basic functionality will be some form of creation of the PDA
1:18
account then the creation of the bank itself uh after we have this ready uh we
1:24
will make sure that we will have the ability to list all the banks that are created
1:30
which mean we'll be essentially fetching all of the pdas that are associated with
1:36
our program and we will display them in our application together with the name of
1:41
the bank and the current balance of the bank we will also add a deposit function
1:48
so to every bank that is listed in our front end we will have a deposit button
1:53
that if the user will click that one it will deposit 0.1 So to that particular
1:59
Bank so we'll Implement all this stuff except the withdrawal
2:04
functionality but from everything you'll see in today's lecture you'll be able to
2:09
implement the widraw functionality on the front end yourself so before we start we will
2:16
interact with uh one really interesting repository from salana labs and that
2:21
will be the DAP scaffold this will help us create our application real quick so
2:27
it will essentially Kickstart your project because all of the wallet interaction logic is already implemented
2:34
so we will download the content of this repository or we will clone this repository and we will build on top of
2:41
that so what we'll be adding to this scaffold is essentially just modifying the UI a little bit we'll keep it as it
2:48
is but we don't need to add the wallet connector that's already done in the scaffold but you can obviously create a
2:55
blank react project and Implement all the wallet logic there but our time is
3:01
limited here so we'll use the scaffold and we will just we will just
3:07
add a few different components so we can interact with our program so before we
3:12
start let's just jump in uh no more presentation let's just go straight uh to the coding and we will start with
3:19
cloning this repository so before we touch any front end make sure that we will deploy or
3:26
make sure that you will deploy your program to for example defnet uh the process is really similar to what I have
3:32
described in the previous lecture about deploying to the local cluster but in this case will'll be just deploying to
3:39
the defet so our program will be publicly accessible to all of the wallets that are connected to a defet
3:46
cluster so we will start with uh the project that we have created in our previous
3:52
lecture and let's jump into the anchor. too and make sure that in the provider
3:57
section our cluster is set to defet and our wallet is set
4:02
to/ id. Json
4:07
Json and there is a good reason for the wallet uh we will be creating a new keare that we will be using to deploy
4:14
our program this uh address will be uh your program's update
4:20
Authority so uh let's just start with creating uh
4:25
start with creating our new Keir we can do that by calling
4:32
salana keyen new and we need to specify the output for our keare which in this
4:37
case will be just ID Json make sure that you are in your Project's route
4:42
directory or you can generate your keypad anywhere else but you just need to specify the path to that uh keypad
4:50
you've created here in the anchor. tel so let's just run the keyer
4:55
generation and we have some PP key right here we can see that ID Json was created
5:00
in our project's root directory and what we're going to do now is copy our POP key uh because before we
5:08
actually run the deployment uh we need to be uh or we need to have some balance in this particular account that we'll be
5:15
using for deployment so uh we need to run the airdrop so let's call
5:22
salana salana airdrop specifies so amount you want to get air dropped to
5:29
and also add the wallet PP key or the pp key of the wallet that we have just
5:34
created so let's call salana airdrop one we can see that we the the transaction
5:41
went through we have one soul in our account now let's aird drop some more we have two Soul let's air drop
5:47
some more you can see that this one this request failed uh do not worry uh it
5:53
sometimes fail if you have some issues with the air drop try to specify a lower amount for your air drop
6:00
or try it again later or try it again uh with different delays between the air
6:06
drop you're air drops you're running so let's air drop at least three or four soul to our uh deployment
6:13
account so now we have four soul and we are pretty much ready for deployment uh
6:18
before we actually deploy uh let's call Anchor build and rebuild our project if
6:26
everything uh is fine before we on the actual deployment because you can expect
6:31
that during the deployment you will spend some of the salana that you've been aird
6:37
dropped so this will take some
6:44
time so now our build is complete uh everything went through fine and we are
6:50
pretty much good to go for deployment so let's call Anchor uh deploy that essentially just
6:56
one command will run through the whole deployment process just make sure that you have specified that the cluster is
7:02
devet you have specified the path to your wallet that you will use for the deployment and make sure that that
7:08
particular wallet has enough salana in it to actually run through the deployment process so let's do anchor
7:16
deploy uh we see we have our upgrade Authority here we have the deploying
7:21
workspace which is the RPC that we have in our salana CLA CLI and we can see
7:27
that we are deploying program on a bdas and there is a path to that particular program that we have
7:34
deploying uh you can see that it is running through the transaction so
7:39
uh let it complete after the deployment completion we will get our program ID or
7:46
ID of the program that it is now residing on the def
7:55
net so now we have finalizing transaction and you can see that our deploy was successful and we have our
8:02
program ID that we will use so uh if you have some issues with
8:09
the deployment make sure that you have enough salana uh on your account uh
8:14
because it might fail out down like in the middle of the deployment if you don't have enough salana for all the
8:20
transaction to go through so if that's your case run through the airdrop process again or try again a little bit
8:28
later so now uh when our deploy is successful there is another important
8:34
piece of information that anchor generate for us uh during the actual build process so
8:41
if you check out the target folder in our uh projects folder you can see that
8:46
there is a IDL folder and the IDL folder is containing one Json file that Json
8:52
file is really important for you in terms of uh in terms of uh front end
8:58
development because if you check out your IDL file it is essentially a map of
9:03
all the function and all the accounts that your program is using and
9:09
also you can see that there is an address uh for your deployed program you
9:15
can see that the address matches and you will use this Json to
9:22
have a structure of your program on the JavaScript or typescript side so you
9:27
your salana uh your JavaScript or typescript program has an idea how your
9:32
actual program on salana looks and how you'll interact with all the different
9:37
function and how are the different accounts structured so before we jump into
9:44
the uh frontend development make sure to copy this uh Json file to for example
9:52
any folder on your computer or because we'll be copying this Json file into our
9:58
uh desktop program in some of the cases uh you want to create a mono repo
10:05
which means you will have your front end and also your salana program inside one
10:10
repository in that case you can create a new react project inside your salana
10:17
programs directory but in our example we'll be using the salana D app scaffold
10:23
so we will have a separate project for that so we need to make sure that our IDL file is cop over uh to the new
10:30
project we'll be working with also make sure to note down your program ID even
10:36
though it is mentioned in your in your IDL
10:41
file so now we're in a different project as you can tell we are in a dab scaffold
10:47
uh from the git rap git repository I've mentioned so let's just uh start with
10:53
actually running the project that we have copied from the git repo we can do that by running npm install first this
11:01
will install all of the dependencies for the project you can check out the dependencies in the package.json file
11:09
but uh most of you are already JavaScript or
11:15
typescript developers so you probably know how all this works I will not go into the detail but uh after you're done
11:22
with the installation uh we can run the project using npm
11:27
runev so let's just do that and check out how uh the application looks so as
11:36
you can tell it is uh really nicely designed it is essentially uh ready for
11:42
you to do a lot of the customization or import or add your programs function so
11:49
we can modify it as much as we want this is a great starting point for you you can also as you can tell call
11:56
npx create salana dab this will create create a new uh this will create a new
12:01
dab sample for you uh using just one
12:09
command so before we continue let's also make sure that we have salana wallet
12:14
installed in our browser I believe that most of you already do in my case I'll be using
12:20
Phantom so let's just log in so uh I'm in the I'm in a phantom as
12:29
you can tell I have the Phantom beta so I have ethereum here too but I don't
12:34
know it's really up to you the process is uh pretty much similar to all of the Phantom versions so you can also see
12:43
that I'm currently in the test net mode uh I advise you to enter the test test
12:48
net mode because you can uh run into some issues we can do that by jumping into the Phantom settings jumping
12:57
into uh develop Vel oper settings and enabling test net mode here uh this will
13:02
essentially switch the RPC that your wallet's communicating with to a def net or test net according to your
13:10
settings so let's make sure that our dab that we are running on a local host right now is connecting to our Phantom
13:23
wallet and as you can see it is uh currently connected to my wallet here
13:29
so uh you can tell that you have some Bas you you have an option to actually
13:35
request airdrop so if we click it uh it may fail but we can try it
13:41
again and it will request an airdrop to your uh browser's wallet uh before we
13:47
actually continue make sure you have some soul on your uh on your wallet in the browser because we need to be sure
13:56
that you have some soul to interact with your actual program so so air drop at least one or two so before we go ahead
14:02
there is also a Basics stab and this is you can see it's a little
14:08
bit different for me than to you because I've created this uh I've created this
14:13
sample for our salana banking program so you can see the progress that we'll have
14:20
or our uh dab at the tion look like this we will have a create Bank button and we
14:26
will have a fetch Banks button so if I click create Bank it will essentially initialize the PDA and create a new uh
14:34
Bank inside our salana program and we also have a fetch Banks button if we click on fetch Banks button this will
14:41
call our program or essentially just list out all of the pdas that are
14:46
associated with our program so if different user creates different banks you will you should see all of them
14:52
right here and with each bank that is uh associated with our program or with each
14:58
PDA that is associated with our program we also have deposit a 0.1 sold to this
15:04
particular bank account so if I click this deposit button it should initialize
15:10
the transaction that will send 0.1 soul to our PDA for that particular bank if I
15:16
click approve the transaction should went through so let's just re refresh this
15:22
page and call fetch Banks again and as you can see the bank balance got
15:28
increased so this one is showed in lamp ports but it essentially says 0.2 Soul
15:34
this there have been two deposits in this particular bank so let's just go ahead and start uh with the fact that
15:42
we'll actually customize this dab or this dab template for it to interact
15:47
with our anchor program so let's just quickly start by
15:53
modifying the basics page or the basics view so uh let's rename the B Basics to
15:59
salana bank app let's remove some of these components that we don't need so
16:05
we just remove uh some of this boiler plate code
16:10
and let's jump Bank into the into the bank component we have created here so
16:16
we have a bank component let's rename the component
16:27
here and what we're going to do here is
16:33
create our bank component this Bank component will be located uh in one of the views or one of the pages of the app
16:40
so and inside this Bank component will essentially Implement all of the stuff
16:45
we need to interact with our anchor program so let's remove some of this boiler plate
16:52
code so remove this on click function uh we can also have this um
16:59
can have yeah let's remove this function if we take a look how it looks now it's
17:04
just a simple salana Bap with one button that is currently disabled because the wallet is not
17:11
connected so let's just go ahead leave it like
17:17
this and we're going to start with uh importing one additional package that we
17:23
need this additional package is uh project serum SL Anor and we will need
17:31
this package to interact with the anchor programs so let's just shut our project down and call npm
17:39
install uh at uh project serum SL
17:47
Anor so this will install all of the packages we need to actually interact with the anchor
17:53
program so we should be good and let's import some of the stuff that we need to
17:59
uh to work with our banking component so call
18:04
import and it will be following
18:10
packages and we will import it from uh project serum SL anchor so we'll have
18:17
our program anchor provider vet 3 utilities BN which stands for big number
18:24
and wallet uh we're actually sorry we don't need wallet for this particular
18:30
sample so yeah this is essentially what we need to import and one additional thing that we need is the IDL file I
18:38
have mentioned before so uh let's just copy over our
18:43
IDL file to our uh to our uh front end project so just copy it
18:50
here as you can tell I have our you can you can tell my ID IDL files right here
18:57
so we have our Sal pdas the instructions that our program have uh all of the all
19:03
of the accounts and also the address of the deployed program we going to need
19:08
this IDL file because we're going to imported it right here so let's just
19:15
say import call it IDL from and the path to the IDL we have
19:26
we have imported you can obviously put it whatever wherever you want in your project but I have it in the same folder
19:31
as this component so we have salana pd.
19:36
Json so yeah that's pretty much what we need right here and let's uh also make
19:42
sure that the IDL is accessible as a as a as a JavaScript object so some of you
19:50
might run into this issue but I'm going to handle it directly here so I'm going to Define new constant that I'll call
19:56
IDL uh string uh this will be
20:03
Json stringify and it will stringify I IDL and I'll also add const IDL
20:12
object and we will parse the stringified Json back in so let's call
20:18
Json parse and our IDL string this is not
20:24
completely necessary but it may some it may solve some of the is issues for you when you try to access the IDL or you
20:31
try to reference it in some of the functions so I'm going to do it that way
20:36
and let's just also uh let's just also Define program
20:41
ID uh we're going to need program ID to be defined as a public key so we can
20:46
call new a new public
20:52
key and we're going to fetch the public key from the IDL we have imported so
20:59
let's just do IDL object and we need
21:07
metadata and we need address or actually the uh ID will actually help
21:15
you here if you type in IDL do metadata. address so this is just
21:23
essentially creating a new public key from the string we're supplying here and the Str we're supplying here is from our
21:30
salana pdas file right here so that's the address to the program that we have
21:35
deployed to the definite so now we're pretty much good to go uh let's just go
21:44
ahead and start with the first function we're going to implement and that is
21:50
called get provider and this uh function
21:59
will return us a anchor provider or something that we're going to use to
22:05
interact with our anchor program sorry it does need to be an async function so let's just create a
22:12
get provider and we going to go ahead and create a const
22:19
provider and let's just call new anchor provider which we are importing from
22:25
Project serum anchor and the anchor provider needs to
22:31
be supplied with some of the important things we need to reference here so we
22:36
need the connection this one is H representing the actual connection to the cluster where the program is
22:43
deployed that means we going to need to get this connection from our uh from our wallet but in this
22:51
particular sample where we're using salana daab we are able to reference the
22:58
reference the actual connection that is in the top bar where we connecting the wallet and we're selecting the cluster
23:05
we can do that by calling use
23:10
connection the use connection uh let's import the used
23:15
connection from the wallet adapter react so we have used wallet here let's just
23:21
add use connection and by doing that we can
23:26
fetch the current connection settings in all of the components in or all of the
23:31
pages across the whole project so this is the first thing that we're actually supplying to our anchor
23:40
provider so that's
23:45
connection the second thing that we need to supply is the wallet or the wallet that will be used to pay and sign all of
23:52
the transaction that we will be interacting with so let's just modify our used wallet here so let's just call
23:59
it our wallet equals use wallet and we will supply our wallet here so this will
24:07
essentially reference the wallet connection that is currently uh that is
24:12
currently set up in the uh front end that we're working with so uh thanks to the salana dab we have
24:20
all this stuff prepare so we can just reference it if you want to create the
24:25
front end from the ground up you can do that also but it's a little bit more time
24:32
consuming so now we also need to specify uh we also need to specify the
24:39
uh the last thing and that is the confirm options that will essentially can use
24:46
Anor provider default
24:52
options so but this will essentially tell our provider uh how we want to know
24:58
about the transaction that we are uh we are working with if we want to have
25:03
response for the finalized transaction or if the transactions are pro processing or
25:10
Etc so now we're pretty much set with our anchor provider and we just going to
25:15
do return our provider and we're going to call this get provider function quite
25:21
often we'll essentially use it for all the interaction that we'll be doing with our
25:26
program but now we're pretty much set with our anchor provider the another thing that
25:33
we need is uh wrapper or or or for
25:38
example JavaScript function that will be representing some function inside our
25:43
salana program so we can start with the actual bank creation so that means if we
25:49
call this JavaScript function we will use our anchor provider
25:55
to connect to our program and call the cre create function inside our salana program so let's just call it uh create
26:06
bank make sure that this function is
26:26
asynchronous and what we're going to do here is add a
26:32
TR catch block so just so we're sure to handle all of the errors that may occur
26:38
during the actual transaction that we'll be calling here and the first thing we want to do is obtain the provider so
26:45
let's just say const an provider and that one will reference the
26:52
get provider which will return uh the actual anchor provider to us we also
26:59
need to create a new program which essentially means we need some form of reference to our actual
27:06
salana program residing on a salana blockchain so let's just say const
27:13
program new program the program is a reference to our program we're imple we
27:18
are importing it from Project serum aner and we need to supply a few
27:24
different things here we need to supply the IDL the full IDL I will supply the
27:30
IDL object for those of you who are writing in typescript this is why I've
27:36
created this uh Json string and pars uh because some of you might have some
27:43
issues with referencing the actual IDL object here but I'm going to do it like this I'm going to reference my IDL
27:50
object which is parse from the IDL Json the another thing that we need need
27:57
is the actual program ID in our case we've defined it up here so we're
28:02
creating a new public key from the IDL metadata address and we need the the last thing
28:10
that we need is the anchor provider so we are having the we are getting the anchor provider here at the previous
28:16
line so we're just we just mentioned our anchor provider so now we pretty much uh have a
28:23
reference to our program on salana but we before we actually going to call our
28:29
create function in our salana program we need to be sure that we have created a
28:34
new PDA uh for our bank and we can do it quite easily so
28:41
let's just create a new account uh we'll call it
28:48
bank and let's just call wait public
28:53
key and now we're going to do find program address
29:01
sync that will find uh an address for or
29:06
then we will find a PDA address from the seats that we will specify here uh you
29:12
probably remember that we have specified some form of seats in our salana program
29:19
so let's just jump back into it check it out here so we have our
29:31
we have our PDA here and we are using bank account string as a seat and we're
29:36
also using an users public key or the signer public key uh as another seat
29:42
that we'll use to generate the PDA so what we going to do here is we're
29:48
going to we essentially just saying we want to find the address According to some of the seats that we will supply
29:55
here so the first first seat that we need to supply is the bank account
30:01
string and we can do it by call utilities from the an from the project
30:07
serum anchor package get the bite from the UTF
30:12
string and call the incode on the string that we want to use which in our case is
30:19
bank account that's the first seat uh we are
30:25
using to generate RP da the another one is the is the public key of the user
30:33
that is actually creating this PDA and we can do it quite easily we just call
30:39
our anchor provider access to wallet and we want the public
30:47
key to buffer so now we have specified the two
30:55
seats that we need but for the actual PDA creation or actual finding of the
31:01
PDA we also need to specify a last important thing and that is the actual
31:07
program ID that uh of the program that we have deployed and we can do it by
31:14
calling uh we can do it by calling program reference our program and call
31:21
program ID so what we have done here is we have
31:26
actually find the address according to the seeds here and
31:32
according to the program ID uh or the ID because the the PDA is Created from the
31:39
seats and the program ID the bump is added automatically here so we have F
31:46
our bank account now and we are good to go to call the actual create function in our program
31:53
because right now we have our bank and we can just Supply it as part of the accounts to our context for that
31:58
particular create function so let's call the weight program
32:07
RPC create here we are calling create because it is the function that we want
32:13
to call in our case it's the create and if we look at the create function we
32:19
need to supply three different accounts that is the bank PDA we have created
32:24
here we also need the user and we also need to reference the system
32:30
program and it's pretty straightforward here so the create function have one
32:37
parameter or one argument the argument is called name and it is a type of
32:43
string so it is the name of the bank we have creating we are we are creating we
32:49
probably know that from the previous lecture we have added one parameter and that is the name and we want to call
32:54
this parameter right here or we want to supply app this par parameter right here so let's just
33:00
call Winter School of salana Bank yep so that's our name for the bank
33:07
and it's one of the it's just one argument that we need to call the another thing that we need to supply
33:13
here is all of the accounts that we need to or or all of
33:19
the accounts that we'll be interacting with during the during the execution of this
33:25
function so let's just create a new object the object will have key account
33:31
accounts and that will be another object and here we're supplying all of
33:38
the accounts we have specify in our create context which is the bank user
33:44
and System Program so the first thing we need is the bank the bank we have find
33:50
found our PDA account here using F program address sync another one is the
33:56
user or the signer that will be creating this bank account and we can access it again using
34:03
our anchor anchor provider or anchor Provider by calling
34:09
wallet Dash or dashu key it's pretty much the same thing
34:16
we're calling here we just don't need it in a buffer but we're calling it here too to find the PDA for this particular
34:22
user that's calling the bank creation so we are supplying the user and the last
34:28
thing we need is the system
34:33
program so we have System Program and we can reference the system program's program ID manually by supplying string
34:42
or supplying the public key but we can do it by calling VB 3 Das System
34:52
Program Dash program ID
35:00
so now we're pretty much we pretty much called the function inside our salana program or inside our salana anchor
35:06
program so we are awaiting the confirmation here according to our setup
35:12
here we are using the default option so it's waiting for the confirmation or for the
35:19
finalization uh so if we put something uh behind the await or behind the actual
35:25
call let's just call console.log and we're going to
35:31
call uh wow new bank was
35:38
created and let's just also print out the the address or the PDA of that
35:46
particular bank so let's say bank. to
35:51
string so that will print out the address of our PDA account here so
35:57
we have this and in case any of this fails or there is some issue during the execution we can catch it in the in the
36:05
catch block so I'm just going to do a pretty simple uh error while while creating the
36:13
bank so we can do it like
36:18
this and we are good to go with our create Bank function so that's good news
36:24
so we have our create Bank let's just run through it again we are getting our anchor provider we are creating a
36:30
reference to our program by supplying the IDL of the program we're calling the
36:36
program ID and setting up the anchor provider for this reference before we can before we can
36:44
call the create function we need to find the address for our PDA and we can do
36:50
that by calling public key. find program addressing and it will find find a
36:57
particular PDA for that specific program ID and the supply seats please make sure
37:04
that these seats match the actual seats we have specified inside the anchor
37:09
program uh otherwise you won't be able to match them so after we have found the
37:15
bank account we need that bank account address to supply it for the accounts
37:20
for our actual create function we can call the create function using program
37:26
uh RPC create we are supplying the name of the bank and we're also supplying all
37:34
of the accounts that we're going to use during this functions execution uh inside our context if you
37:41
have any issues remembering what accounts you need to supply you need to refer back to your uh salana program
37:49
source code or you can jump into the IDL file and you can review all of this
37:55
stuff here so you you can see we have Bank user System Program and one argument called name so we have argument
38:02
here and all the accounts here so this will call the actual
38:07
execution of the function and after that execution is complete we are just printing out into the console wow we
38:13
have created a new bank and we're also printing out the uh PDA for our
38:19
bank in case something happens during the execution we can catch it in the catch
38:25
block so yeah we have successfully uh created uh a create Bank function so
38:31
let's just go ahead and Implement some more uh there's another important feature that we need to have in our UI
38:39
and that is the list of all the banks that are created so what this function
38:45
will do is essentially find all of the pdas that are associated with our
38:52
program and after it found all of these addresses we need to fetch the content
38:57
of these accounts or at least we need to know what's the name of the bank we need to know what's the balance of the actual
39:04
bank and we can also optionally fetch the owner's address for
39:13
hpda so let's just go ahead and create uh our uh fetch or or get Banks function
39:22
we can call it get Banks and the process is extremely
39:27
similar so it will be an ASC
39:37
method and we're going to yet again start uh with obtaining our anchor
39:49
Provider by calling get provider so we have our anchor provider and we also can
39:56
can just copy the reference for our program it's really up to you how we going to struct structure it but I'm
40:03
just going to copy it right here and let's create another TR catch block so we can handle different
40:12
exceptions and we're going to start by calling promise
40:18
all uh because we'll be chaining out promises here now the first one is
40:25
uh calling the connection not the anchor but the actual connection and we're
40:31
going to not the anchor connection but the connection that we have uh in our UI so
40:39
and we going to call get
40:45
program account uh for a specific program ID
40:51
which in our case is the program ID we have right here
40:57
or we have loading up from the IDL and this function will essentially
41:03
return the array of all the accounts that are associated with our program ID so what we're going to do with this
41:11
array uh let's just map it so we can work with all of
41:19
the Y so we can so we can work with each
41:24
of the items separately so we have a map let's create an async
41:30
function here again and we're going to call bang so we have reference to all of the uh all of the items that are in The
41:38
Returned
41:46
array let me fix up the typo here yep
41:52
uh so now uh we have the array of our of the accounts associated with our program
41:58
ID and what we want to do with each of the account we want to call another
42:03
await function because uh we have a reference to the to all of the accounts
42:09
but we need to fetch more info from that account so what we can do here is
42:15
called [Music] program-
42:20
account bank comma fetch
42:26
and we're going to fetch the data for that specific account or in this case
42:31
we're going to be fetching data for all the accounts that been returned uh or
42:37
found for our program ID so we want to fetch the data for what we want to fetch
42:42
the data for the pup key of each bank so we can call bank. Pup
42:55
key so yeah that's essentially our function
43:01
here uh what we going what we're going doing here is fetching all of the accounts and then uh running through all
43:09
of them and fetching the data of each of each of these accounts that been
43:14
returned so after all this promise is complete uh let's just print them out
43:20
into the console so we can call then uh have a reference to the bank
43:29
Al so for each uh sorry we can call it Banks probably
43:39
better and what we're going to do with the banks here we just going to log it out into the console for now but we
43:47
probably want to display it on a UI level so let's just handle the error
43:52
first so we're just going to lock um error while
44:00
getting the banks in case this one fails out but what we want to do here is not
44:07
just log it into our console we probably want to uh displayed on the UI level so
44:14
uh in our return function function so let's just uh create a new
44:20
state we're going to call it we're going to call it m
44:26
Banks set
44:32
Banks use State and let's just set the
44:39
banks to the array array we are getting here so that means set Banks to
44:47
Banks so yeah uh we have uh we have our
44:53
create Bank we have our get Banks where we are getting all of the accounts associated with our program ID after
45:00
that for each uh account or for each PDA we are fetching the data from that
45:06
particular account so we can read the name the balance the owner after we have
45:12
all of these requests done and we have all of the necessary data for each of the accounts we are sending it to our uh
45:19
Bank state that we're going to render out or we're going to render out this array in our return function
45:26
so that's pretty much it for the get Banks uh function the last thing we're
45:32
going to need or sorry we have so oh sorry I made a typo
45:40
here make sure your specifi it's going to be an array or a type of an array so
45:46
we should be good now so the last thing that we need we
45:51
need some uh way to actually deposit the money to all of the banks uh that our
45:58
program have or all the banks uh that are available for our
46:04
program so let's continuing uh implementing the last function that we need in our case and that is depositing
46:10
some salana in our bank so let's just start calling it Deposit Bank which will
46:16
be another asynchronous function and what we going to do here is essentially
46:23
the same process we have done uh during the bank's creation but right now we're
46:30
going to just uh instead of calling the create function we're going to call the
46:35
deposit function uh for that we're going to need
46:41
a public key argument this one will be the PDA of the bank where we going to
46:47
deposit because uh it is expected to be supplied as one of the accounts for our
46:53
deposit function but the process here is extremely similar so we just going to
46:59
create another TR catch block and we can pretty much copy what we have implemented in the create Bank we're
47:05
going to need the anchor provider and we're going to need the program
47:12
again so here we're not creating any of the pdas so we can just go straight
47:19
ahead and call the deposit function and the structure is the same
47:25
we just going to call AWA program uh program
47:31
RPC and instead of calling create we going to we're going to call deposit so a
47:39
program RPC deposit and there are some arguments for
47:47
our deposit function just like for create function so we can just go ahead and reference our IDL
47:53
file and we can find our deposit function we now know that we need to
48:00
supply three different accounts the first account is the bank the second
48:05
second account is the user and the third one is the system program so the bank
48:11
will just be the public key of the bank that uh or or the or the public key of
48:18
the PDA where we're going to actually deposit the money and also there is one argument we
48:25
need to Supply and that argument is an unsigned 64-bit integer amount or the
48:32
amount that we want to deposit which in this case is in lamp ports so we're
48:38
going to do it right here we need to pass that one argument and we can do it by calling new BN which is the big
48:46
number uh we are importing that from uh from the an from the uh project serum
48:52
anchor library and here we can specify uh how much how much salana we want to
48:59
transfer so let's just say we want to transfer uh one
49:06
salana and uh be aware that our argument is in
49:12
lamp ports so we need to say 0.1 and we need to multiply it by lamp ports per
49:21
salana and we can do it manually or we can reference
49:26
three lamp ports per Soul so by doing that we are specifying
49:33
the first argument and the first argument is the amount that we want to deposit which is hard corded for 0.1
49:42
Soul right now but you can obviously customize it as much as you want and the progress is the same as with the
49:49
creation right now we need to supply uh the accounts so we will create a object
49:56
this object will contain another object called
50:05
accounts and this object will contain all of the accounts we need to specify
50:11
for this function to execute so the first one is the bank which will be the
50:16
public key or the parameter for our function here it's the public key for the PDA where we depositing it where we
50:24
depositing so we have public Key Bank another one it's the user and here
50:31
the process is exactly the same we need the public key of the user and we need the reference to the system program ID
50:38
so let's just copy it right here and we're good to go
50:44
so let's just print out some uh lock to the console let's just
50:52
say deposit done and to what bank it's the public key so
51:00
that's the address of the PDA and in case we have some issues let's just
51:05
handling handle it for now by showing eror error why depositing depositing we
51:12
can just we can switch it to error so it is
51:19
uh visible in the console
51:25
and yeah essentially now our logic or all the functions that we need to interact with our program is pretty much
51:32
done so now we just need to customize the interface uh that we're going to present
51:38
to the user so let's just run it back a little bit uh we have the first one that
51:44
we've created is the provider this one is specifying the anchor provider the anchor provider
51:51
needs to know some particular in information to actually connect to the cluster and interact with the program so
51:58
we need to supply three things we need to supply the reference to the connection in this case where we're
52:05
using the salana scaffold we can use the use connection function or use connection reference we
52:13
also need to reference the user's wallet connection which is the connection to the uh to the wallet or to the browser
52:21
extension put it simply so we can call use wall wet here so we just passing the
52:26
reference to use wallet and we also need to specify the network and the wallet
52:33
uh uh we also need to specify the default options for the confirmation so
52:39
we're doing it by supplying anchor provider uh-h default options but we can
52:44
customize it as much as we want and after that we're just returning the provider in this
52:50
function the first thing we're doing is to create bank so we're essentially fetching the provider and we're also
52:57
creating a reference to our program the reference to our program can be created
53:03
by passing the IDL that we have copied over from our anchor project so it can
53:09
it it needs to be an IDL object which is essentially an object created from the
53:15
Json that we have passed we need to specify the program ID we can do it
53:21
by uh by specifying the public key we have created from our IDL the address is
53:29
inside our IDL as a metadata address and the last thing we need to
53:35
have the program reference is sending up the anchor provider so by doing that we have our
53:43
provider to communicate with our program and we also have a reference to our
53:48
program in this case where we are interacting with the PDA before we
53:54
actually call the create function here we need to find the address for our PDA
54:00
we can do that by calling find program address sync to find the PDA we need to
54:08
specify two things because we already know how to uh find the PDA or we know
54:13
the logic behind it we need the program ID which we are supplying as the second
54:19
parameter and the first parameter is the array of the seats that are used to
54:25
generate the address in our case the address was generated from the bank
54:31
account string and from the public key of the signer or from the wallet of the
54:37
owner for that particular PDA that means uh only one or each wallet can
54:45
only have one bank because our seed or or seeds relies on the public
54:52
ID uh of of the signer or of the wallet that have found the PDA or created the B
54:58
the bank we need to find a bank because the bank is one of the accounts that we need
55:05
to supply to the actual create function
55:10
so uh we can call different function inside our program by calling program.
55:17
RPC doc create uh the first thing that we need to supply is all of the arguments that
55:24
our function needs we can reference our IDL and after that we need to also
55:30
reference an object that contains all of the accounts
55:36
that are a function needs to operate so in this case it's the bank it's the bank
55:41
reference it's the user or the public key that is calling the anchor provider
55:47
and the system program reference so essentially this is how we call the function inside our Salon
55:54
approach program for the get Banks it's even easier we don't even need to interact a
56:01
lot with our program what we're doing here is we are calling the get program
56:07
accounts and here we need just need to supply the program ID this function will
56:13
return array of all of the pdas that are associated with our program because it
56:20
can find the PDA according to the program ID after we have our array of
56:26
all of the pdas we are calling program. account. bank. Fetch and that
56:34
one will fetch the data for our bank account so we have the pop key for all
56:41
of these pdas and we need to supply this pup key to the fetch function to actually parse
56:48
our bank account after that we have array of all
56:54
of the the pdas plus we have all of the uh data that are stored in these pdas so
57:02
we can access the name the balance and the owner of the each PDA our program is
57:08
associated with after that is complete the only thing we're doing here is
57:14
logging out to the console and we're also setting up our bank state to render
57:20
it out uh on the UI and I don't need to uh re explain the
57:25
deposit function or or the deposit Bank function because it's pretty much the similar thing as with the create but
57:32
instead of create we're calling deposit and our first argument is the
57:38
amount that we want to deposit so in this case it's just hardcoded 0.1
57:47
Soul so now when we're happy with the implementation we need to uh fix up our
57:54
uh our return here or what is actually rendered on the
58:01
page so let's just erase the button I have prepared some examples here so
58:09
let's just fix up let's just fix up our page
58:19
here we're going to add an empty element here because that one will contain more
58:25
the elements or more child elements and the first thing we need here is the
58:30
create Bank button so let's just add that one here
58:36
and this is essentially just a a button that says create bang and on click it
58:43
will call our create bang bang function another button that we want is the fetch
58:49
Banks button so essentially the same thing so let's just add it right
58:55
here it will say fetch buttons but instead of calling create Bank it will call get Banks uh
59:02
function so after we actually fetch the banks we now need to display them so how
59:09
we going to display them uh we know we have all of the bank uh data stored
59:14
inside our state here so we need to Loop or map this state or this array that is
59:20
stored in the state this array that contains all of the uh all of the uh
59:26
pdas and their Associated data we have
59:31
fetched we can just put it right
59:39
here and we going to do it by calling uh give me a second let's just wrap it into
59:46
an empty element so we can put more element elements
59:53
here and let's just do uh
59:59
Banks Das map and we're going to map our banks
1:00:06
here and for each
1:00:12
Bank sorry some issues with my keyboard and for each Bank uh we're
1:00:20
going to do some processing so in our case
1:00:25
it's going to be we're going to return a new
1:00:33
element and let's just copy some of the Styles over so I'm going to create a new
1:00:40
div here for each bank so we have a div here and what
1:00:48
we're going to print out is for example one
1:00:53
uh here we can access the
1:00:59
bank and here we can access all the fields that are stored uh sorry just
1:01:05
call it bank and here we can access all the fields that are stored in each bank
1:01:10
account so uh we have a name there let's just convert it to
1:01:22
string so this will print out the name of all of the banks inside the array and
1:01:28
the other thing that we want to do is adjust the detail and that will be the
1:01:34
balance so instead of printing out the name we're going to print out the balance make sure we're going to also
1:01:41
convert it to string because instead it will just print out the object so that will make no sense and the last thing
1:01:48
that we need for each bank is the deposit button so I've created the the deposit button in advance
1:01:55
so we can just paste it right here and it's pretty simple it's
1:02:02
essentially the same button that we have for create and fetch Banks but instead this one is calling the deposit
1:02:08
Bank function and also supplying a pup key parameter which is the pup key of
1:02:15
the bank that we want to deposit to so now we're essentially good to go
1:02:23
so let's just format add it a little
1:02:28
bit save it up and try to run it if we're lucky we're going to be good to go
1:02:36
we run the app the app should look like uh the app that I showed before so if we
1:02:41
jump into the basics tab we can see that we have salana Banks and we have two
1:02:46
functions that we can call it's to create and fetch Banks so I can create a bank I can approve it and that will
1:02:54
create a bank for me you will have your result in the console and I can also fetch the banks so I can immediately get
1:03:02
all of the pdas that are associated with my account just to test it out uh let me
1:03:08
switch out or create a new wallet so let's create new
1:03:14
wallet I'm going to call it account three we have a new account we have some
1:03:22
s because it's in a test net mode but let's jump back into our
1:03:28
app select or connect the wallet again we going to call collect to a new wallet
1:03:34
that we have just generated jump into the basics fetch the banks you can see
1:03:39
that I already have one bank but I can create another one because I right now I'm interacting as a different user so
1:03:46
let's just call create Bank approve this
1:03:52
one let's refresh and fetch the banks again and you can
1:03:57
see I have two Banks Now One bank is owned by my prevor previous wallet and
1:04:04
this this bank is owned by my new wallet that I have generated right now so we
1:04:10
can just go ahead and switch back up to our first
1:04:17
wallet fetch the banks again and deposit to the bank that was created by a
1:04:22
different user so let's just deposit 0.1 Soul approve
1:04:30
it refresh our app fetch the banks and you can see that the PDA uh for that
1:04:37
particular Bank received the money and it is showing the balance right now so this was pretty much the basics
1:04:45
how to create a simple UI for your salana program so you're not just uh
1:04:51
limited by creating uh test but you can just deploy to a defet at any time write
1:04:57
a really simple UI and test your program that way because the really nice thing
1:05:03
about it is you can just host your UI to any hosting solution and you can just
1:05:08
send it out to a different user for them to test it you can download the repo
1:05:13
that we have creating during this lecture you can customize it as much as you want so just add whatever bells and
1:05:20
whistles you want uh and the most important important thing is adding a
1:05:25
withdraw button to each bank so essentially create a withdraw
1:05:31
function that will with withdraw all of the money from the PDA by calling the
1:05:38
withdraw function inside our program so the implementation is extremely similar
1:05:44
to what we have done today is essentially just few lines of code change so you just call the withdrawal
1:05:50
function and that withdrawal function will transfer all all of the funds from the PDA account to the owner's
1:05:58
account so thank you guys for joining this week of uh School of salana uh I
1:06:04
hoped you liked it and uh you understand the basics of
1:06:10
creation uh of front end for your saana programs now I will hand it over to my
1:06:16
colleague uh to give you details about our next assignment hello everyone I hope you
1:06:23
have enjoyed this lecture about building a front endend for your anchor program
1:06:28
and um I would like to congratulate you for getting so far in the school of Solana um so yeah now now you have the
1:06:36
basic knowledge to build a complete D app from from scratch and um I would
1:06:42
like you to introduce the final assignment in this case uh it will be a
1:06:47
little bit different because uh there won't be any automated tests and uh no
1:06:54
predefined program structure as as before and uh we would like you to be
1:07:00
creative so the task will be to create your own D app and uh it is entirely on
1:07:07
you what the program will do and uh yeah more creative you are the
1:07:13
better uh there will be some basic requirements however so uh we would like
1:07:19
uh that uh your program uses PD
1:07:25
and that you deploy the program on defnet uh also um another requirement
1:07:32
will be uh that you should have at least one typescript test for each anchor
1:07:38
program instruction and uh please also um
1:07:44
include also unhappy path scenario test so it means include also tests that will
1:07:53
test uh uh that you will submit uh unexpected uh data to your to your
1:08:01
instructions uh next uh requirement will be that uh your program should have at
1:08:08
least a simple front end um in ideal case deployed using your preferred
1:08:15
provider so we can uh check the result easily and uh yeah don't worry so we
1:08:22
will not create the the visual aspects so we just want to see that uh you are able to create a front end uh that can
1:08:30
be used with your program and uh yeah as we will be uh
1:08:37
kind of um reviewing your projects manually and there won't be any
1:08:42
automated tests we would like you uh to include a short readme file um where you
1:08:51
should include a brief description of your project so you know how it works
1:08:56
what is uh what is the main purpose of your project and uh if you succeed to
1:09:02
deploy your anchor program and your front end uh then uh just include also
1:09:08
the link where we can see the result in action and uh in any case please uh also
1:09:16
uh include a short how to um how to build and test your anchor program
1:09:21
locally uh and uh how to run the frontend app locally especially if you
1:09:29
are using any uh you know um unusual uh
1:09:34
things so that we don't have to reverse engineer your your
1:09:39
project so yeah we know that it is quite some work to be done so you will have
1:09:45
two weeks to complete this assignment hopefully it will give you enough time
1:09:50
if you have any difficulties and uh as always do not hesitate to ask on
1:09:57
Discord and one last thing so the school is not yet over next week you will have
1:10:02
a lecture about security of anchor programs uh so uh yeah be sure to review
1:10:10
your program for major security issues and uh finally we'll also have a
1:10:16
bonus lecture uh that will be a little bit more advanced where we will show you
1:10:22
how you can write a fastest for your anchor program and uh yeah uh again uh you will
1:10:31
find any further instructions about the task on Discord do not hesitate to ask there if
1:10:39
anything is not clear and uh yeah thank you for today uh have fun with the final
1:10:46
task and uh be creative goodbye

0:00
大家好欢迎来到今天Solano学校的另一场讲座呃
0:06
我们将讨论您的 salana D 应用程序的前端，因此这将充当
0:12
简要介绍如何为您的 salana 程序创建一个简单的前端呃我们将把我们的程序部署到
0:20
defet，我们将使用其 GitHub 存储库上的 salanascaffold 来启动我们的
0:27
项目所以请记住，这是一个简短的介绍，这是一个非常复杂的主题
0:33
呃，与萨拉纳计划相比，现在完全是另一个世界，所以我们
0:39
将仅介绍有关如何设置呃或如何设置的基础知识
0:44
只需几分钟即可轻松为您的应用程序构建前端，作为演示，我们将使用我们的
0:52
我们在上一讲中创建了银行应用程序，所以本质上我们将创建一个简单的
0:59
用户呃可以呃使用他在中使用的默认钱包的界面
1:06
浏览器与我们的程序以及所有相关的 pda 进行交互
1:13
我们的程序的基本功能是创建 PDA 的某种形式
1:18
帐户然后是银行本身的创建呃在我们准备好之后呃我们
1:24
将确保我们能够列出所有创建的银行
1:30
这意味着我们基本上会获取所有与
1:36
我们的程序，我们将在我们的应用程序中将它们与名称一起显示
1:41
银行和银行当前余额我们还会添加存款功能
1:48
因此，对于我们前端列出的每家银行，我们都会有一个存款按钮
1:53
如果用户点击那个，它将存入 0.1 所以到那个特定的
1:59
银行，所以我们将实施除提款之外的所有这些内容
2:04
功能，但从您在今天的讲座中看到的所有内容中，您将能够
2:09
自己在前端实现 Widraw 功能，所以在开始之前我们将
2:16
与来自 salana 实验室的一个非常有趣的存储库进行交互
2:21
将是 DAP 支架，这将帮助我们快速创建我们的应用程序，所以
2:27
它本质上会启动您的项目，因为所有钱包交互逻辑都已经实现
2:34
所以我们将下载此存储库的内容，或者我们将克隆此存储库，然后我们将在其之上构建
2:41
所以我们要添加到这个脚手架的本质上只是稍微修改一下 UI，我们将保持原样
2:48
是，但我们不需要添加已经在脚手架中完成的钱包连接器，但您显然可以创建一个
2:55
空白反应项目并在那里实现所有钱包逻辑，但我们的时间是
3:01
这里有限，所以我们将使用脚手架，我们将只是我们将只是
3:07
添加一些不同的组件，以便我们可以与我们的程序交互，所以在我们之前
3:12
开始吧，呃，不再演示了，让我们直接开始吧，呃，编码，我们将从
3:19
克隆此存储库，因此在我们接触任何前端之前，请确保我们将部署或
3:26
确保您将程序部署到例如 defnet 呃，这个过程与我的非常相似
3:32
上一讲中描述了有关部署到本地集群的内容，但在本例中将仅部署到
3:39
defet 以便所有连接到 defet 的钱包都可以公开访问我们的程序
3:46
集群，所以我们将从我们在之前创建的项目开始
3:52
演讲完毕，让我们开始吧。 也并确保在提供者中
3:57
我们的集群设置为 defet 并且我们的钱包已设置
4:02
至/ ID。 杰森
4:07
Json 和钱包有一个很好的理由呃我们将创建一个新的 keare，我们将用它来部署
4:14
我们的程序这个呃地址将是呃你的程序的更新
4:20
权限所以呃让我们从创建呃开始
4:25
从创建新的 Keir 开始，我们可以通过调用来做到这一点
4:32
salana keyen new，我们需要指定 keare 的输出，在此
4:37
case 只是 ID Json 确保您位于项目的路线中
4:42
目录，或者您可以在其他任何地方生成键盘，但您只需要指定该键盘的路径
4:50
您已经在锚点中创建了。 电话所以让我们运行键控器
4:55
生成，我们在这里有一些 PP 密钥，我们可以看到 ID Json 已创建
5:00
在我们项目的根目录中，我们现在要做的是复制我们的 POP 密钥，因为在我们之前
5:08
实际运行部署呃我们需要呃或者我们需要在这个特定帐户中有一些余额
5:15
用于部署，所以我们需要运行空投，所以让我们打电话
5:22
salana salana 空投指定了您想要空投的数量
5:29
并添加钱包PP密钥或我们刚刚的钱包的PP密钥
5:34
创建后，让我们将 salana 空投称为 1，我们可以看到我们进行了交易
5:41
我们的帐户中有一个灵魂，现在让我们再播一些，我们有两个灵魂，让我们一起吧
r 滴
5:47
还有一些你可以看到这个这个请求失败了呃别担心呃它
5:53
如果您对空投有一些问题，有时会失败，请尝试为空投指定较低的金额
6:00
或者稍后再试一次，或者在空中之间有不同的延迟再试一次
6:06
空投你正在运行的空投所以让我们空投至少三到四个灵魂到我们的呃部署
6:13
帐户所以现在我们有四个灵魂，我们已经准备好部署呃
6:18
在我们实际部署之前，让我们调用 Anchor build 并重建我们的项目，如果
6:26
在我们进行实际部署之前，一切都很好，因为您可以期待
6:31
在部署过程中，您将花费一些已播出的萨拉纳
6:37
掉落所以这需要一些时间
6:44
现在我们的构建已经完成了，一切都很顺利，我们正在
6:50
非常适合部署，所以我们称之为 Anchor 呃部署，本质上只是
6:56
一个命令将运行整个部署过程，只需确保您已指定集群
7:02
您已指定将用于部署的钱包路径，并确保
7:08
特定的钱包中有足够的 salana 来实际运行部署过程，所以让我们进行锚定
7:16
部署呃我们看到我们有升级权限这里我们有部署
7:21
工作区，这是我们在 salana CLA CLI 中的 RPC，我们可以看到
7:27
我们正在 bda 上部署程序，并且有一条通往该特定程序的路径
7:34
部署呃你可以看到它正在通过事务运行所以
7:39
呃让它完成部署完成后我们将获得我们的程序ID或
7:46
现在驻留在 def 上的程序的 ID
7:55
net 所以现在我们已经完成了事务，您可以看到我们的部署成功了并且我们有了我们的
8:02
我们将使用的程序 ID，如果您有任何问题
8:09
部署确保您的帐户上有足够的 salana 呃
8:14
因为如果您没有足够的 salana 来满足所有需求，它可能会像在部署中间那样失败
8:20
交易要完成，因此如果是您的情况，请再次执行空投流程或再试一次
8:28
稍后，现在呃，当我们的部署成功时，还有另一个重要的事情
8:34
锚点在实际构建过程中为我们生成的信息，所以
8:41
如果您查看我们的项目文件夹中的目标文件夹，您可以看到
8:46
有一个 IDL 文件夹，并且 IDL 文件夹包含一个 Json 文件，该 Json
8:52
就呃前端而言，文件对你来说真的很重要
8:58
开发，因为如果你检查你的 IDL 文件，它本质上是一个映射
9:03
您的程序正在使用的所有功能和所有帐户以及
9:09
您还可以看到您部署的程序有一个地址
9:15
可以看到地址匹配，你将使用这个 Json 来
9:22
在 JavaScript 或 Typescript 端有一个程序结构，这样你
9:27
你的salana呃你的JavaScript或打字稿程序知道你的
9:32
salana 上的实际程序看起来以及您将如何与所有不同的人互动
9:37
在我们开始讨论之前，不同账户的功能以及结构如何
9:44
呃前端开发请确保将此呃 Json 文件复制到例如
9:52
您计算机上的任何文件夹，或者因为我们会将此 Json 文件复制到我们的
9:58
呃桌面程序在某些情况下呃你想创建一个单一的回购协议
10:05
这意味着您将拥有前端和 salana 程序。
10:10
在这种情况下，存储库可以在 salana 中创建一个新的 React 项目
10:17
程序目录，但在我们的示例中，我们将使用 salana D 应用程序脚手架
10:23
所以我们将有一个单独的项目，所以我们需要确保我们的 IDL 文件是新的
10:30
我们将合作的项目也请务必记下您的程序 ID
10:36
虽然你的 IDL 中提到了
10:41
文件，所以现在我们在一个不同的项目中，你可以看出我们在一个 dab 脚手架中
10:47
嗯，来自我提到过的 git rap git 存储库，所以让我们从
10:53
实际上运行我们从 git 存储库复制的项目，我们可以通过首先运行 npm install 来做到这一点
11:01
将安装项目的所有依赖项，您可以在 package.json 文件中查看依赖项
11:09
但是呃你们大多数人已经是 JavaScript 或者
11:15
打字稿开发人员，所以你可能知道这一切是如何工作的，我不会详细介绍，但是在你完成之后
11:22
安装完成后，我们可以使用 npm 运行项目
11:27
runev 所以让我们这样做并检查一下应用程序的外观，以便
11:36
你可以看出它设计得非常好，它基本上已经准备好了
11:42
您需要进行大量的定制或导入或添加您的程序功能，以便
11:49
我们可以修改尽可能地对其进行说明，这对您来说是一个很好的起点，您也可以打电话
11:56
npx create salana dab 这将创建一个新的 uh 这将创建一个新的
12:01
只需使用一个即可为您提供样本
12:09
命令所以在继续之前我们还要确保我们有 salana 钱包
12:14
安装在我们的浏览器中我相信你们中的大多数人已经这样做了，在我的情况下我将使用
12:20
幻影所以让我们登录所以呃我在我在幻影中
12:29
你可以看出我有 Phantom beta，所以我这里也有以太坊，但我没有
12:34
知道这真的取决于你，这个过程与所有 Phantom 版本非常相似，所以你也可以看到
12:43
我目前处于测试网模式呃我建议你进入测试测试
12:48
网络模式，因为你可能会遇到一些问题，我们可以通过跳入 Phantom 设置来做到这一点
12:57
进入呃开发 Vel 操作设置并在此处启用测试网络模式呃这将
13:02
本质上，根据您的钱包将与您的钱包通信的 RPC 切换到定义网或测试网
13:10
设置，所以让我们确保我们现在在本地主机上运行的 dab 正在连接到我们的 Phantom
13:23
钱包，正如你所看到的，它目前连接到我的钱包
13:29
所以呃你可以说你有一些巴斯你实际上可以选择
13:35
请求空投，所以如果我们点击它，呃，它可能会失败，但我们可以尝试一下
13:41
再次，它会在我们之前请求空投到您的呃浏览器的钱包呃
13:47
实际上继续确保您在浏览器中的钱包上有一些灵魂，因为我们需要确定
13:56
你有一些灵魂可以与你的实际程序进行交互，所以在我们继续之前空投至少一两个
14:02
还有一个基础知识，你可以看到它有点
14:08
对我来说和对你来说有点不同，因为我创造了这个，呃，我创造了这个
14:13
我们的萨拉纳银行计划样本，以便您可以看到我们将取得的进展
14:20
或者我们的呃轻拍看起来像这样，我们将有一个创建银行按钮，我们
14:26
将有一个获取银行按钮，因此如果我单击创建银行，它实际上会初始化 PDA 并创建一个新的呃
14:34
在我们的 salana 程序中的 Bank，我们还有一个 fetch Banks 按钮，如果我们点击 fetch Banks 按钮，这将
14:41
调用我们的程序或者基本上只是列出所有的 pda
14:46
与我们的程序相关联，因此如果不同的用户创建不同的银行，您应该会看到所有这些银行
14:52
就在这里以及与我们的计划或每个相关的每家银行
14:58
与我们的计划相关的 PDA 我们也有 0.1 的押金出售给这个
15:04
特定的银行帐户，因此如果我单击此存款按钮，它应该初始化
15:10
该交易将向该特定银行的 PDA 发送 0.1 灵魂，如果我
15:16
单击“批准”交易应该完成，所以让我们重新刷新一下
15:22
页面并再次调用 fetch Banks ，您可以看到银行余额
15:28
增加，所以这个显示在灯端口中，但它本质上说 0.2 灵魂
15:34
这家银行有两笔存款，所以让我们继续，从以下事实开始：
15:42
我们实际上会自定义这个 DAB 或这个 DAB 模板以使其进行交互
15:47
与我们的主播节目一起，让我们快速开始
15:53
修改基础页面或基础视图，所以我们将 B Basics 重命名为
15:59
salana 银行应用程序让我们删除一些我们不需要的组件
16:05
我们只是删除一些样板代码
16:10
让我们将 Bank 跳转到我们在这里创建的银行组件中
16:16
我们有一个银行组件让我们重命名该组件
16:27
在这里，我们要做的是
16:33
创建我们的银行组件该银行组件将位于应用程序的视图之一或页面之一中
16:40
所以在这个 Bank 组件中基本上会实现所有的东西
16:45
我们需要与我们的锚定程序进行交互，所以让我们删除一些样板文件
16:52
代码所以删除这个点击功能呃我们也可以有这个嗯
16:59
可以，是的，让我们删除这个函数，看看它现在的样子
17:04
只是一个简单的 salana Bap，带有一个按钮，目前已禁用，因为钱包没有
17:11
已连接，所以让我们继续吧，就像
17:17
我们将从导入一个额外的包开始
17:23
需要这个额外的包是呃项目血清 SL Anor，我们需要
17:31
这个包与锚程序交互，所以让我们关闭我们的项目并调用 npm
17:39
在呃项目血清SL安装呃
17:47
或者，这将安装我们实际与锚点交互所需的所有软件包
17:53
程序，所以我们应该做好，让我们导入一些我们需要的东西
17:59
呃要与我们的银行部门合作，所以请致电
18:04
导入，它将跟随
18:10
PACkages，我们将从呃项目血清 SL 锚导入它，这样我们就有了
18:17
我们的节目主播提供商审查了 3 个公用事业 BN（代表大数字）
18:24
还有钱包 嗯，我们真的很抱歉，我们不需要钱包来完成这个特定的任务
18:30
示例所以是的，这本质上就是我们需要导入的内容，我们需要的另一件事是 IDL 文件
18:38
之前已经提到过，所以呃让我们复制一下我们的
18:43
IDL 文件到我们的呃前端项目，所以只需复制它
18:50
你可以在这里告诉我我有我们的你可以在这里告诉我的ID IDL 文件
18:57
所以我们有我们的 Sal pda，我们的程序有所有的说明
19:03
帐户的数量以及我们需要的已部署程序的地址
19:08
这个 IDL 文件，因为我们要在这里导入它，所以让我们
19:15
说 import call it IDL from 以及我们拥有的 IDL 路径
19:26
我们已经导入了，您显然可以将其放在项目中任何您想要的位置，但我将它放在同一个文件夹中
19:31
作为这个组件，我们有 salana pd。
19:36
Json 是的，这正是我们所需要的，让我们呃也做
19:42
确保 IDL 可以作为 JavaScript 对象访问，所以你们中的一些人
19:50 下午
可能会遇到这个问题，但我将在这里直接处理它，所以我将定义我将调用的新常量
19:56
IDL 呃字符串呃这将是
20:03
Json stringify 它将字符串化 IDL，我还将添加 const IDL
20:12
对象，我们将解析字符串化的 Json，所以让我们调用
20:18
Json 解析和我们的 IDL 字符串这不是
20:24
完全必要，但当您尝试访问 IDL 或您时，它可能会为您解决一些问题
20:31
尝试在某些函数中引用它，所以我将这样做
20:36
我们也定义程序
20:41
ID 呃，我们需要将程序 ID 定义为公钥，这样我们就可以
20:46
称新为新公众
20:52
key，我们将从导入的 IDL 中获取公钥
20:59
让我们只做 IDL 对象，我们需要
21:07
元数据，我们需要地址，或者实际上呃 ID 实际上会有所帮助
21:15
如果您在此处输入 IDL，则执行元数据。 地址所以这只是
21:23
本质上是从我们在这里提供的字符串创建一个新的公钥，而我们在这里提供的 Str 来自我们的
21:30
salana pdas 文件就在这里，这就是我们拥有的程序的地址
21:35
部署到确定所以现在我们已经很好了呃让我们开始吧
21:44
从我们要实现的第一个功能开始，那就是
21：50
称为 getprovider 和这个呃函数
21:59
将返回给我们一个锚定提供者或者我们将要使用的东西
22:05
与我们的锚程序交互抱歉，它确实需要是一个异步函数，所以让我们创建一个
22:12
获取提供者，我们将继续创建一个常量
22:19
提供商，让我们调用我们从中导入的新锚定提供商
22:25
项目血清锚和锚提供者需要
22:31
提供一些我们需要在这里参考的重要信息，以便我们
22:36
需要连接，这个是 H 代表与程序所在集群的实际连接
22:43
部署这意味着我们需要从我们的钱包中获得这个连接，但是在这个
22:51
我们使用 salana daab 的特定示例我们可以参考
22:58
参考顶部栏中我们连接钱包并选择集群的实际连接
23:05
我们可以通过调用 use 来做到这一点
23:10
连接使用连接呃让我们导入使用过的
23:15
来自钱包适配器的连接反应所以我们在这里使用了钱包让我们
23:21
添加使用连接，这样我们就可以
23:26
获取所有组件中或所有组件中的当前连接设置
23:31
整个项目的页面，所以这是我们实际提供给锚点的第一件事
23:40
提供者所以这就是
23:45
连接我们需要提供的第二件事是钱包或将用于支付和签署所有内容的钱包
23:52
我们将与之交互的交易，所以让我们在这里修改我们用过的钱包，所以我们只需调用
23:59
如果我们的钱包等于使用钱包，我们将在这里提供我们的钱包，所以这将
24:07
本质上引用了当前的钱包连接，即
24:12
目前设置在我们正在使用的前端，所以呃感谢我们拥有的 salana dab
24:20
所有这些东西都准备好了，所以如果您想创建，我们可以参考它
24:25
从头开始前端你也可以这样做，但是需要更多的时间
24:32
消耗所以现在我们还需要指定呃我们还需要指定
24:39
呃最后一件事是确认选项，基本上可以使用
24:46
Anor 提供商默认值
24:52
选项所以但这基本上会告诉我们的提供商我们想知道什么
24:58
关于交易如果我们想要的话，我们正在合作
25:03
对最终交易的响应或者交易是否正在处理中或
25:10
等等，现在我们已经与我们的锚定提供商做好了准备，我们只是要
25:15
返回我们的提供者，我们将调用这个获取提供者函数
25:21
通常我们基本上会使用它来进行与我们的对象进行的所有交互
25:26
计划，但现在我们已经与我们的主播提供商做好了准备
25:33
我们需要的是呃包装或或或
25:38
示例 JavaScript 函数将代表我们内部的某个函数
25:43
salana 计划，这样我们就可以从实际的银行创建开始，这意味着如果我们
25:49
调用此 JavaScript 函数，我们将使用我们的锚点提供程序
25:55
连接到我们的程序并调用 salana 程序中的 cre create 函数，所以我们就将其称为 uh create
26:06
银行确保此功能是
26:26
异步，我们要做的是添加一个
26:32
TR catch 块所以我们确保处理所有可能发生的错误
26:38
在我们将在此处调用的实际交易期间，我们要做的第一件事就是获取提供者，以便
26:45
让我们假设 const 一个提供者，并且该提供者将引用
26:52
获取提供者，它将返回实际的锚提供者给我们，我们也
26:59
需要创建一个新程序，这本质上意味着我们需要某种形式的参考来我们的实际
27:06
salana 程序驻留在 salana 区块链上，所以我们只说 const
27:13
程序新程序该程序是对我们程序的引用，我们实施我们
27:18
正在从血清项目中进口它，我们需要提供一些
27:24
这里不同的事情我们需要提供 IDL 完整的 IDL 我将提供
27:30
对于那些用打字稿写作的人来说 IDL 对象这就是我的原因
27:36
创建了这个呃 Json 字符串和解析呃因为你们中的一些人可能有一些
27:43
此处引用实际 IDL 对象存在问题，但我将这样做 我将引用我的 IDL
27：50
从 IDL Json 解析的对象是我们需要的另一件事
27:57
在我们的例子中是实际的程序 ID，我们已经在这里定义了它，所以我们
28:02
从 IDL 元数据地址创建一个新的公钥，我们需要最后一件事
28:10
我们需要的是锚提供者，所以我们在之前的这里得到了锚提供者
28:16
线所以我们只是我们刚刚提到我们的锚定提供商所以现在我们几乎呃有一个
28:23
参考我们关于 salana 的计划，但在我们真正打电话给我们之前
28:29
在我们的 salana 程序中创建函数，我们需要确保我们已经创建了一个
28:34
我们银行的新 PDA 呃，我们可以很容易地做到这一点，所以
28:41
让我们创建一个新帐户，我们将其命名为
28:48
银行，让我们打电话给公众等待
28:53
键，现在我们要查找程序地址
29:01
同步会找到 或 的地址
29:06
然后我们会从我们将在此处指定的座位中找到一个 PDA 地址
29:12
可能还记得我们在萨拉纳计划中指定了某种形式的座位
29:19
所以让我们回到这里检查一下，这样我们就有了
29:31
我们这里有 PDA，我们使用银行账户字符串作为座位，我们正在
29:36
还使用用户公钥或签名者公钥作为另一个席位
29:42
我们将用它来生成 PDA，所以我们要做的是
29:48
我们本质上只是说我们想根据我们将提供的一些座位找到地址
29:55
在这里，我们需要提供的第一个座位是银行账户
30:01
字符串，我们可以通过从项目中调用实用程序来完成
30:07
血清锚包受到 UTF 的攻击
30:12
string 并调用我们想要使用的字符串的 incode，在我们的例子中是
30:19
银行账户那是第一个座位呃我们是
30:25
用于生成 RP da 另一个是用户的公钥
30:33
这实际上是在创建这个 PDA，我们可以很容易地做到这一点，我们只需调用
30:39
我们的主力提供商可以访问钱包，我们希望公众能够访问
30:47
缓冲区的关键，所以现在我们已经指定了两个
30:55
我们需要的座位，但用于实际 PDA 创建或实际查找
31:01
PDA 我们还需要指定最后一件重要的事情，那就是实际的
31:07
我们已经部署的程序的程序 ID，我们可以通过以下方式做到这一点
31:14
调用呃我们可以通过调用程序引用我们的程序并调用来做到这一点
31:21
程序 ID 所以我们在这里所做的是
31:26
其实根据这里的种子找到地址
31:32
根据程序 ID uh 或 ID，因为 PDA 是从
31:39
座位和节目 ID 碰撞会自动添加到这里，所以我们有 F
31:46
现在我们的银行帐户，我们可以在程序中调用实际的创建函数了
31:53
因为现在我们有我们的银行，我们可以将其作为一部分提供帐户的背景
31:58
特定的创建函数，所以我们调用权重程序
32:07
RPC create 这里我们调用create，因为它是我们想要的函数
32:13
在我们的例子中调用的是 create，如果我们查看 create 函数，我们会发现
32:19
需要提供三个不同的帐户，即我们创建的银行 PDA
32:24
这里我们还需要用户，我们还需要引用系统
32:30
程序，这里非常简单，所以创建函数有一个
32:37
参数或一个参数，该参数称为名称，它是一种类型
32:43
字符串，所以它是我们创建的银行的名称，我们正在创建我们
32:49
可能知道从上一讲我们添加了一个参数，那就是我们想要调用的名称
32:54
这个参数就在这里，或者我们想在这里向应用程序提供这个 par 参数，所以让我们
33:00
打电话给萨拉纳银行冬季学校 是的，这就是我们银行的名字
33:07
这是其中之一，这只是我们需要调用的另一个参数，我们需要提供
33:13
这是我们需要的所有帐户或全部
33:19
在执行过程中我们将与之交互的帐户
33:25
函数，所以让我们创建一个新对象，该对象将拥有关键帐户
33:31
帐户，这将是另一个对象，在这里我们提供所有
33:38
我们在创建上下文中指定的帐户，即银行用户
33:44
和系统程序，所以我们首先需要的是我们找到的银行
33:50
在这里使用 F 程序地址同步找到我们的 PDA 帐户，另一个是
33:56
将创建此银行帐户的用户或签名者，我们可以使用以下命令再次访问它
34:03
我们的锚定锚定提供商或锚定提供商通过致电
34:09
钱包 Dash 或 dashu key 几乎是同一件事
34:16
我们在这里调用我们只是不需要它在缓冲区中，但我们也在这里调用它来找到这个特定的 PDA
34:22
调用银行创建的用户，因此我们提供用户和最后一个
34:28
我们需要的是系统
34:33
程序，因此我们有系统程序，我们可以通过提供字符串手动引用系统程序的程序 ID
34:42
或者提供公钥，但我们可以通过调用 VB 3 Das System 来完成
34:52
程序 Dash 程序 ID
35:00
所以现在我们几乎在我们的 salana 程序或我们的 salana 锚中调用该函数
35:06
程序，因此我们正在根据我们的设置等待确认
35:12
这里我们使用默认选项，因此它正在等待确认或等待
35:19
终结呃所以如果我们把一些东西呃放在等待后面或实际后面
35:25
调用 让我们调用console.log，我们将
35:31
打电话呃哇新银行是
35:38
创建完毕，让我们打印出该地址或 PDA
35:46
特定的银行，让我们说银行。 到
35:51
字符串，以便在此处打印出我们的 PDA 帐户的地址
35:57
我们有这个，如果其中任何一个失败或者在执行过程中出现一些问题，我们可以在
36:05
catch 块，所以我将在创建时执行一个非常简单的呃错误
36:13
银行所以我们可以这样做
36:18
我们很高兴与我们的创建银行功能一起使用，所以这是个好消息
36:24
所以我们有我们的创建银行让我们再次运行它我们正在获得我们的锚定提供商我们正在创建一个
36:30
通过提供我们调用的程序的 IDL 来引用我们的程序
36:36
程序 ID 并为此参考设置锚定提供商 之前我们可以
36:44
调用创建函数，我们需要找到 PDA 的地址，我们可以这样做
36:50
通过调用公钥。 查找程序寻址，它会找到一个
36:57
请确保该特定节目 ID 和供应席位的特定 PDA
37:04
这些座位与我们在锚点内指定的实际座位相匹配
37:09
程序呃，否则你将无法匹配它们，所以在我们找到之后
37:15
银行帐户 我们需要该银行帐户地址来为帐户提供该地址
37:20
对于我们实际的创建函数，我们可以使用程序调用创建函数
37:26
呃 RPC 创建我们提供银行的名称，我们还提供所有
37:34
在我们的上下文中，我们将在此函数执行期间使用的帐户的数量，如果您
37:41
在记住您需要提供哪些帐户时遇到任何问题，您需要参考您的呃萨拉纳计划
37:49
源代码或者您可以跳转到 IDL 文件，您可以查看所有这些
37:55
这里的东西，这样你就可以看到我们有银行用户系统程序和一个名为 name 的参数，所以我们有参数
38:02
这里和这里的所有帐户，所以这将调用实际的
38:07
执行该函数，执行完成后我们只是打印到控制台哇我们
38:13
创建了一家新银行，我们还为您打印呃 PDAr
38:19
银行，万一执行过程中发生什么情况，我们可以在 catch 中捕获它
38:25
阻止所以是的我们已经成功创建了创建银行功能所以
38:31
让我们继续实现更多，呃，我们的 UI 中还需要有另一个重要功能
38:39
这是创建的所有银行的列表，所以这个功能是什么
38:45
本质上要做的就是找到与我们相关的所有 PDA
38:52
程序找到所有这些地址后，我们需要获取内容
38:57
这些帐户的名称，或者至少我们需要知道银行的名称，我们需要知道实际的余额是多少
39:04
银行，我们还可以选择获取所有者的地址
39:13
hpda 所以让我们继续创建我们的 fetch 或 get Banks 函数
39:22
我们可以称之为“获取银行”，这个过程非常复杂
39:27
类似，所以它将是一个 ASC
39:37
方法，我们将再次开始获得我们的锚点
39:49
通过调用 get provider 来获取提供商，这样我们就有了我们的锚定提供商，我们也可以
39:56
可以复制我们程序的参考，这实际上取决于您我们如何构建它，但我
40:03
只需将其复制到此处，然后创建另一个 TR catch 块，以便我们可以处理不同的
40:12
异常，我们将从调用 Promise 开始
40:18
呃，因为我们现在要在这里串联出承诺，第一个是
40:25
呃，调用连接不是锚点而是实际连接，我们是
40:31
不是锚连接，而是我们 UI 中的连接，所以
40:39
我们要调用 get
40:45
特定程序 ID 的程序帐户
40:51
在我们的例子中，这是我们这里的程序 ID
40:57
或者我们从 IDL 加载，这个函数本质上是
41:03
返回与我们的程序 ID 关联的所有帐户的数组，那么我们将如何处理它
41:11
数组呃，让我们映射它，这样我们就可以处理所有的
41:19
Y 这样我们就可以与每个人一起工作
41:24
单独的项目，所以我们有一个地图让我们创建一个异步
41:30
再次在这里运行，我们将调用 bang，这样我们就可以引用 The 中的所有呃所有项目
41:38
回
41:46
数组让我修正这里的拼写错误是的
41:52
呃，现在呃，我们有了与我们的程序关联的帐户数组
41:58
ID 以及我们想要对每个要调用的另一个帐户执行的操作
42:03
等待函数，因为呃我们有对所有帐户的引用
42:09
但我们需要从该帐户获取更多信息，所以我们在这里可以做的是
42:15
名为【音乐】节目——
42:20
帐户银行逗号提取
42:26
我们将获取该特定帐户的数据，或者在本例中
42:31
我们将获取所有返回的帐户的数据，呃或者
42:37
找到了我们的程序 ID，因此我们想要获取我们想要获取的数据
42:42
每个银行的 pup key 的数据，以便我们可以致电银行。 小狗
42:55
关键所以这本质上就是我们的功能
43:01
呃，我们要做的就是获取所有帐户，然后呃运行所有帐户
43:09
并获取每个帐户的数据
43:14
返回，所以在所有这个承诺完成之后，呃，让我们把它们打印出来
43:20
进入控制台，这样我们就可以调用然后呃有银行的参考
43:29
所以对于每个呃抱歉我们可以称之为银行
43:39
更好，我们要对这里的银行做什么，我们现在只是将其登录到控制台，但我们
43:47
可能想在 UI 级别上显示它，所以让我们处理错误
43:52
首先，我们要锁定 um 错误
44:00
联系银行以防万一失败，但我们在这里想做的不是
44:07
只需将其登录到我们的控制台，我们可能希望呃显示在 UI 级别上，所以
44:14
呃在我们的返回函数中所以让我们呃创建一个新的
44:20
说明我们将称之为 m
44:26
银行集
44:32
银行使用 State，我们只需设置
44:39
银行到我们在这里得到的数组数组，这意味着将银行设置为
44:47
银行所以是的呃我们有呃我们有我们的
44:53
创建银行，我们有我们的获取银行，我们在其中获取与我们的程序 ID 关联的所有帐户
45:00
对于每个呃帐户或每个 PDA，我们都从中获取数据
45:06
特定帐户，以便我们可以在获得后读取所有者的余额
45:12
所有这些请求都已完成，我们拥有每个帐户的所有必要数据，我们将其发送到我们的呃
45:19
银行声明我们将渲染出或者我们将在返回函数中渲染出这个数组
45:26
这就是 get Banks uh 函数的最后一件事了
45:32
需要或者抱歉我们有所以哦抱歉我打错了
45:40
在这里确保您的指定它将是一个数组或数组的类型，所以
45:46
我们应该现在很好，我们最不需要的就是
45:51
需要一些呃方法来实际将钱存入所有银行呃我们的
45:58
程序有或所有可用于我们的银行
46:04
程序所以让我们继续呃实现我们的例子中需要的最后一个功能，那就是存款
46:10
我们银行里有一些salana，所以我们就开始称它为存款银行吧
46:16
是另一个异步函数，我们在这里要做的本质上是
46:23
与我们在银行创建期间所做的流程相同，但现在我们正在
46:30
呃，我们不调用 create 函数，而是调用
46:35
我们需要的存款功能
46:41
公钥参数，这将是我们要去的银行的 PDA
46:47
存款，因为呃，预计将作为我们的帐户之一提供
46:53
存款功能，但这里的过程非常相似，所以我们只是
46:59
创建另一个 TR catch 块，我们几乎可以复制我们在创建 Bank 中实现的内容
47:05
需要主播提供商，我们需要该程序
47:12
再次强调，我们不会创建任何 PDA，因此我们可以直接进行
47:19
提前调用存款函数，结构相同
47:25
我们只是要调用 AWA 程序呃程序
47:31
RPC，我们不调用 create，而是调用 Deposit，所以
47:39
程序 RPC 存款并有一些争论
47:47
我们的存款函数就像创建函数一样，所以我们可以继续引用我们的 IDL
47:53
文件，我们可以找到我们的存款函数，我们现在知道我们需要
48:00
提供三个不同的帐户，第一个帐户是银行，第二个帐户
48:05
第二个帐户是用户，第三个帐户是系统程序，因此银行
48:11
只是银行的公钥，呃或或或或的公钥
48:18
我们要实际存钱的 PDA，而且我们还有一个论点
48:25
需要提供并且该参数是无符号 64 位整数或
48:32
我们想要存入的金额，在本例中是在灯端口中，所以我们
48:38
在这里我们需要传递一个参数，我们可以通过调用新的 BN 来做到这一点，这是最大的
48:46
呃，我们正在从呃项目血清中导入它
48:52
锚点库，在这里我们可以指定呃我们想要多少萨拉纳
48:59
转移所以我们就说我们想转移呃一个
49:06
萨拉纳，呃，请注意，我们的论点是
49:12
灯端口，所以我们需要说 0.1，并且我们需要将其乘以每个灯端口
49:21
salana，我们可以手动完成，也可以参考
49:26
每个灵魂三个灯端口，因此通过这样做我们指定
49:33
第一个参数是我们想要存入的金额，硬编码为 0.1
49:42
现在灵魂，但显然你可以根据需要自定义它，并且进度与
49:49
现在创建我们需要提供帐户，以便我们创建一个对象
49:56
该对象将包含另一个名为
50:05
帐户，此对象将包含我们需要指定的所有帐户
50:11
为了执行这个函数，第一个是银行，它将是
50:16
公钥或我们函数的参数，这里是我们将其存放在 PDA 上的公钥
50:24
存款，所以我们有公钥银行，另一个是用户，在这里
50:31
这个过程是完全一样的，我们需要用户的公钥，我们需要系统程序ID的引用
50:38
所以我们就在这里复制它，然后就可以开始了
50:44
所以让我们在控制台上打印一些呃锁
50:52
说存款已完成，公钥是哪家银行的
51:00
这是 PDA 的地址，如果我们遇到一些问题，让我们
51:05
处理 现在通过显示错误来处理它 错误 为什么存款 存款 我们
51:12
我们可以将其切换为错误吗？
51:19
呃在控制台中可见
51:25
是的，现在我们的逻辑或与程序交互所需的所有功能基本上都是这样
51:32
完成后，现在我们只需要自定义我们将要呈现的界面
51:38
对于用户来说，让我们稍微运行一下，我们有第一个
51:44
我们创建的是提供者 这个提供者指定了锚提供者 锚提供者
51:51
需要了解一些特定信息才能实际连接到集群并与程序交互，以便
51:58
我们需要提供三件事，在这种情况下，我们需要提供对连接的引用
52:05
使用 salana 脚手架，我们可以使用 use 连接函数或使用连接引用
52:13
还需要引用用户的钱包连接，即钱包或浏览器的连接
52:21
扩展简单地说，这样我们就可以调用 use wall 我们t 在这里，所以我们只是路过
52:26
参考使用钱包，我们还需要指定网络和钱包
52:33
呃呃我们还需要指定确认的默认选项，所以
52:39
我们通过提供锚点提供者默认选项来做到这一点，但我们可以
52:44
根据我们的需要定制它，之后我们只返回提供者
52:50
函数我们要做的第一件事是创建银行，所以我们本质上是在获取提供者，并且我们还
52:57
创建对我们程序的引用 可以创建对我们程序的引用
53:03
通过传递我们从锚项目复制的 IDL，这样它就可以
53:09
它需要是一个 IDL 对象，本质上是一个从
53:15
我们传过来的Json需要指定程序ID才可以
53:21
通过呃指定我们从 IDL 创建的公钥，地址是
53:29
在我们的 IDL 中作为元数据地址，这是我们需要的最后一件事
53:35
节目参考正在发送锚定提供商，这样我们就可以得到我们的
53:43
提供商与我们的程序进行通信，我们也有一个参考
53:48
在这种情况下，我们先与 PDA 进行交互，然后再进行程序
53:54
实际上在这里调用create函数我们需要找到我们的PDA的地址
54:00
我们可以通过调用查找程序地址同步来查找我们需要的 PDA
54:08
指定两件事，因为我们已经知道如何找到 PDA 或者我们知道
54:13
其背后的逻辑我们需要我们提供的第二个程序 ID
54:19
参数，第一个参数是用于的座位数组
54:25
生成地址，在我们的例子中，地址是从银行生成的
54:31
帐户字符串和来自签名者的公钥或来自签名者的钱包
54:37
该特定 PDA 的所有者，这意味着呃只有一个或每个钱包可以
54:45
只有一家银行，因为我们的种子依赖于公众
54:52
找到 PDA 或创建 B 的签名者或钱包的 ID uh
54:58
银行 我们需要找到一家银行，因为该银行是我们需要的账户之一
55:05
提供给实际的创建函数
55:10
所以呃我们可以通过调用program.在我们的程序中调用不同的函数。
55:17
RPC 文档创建呃，我们需要提供的第一件事是所有参数
55:24
我们的函数需要我们可以引用我们的IDL，之后我们还需要
55:30
引用包含所有帐户的对象
55:36
这是一个需要操作的功能，所以在这种情况下，它是银行，它是银行
55:41
引用是调用锚提供者的用户或公钥
55:47
和系统程序引用，所以本质上这就是我们在沙龙中调用该函数的方式
55:54
获取银行的方法程序甚至更容易，我们甚至不需要交互
56:01
对于我们的程序来说，我们在这里所做的就是调用 get 程序
56:07
帐户，这里我们只需要提供该函数将执行的程序 ID
56:13
返回与我们的程序关联的所有 pda 的数组，因为它
56:20
有了数组后就可以根据程序ID找到PDA了
56:26
我们调用的所有 pda 程序。 帐户。 银行。 获取和那个
56:34
我们将获取我们银行账户的数据，这样我们就拥有了所有人的流行密钥
56:41
这些 pda 的数据，我们需要将这个 pup key 提供给 fetch 函数来实际解析
56:48
我们的银行账户之后我们就有了所有的数组
56:54
pda 加上我们拥有存储在这些 pda 中的所有呃数据，所以
57:02
我们可以访问我们程序的每个 PDA 的名称、余额和所有者
57:08
与此相关之后完成我们在这里唯一要做的就是
57:14
注销到控制台，我们还设置要渲染的银行状态
57:20
它在用户界面上显示出来，我不需要呃重新解释
57:25
存款功能或存款银行功能，因为它与创建非常相似，但是
57:32
我们调用 Deposit 而不是 create，我们的第一个参数是
57:38
我们想要存入的金额，因此在本例中它只是硬编码为 0.1
57:47
灵魂，所以现在当我们对实施感到满意时，我们需要修复我们的
57:54
呃我们在这里返回或者实际渲染的内容
58:01
页面所以让我们删除按钮我在这里准备了一些例子所以
58:09
让我们修复一下我们的页面
58:19
在这里，我们将在这里添加一个空元素，因为该元素将包含更多内容
58:25
元素或更多子元素，我们这里首先需要的是
58:30
创建银行按钮，所以我们只需在此处添加该按钮即可
58:36
这本质上只是一个按钮，上面写着“创建爆炸”，然后单击它
58:43
将调用我们的 create bang bang 函数，我们想要的另一个按钮是 fetch
58:49
银行按钮本质上是相同的，所以我们只需添加它即可
58:55
这里会说 fetch 按钮，但不是 calling create Bank 它将调用 get Banks 呃
59:02
函数，所以在我们实际获取银行之后，我们现在需要显示它们，那么如何
59:09
我们将显示它们呃我们知道我们存储了所有银行呃数据
59:14
在我们的状态中，所以我们需要循环或映射这个状态或这个数组
59:20
存储在该数组中的状态包含所有的呃所有的呃
59:26
我们拥有的掌上电脑及其相关数据
59:31
获取了我们可以把它改正
59:39
在这里，我们将通过调用 uh 来做到这一点，请稍等一下，让我们将其包装到
59:46
一个空元素，这样我们就可以放置更多的 element 元素
59:53
在这里，让我们做呃
59:59
银行 Das 地图，我们将绘制我们的银行地图
1:00:06
在这里和对于每个
1:00:12
银行抱歉我的键盘出现一些问题，对于每家银行，我们都是
1:00:20
要做一些处理，所以在我们的例子中
1:00:25
我们将返回一个新的
1:00:33
元素，让我们复制一些样式，这样我将创建一个新的
1:00:40
这里是每个银行的 div，所以我们这里有一个 div 以及什么
1:00:48
我们要打印的是例如一个
1:00:53
呃在这里我们可以访问
1:00:59
银行，在这里我们可以访问存储的所有字段呃抱歉只是
1:01:05
称之为银行，在这里我们可以访问存储在每个银行中的所有字段
1:01:10
帐户所以呃我们有一个名字让我们将其转换为
1:01:22
字符串，因此这将打印出数组内所有银行的名称，并且
1:01:28
我们想做的另一件事是调整细节，那就是
1:01:34
余额所以我们不会打印出名称，而是打印出余额，确保我们也将打印出余额
1:01:41
将其转换为字符串，因为它只会打印出对象，这样就没有意义了，最后一件事
1:01:48
我们每个银行都需要存款按钮，所以我提前创建了存款按钮
1:01:55
所以我们可以把它粘贴到这里，这非常简单
1:02:02
本质上与我们用于创建和获取银行的按钮相同，但这个按钮正在调用存款
1:02:08
Bank 函数并提供一个 pup key 参数，该参数是
1:02:15
我们想要存入的银行，所以现在我们基本上可以开始了
1:02:23
所以我们只是格式化添加一点
1:02:28
把它保存起来并尝试运行它，如果我们幸运的话，我们就可以开始了
1:02:36
我们运行应用程序，该应用程序应该看起来像我之前展示的应用程序，所以如果我们
1:02:41
跳到基础选项卡，我们可以看到我们有 salana Banks，我们有两个
1:02:46
我们可以称之为创建和获取银行的功能，这样我就可以创建一个银行，我可以批准它，这将
1:02:54
为我创建一个银行，您将在控制台中看到结果，我也可以获取银行，以便我可以立即获取
1:03:02
所有与我的帐户关联的掌上电脑只是为了测试一下呃让我
1:03:08
切换或创建一个新的钱包，所以让我们创建新的
1:03:14
钱包 我将其称为帐户三 我们有一个新帐户 我们有一些
1:03:22
因为它处于测试网模式，但让我们跳回我们的
1:03:28
应用程序再次选择或连接钱包，我们将调用到付新钱包
1:03:34
我们刚刚生成的跳转到基础知识获取您可以看到的银行
1:03:39
我已经拥有一家银行，但我可以创建另一家银行，因为我现在正在作为不同的用户进行交互，所以
1:03:46
让我们打电话创建银行批准这个
1:03:52
让我们再次刷新并获取银行，您可以
1:03:57
请参阅我现在有两家银行其中一家银行由我以前的钱包拥有，并且
1:04:04
这家银行归我现在生成的新钱包所有，所以我们
1:04:10
可以继续切换回我们的第一个
1:04:17
钱包再次获取银行并将存款存入由创建的银行
1:04:22
不同的用户，所以我们只存入 0.1 Soul 批准
1:04:30
它刷新我们的应用程序获取银行，您可以看到 PDA 呃
1:04:37
特定银行收到了钱，现在显示余额，所以这几乎是基础知识
1:04:45
如何为您的 salana 程序创建一个简单的 UI，这样您就不仅仅是呃
1:04:51
受到创建呃测试的限制，但您可以随时部署到 defet 写入
1:04:57
一个非常简单的用户界面并以这种方式测试你的程序，因为这真的很好
1:05:03
关于它的是，你可以将你的 UI 托管到任何托管解决方案，并且你可以
1:05:08
将其发送给其他用户以供他们测试您可以下载该存储库
1:05:13
我们在本次讲座中创建的内容，您可以根据需要进行自定义，因此只需添加任何铃声和
1:05:20
你想要的口哨呃最重要的是添加一个
1:05:25
每个银行都有提款按钮，因此本质上是创建一个提款
1:05:31
函数将通过调用从 PDA 中提取所有的钱
1:05:38
我们程序中的withdraw函数因此实现非常相似
1:05:44
到我们所拥有的今天的基本上只是几行代码更改，因此您只需调用提款即可
1:05:50
功能，并且提款功能会将所有资金从 PDA 帐户转移到所有者的帐户
1:05:58
帐户所以感谢你们加入本周的萨拉纳学校呃我
1:06:04
希望你喜欢它并且你了解基本知识
1:06:10
现在为您的 saana 程序创建前端，我将把它交给我的
1:06:16
同事，呃，给你介绍我们下一个任务的详细信息，大家好，我希望你
1:06:23
很喜欢这个关于为你的主播程序构建前端的讲座
1:06:28
嗯，我想祝贺你在索拉纳学校取得了如此大的进步，嗯，是的，现在你有了
1:06:36
从头开始构建完整的 D 应用程序的基本知识，嗯，我会
1:06:42
希望您介绍一下本例中的最终作业，呃，这将是
1:06:47
有点不同，因为呃不会有任何自动化测试，呃不
1:06:54
与以前一样预定义程序结构，呃我们希望您能够
1:07:00
有创意，所以任务将是创建你自己的 D 应用程序，呃，这完全取决于
1:07:07
你知道这个程序会做什么，呃，是的，你更有创意
1:07:13
更好呃会有一些基本要求但是所以呃我们想要
1:07:19
呃你的程序使用 PD
1:07:25
并且您将程序部署在 defnet 上，呃还有另一个要求
1:07:32
呃，你应该为每个锚点至少进行一个打字稿测试
1:07:38
程序说明，呃，也请嗯
1:07:44
还包括不愉快的路径场景测试，因此这意味着还包括将
1:07:53
测试呃呃你会提交呃意想不到的呃数据给你
1:08:01
说明呃下一个呃要求将是呃你的程序应该有
1:08:08
至少在理想情况下使用您首选的方式部署一个简单的前端
1:08:15
提供商，这样我们就可以轻松检查结果，嗯，不用担心，所以我们
1:08:22
不会创建视觉方面，所以我们只是想看到呃，你能够创建一个前端呃，可以
1:08:30
与您的程序一起使用，嗯是的，因为我们会嗯
1:08:37
嗯，手动审查你的项目，不会有任何
1:08:42
自动化测试，我们希望您包含一个简短的自述文件，您可以在其中
1:08:51
应包括您的项目的简短描述，以便您知道它是如何运作的
1:08:56
呃，你的项目的主要目的是什么？呃，如果你成功了
1:09:02
部署你的锚定程序和你的前端呃然后呃也包括
1:09:08
我们可以在其中看到操作结果的链接，无论如何，也请呃
1:09:16
呃，包括一个简短的如何构建和测试你的锚定程序
1:09:21
本地呃以及如何在本地运行前端应用程序，特别是如果你
1:09:29
正在使用任何你知道的不寻常的呃
1:09:34
这样我们就不必对您的产品进行逆向工程
1:09:39
项目所以是的，我们知道这是相当多的工作要做，所以你会
1:09:45
两周完成这项作业希望能给你足够的时间
1:09:50
如果您有任何困难，呃，一如既往，请随时询问
1:09:57
不和谐和最后一件事所以下周学校还没有结束
1:10:02
关于主播节目安全性的讲座 呃所以呃是的一定要回顾一下
1:10:10
您针对重大安全问题的计划，呃最后我们还会有一个
1:10:16
奖励讲座呃，这将是更高级的一点，我们将向您展示
1:10:22
你如何为你的主播节目写一个最快的，嗯，嗯，再次，嗯，你会的
1:10:31
在 Discord 上找到有关该任务的任何进一步说明，请毫不犹豫地询问
1:10:39
一切都不清楚，嗯，是的，今天谢谢你，祝决赛愉快
1:10:46
任务和创意再见

```