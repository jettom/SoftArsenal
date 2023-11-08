It's the weekend and you may have some extra time to learn something new 🤓

Watch the Bonus Lecture on SPL Token here: https://youtu.be/Meys2-PeWiA?feature=shared

In this lecture, we will introduce you to the Token Program within the Solana Program Library. This should serve as an entry point for using Tokens and the capabilities of the Token Program within your dApps.

Sample repository: https://github.com/Ackee-Blockchain/sos-bonus-lecture-escrow
SPL Token Program: https://github.com/solana-labs/solana-program-library/tree/master/token/program
Associated Token: https://github.com/solana-labs/solana-program-library/tree/master/associated-token-account/program

# 文字起こし
```
0:01
hello everyone and welcome to the next lecture in the school of Solana today's
0:07
lecture is going to be about the SPL token program the content of this
0:12
lecture is as follows firstly I will quickly introduce what SP is and what
0:18
the most important accounts within the token program are then we will proceed
0:24
into the handson example which you have basically two parts the first part will
0:30
be about the ESC program structure the motivation behind the program and how it
0:35
can use the accounts methods from the token program then the second part will
0:42
be about coding where I will show you how to work with the token program within your DF or brief um sorry and
0:50
briefly within the client side or test side so now let's move
0:58
on so what is SPL token program actually uh firstly Ed its score the Sol program
1:06
library is a set of programs then further token program is just the
1:12
program within this library that provides uh framework for the uh for
1:18
creating and managing tokens then those tokens Can represent basically anything
1:25
of value from crypto from digital assets uh table coins and are fundamental to
1:33
the functioning of uh defi or decentralized Finance uh they can be
1:39
used as non funable sorry non funable tokens and
1:45
more then there is the basic uh structure as I as I said I'm going to
1:51
talk about the most important account so uh key features and components uh you
1:59
can see in the middle there is the mint account and the mint account in the world of the SPO token program act as a
2:07
blueprint for tokens the Min accounts Define the rules and properties of specific type of a
2:14
token key attributes of the Min accounts uh include the total Supply as you can
2:21
see within data field here that's the supply the number of decimal places
2:27
let's say 9 six um then the authority responsible for maintaining new tokens
2:35
that's is the m Authority Field Min accounts actually provide the
2:41
foundation for the token creation and Supply management then we have token account on
2:48
the left hand side token accounts can be told of an account designed to hold a
2:54
particular type of token this accounts store essential information such as as
3:00
the token balance you can see the amount which is basically the
3:05
balance the owner or owner's wallet address that's the owner public
3:12
key and the reference to the corresponding me account okay that's the
3:17
main public key lastly sometimes you can bump into something called Associated
3:23
token account and Associated token accounts are essentially token
3:30
accounts with the same data contents as a regular token account okay in contrast
3:37
a token account can be created at any address using a program direct address
3:43
or a common keypad however Associated token accounts have predefined rules for
3:50
creation with their addresses being derived from the main public key so this
3:57
data field and the owner public this distinction then leads to a situation uh
4:05
where you can have multiple token accounts for a specific token and only
4:10
one Associated token account for that same token because me and owner will be
4:17
always the same for one owner and one Min with all the information in mind
4:25
let's now move on to the Head headson example of the ESC program so before I start uh actually
4:34
coding I want to quickly go through the explanation of the escrow program the
4:39
workflow of the program and what is it why is that firstly let's say you want
4:44
to exchange Euros for dollars so for this example we can say that you are on the Alis side and you want to exchange
4:51
Euros for dollars with Bob or let's say it's not your Hest friend the question
4:58
actually is who is going to send the payment first because if you send the payment first so you send the $10 and
5:05
you want to receive 20 sorry you send a 10 euros and you want to receive
5:11
$20 Bob can actually scam you and run away from the exchange so you are now €
5:18
10 in minus this is the problem also for the
5:24
other side so you can basically let's say scam the goal of the escr program is
5:32
to solve this problem uh on one hand side we have Alys
5:37
with Associated token account for tokens X in this example euros and Associated
5:43
token account for tokens Epsilon in this example dollars on the other hand we
5:49
have Bob also with the ATA for dollar and 84
5:55
EUR and now the workflow firstly Alice is going to initialize the exchange with
6:03
the escrow program that means initialize exchange is basically method within the
6:08
escr program and this method will create an escr token account for tokens X or in
6:16
this example euros and we can also call it the
6:21
Vault then this method will also transfer tokens from alysis Associated
6:28
token account for Euro into this escrow token account for euros that means the
6:33
Euros are basically loged here so she cannot run away with the with the with
6:38
the dollars then we have basically two options one option is that Bob decides
6:45
not to accept the exchange Alice then can close the exchange and withdraw the
6:51
balance from the escal token account that means she won to lose anything
7:01
alternatively Bob can proceed with finalizing the exchange this method will firstly
7:08
transfer dollars from Bob ATA for tokens ipsilon or dollars into this ATA of
7:16
Ellis for dollars that means Ellis received the dollars then Second
7:23
Step uh the method will transfer escr I'm sorry the method will transfer euros
7:29
from this Vault or escr token account into this Bob ATA for EUR that means
7:37
Alice received the dollars and Bob also receiv received the Euros last two
7:45
steps we can U sorry not not we but the method can remove unnecessary accounts
7:51
such as the escrow account and escrow token account because as I said exchange
7:57
is finalized so we do not need those anymore now if you stop and think about
8:04
it Bob has only two options either not to accept the exchange or to accept the
8:11
exchange without opportunity to scam you because this is because exchange
8:18
finalization right the method for finalization exchange automatically
8:23
trigger the transfer of dollars so there is no option like I want to re receive
8:29
Euros but no transfer dollars within this function he has only two
8:37
options one option is that transfer dollars and receive Euros second option
8:43
is not to finalize the exchange and he won't receive
8:49
anything as you may see I'm sharing gp. RS uh for this lecture I in advance
8:56
implemented uh escr program template as you should be already experienced
9:03
with the basic anchor structure or anchor project structure so that means we have lipto
9:10
which is basically entry point to our escr program our escr program expects
9:17
free functions as I uh was talking about those within the within the workflow
9:24
part those are initialized exchange finalized exchange and exchange further
9:31
first initialized exchange also expects free input
9:36
parameters or free input arguments and those are A to B amount B to a amount
9:42
and side B then I want to clarify
9:48
that uh in this context actually side a is Alis side B is Bob then A2B amount is
9:57
the amount we want to exchange change from Alis to Bob and b2a amount is amount we want to exchange from Bob to
10:06
Alis okay then there is the state. RS file which defines uh escr structure
10:14
this structure is going to be used within the escro account data field and the structure contains uh public keys of
10:22
the sides then the amount we want to exchange then there are the means the
10:28
means are important in order to create a sufficiently unique uh program derived
10:34
address and as I said we are going to use program der sorry program deriv
10:39
address that means we need to store bumps let's move on into the initialized
10:46
exchange function or file firstly within the instruction mcro we
10:53
are specifying that we want to use A2B amount B2 a amount and side B from
11:01
the uh function input arguments these variables are going to
11:08
be used within the program derived address of the escrow escrow
11:14
account then side e sorry site a is
11:19
expected to be a signer because the the Alis actually needs to approve that she
11:26
wants to um make the exchange with the Bob so she
11:32
needs to actually sign the transaction further as we are going to transfer
11:37
tokens from her token account into the escro token account uh we need to
11:44
delegate the signature into the um cross program invocation context
11:50
so uh these are the two options that for her to be signer further she needs to or
11:58
sorry her account needs to be mutable because uh she's going to pay
12:03
rent for the initialization of escr account and scroll token account so we
12:09
need to modify her balance so that's why her account needs to be
12:14
mutable then we have escrow account this escro account is going to be initialized
12:20
as specify here uh then as I said payer is going to be site a or
12:26
Ellis then we need to specify the space uh we need to use or we are going to
12:31
allocate within the data field of the uh fresher initialized account then uh
12:38
there are the seats uh as I said we are going to also
12:44
you use Mint or mints within the seats and uh same goes for the amount we want
12:51
to transfer this is because let's say um we
12:57
do not include those fields within the seats of the PDA rather we use only
13:03
those two this would mean that at the time we can create only
13:09
one exchange between a to B right because then another exchange will
13:17
create um same program derived address for escr
13:23
and that would mean because obviously side a and side B would be the same
13:28
public keys that would mean that we cannot cannot create next escrow
13:35
account uh because we have already initialized previously escrow account on
13:42
this uh program derived address so that means in order to create sufficiently unique address we need to specify more
13:49
variables so in this example I'm going to specify also means and I'm going to
13:55
specify also amount then then we have those two
14:01
accounts and firstly side a send token account as I have shown you
14:08
before it's this account and it's actually Associated token account Ellis
14:13
so we need to specify that we are expecting Associated token account we
14:18
can do it with the account macro and within the account mro firstly we need
14:25
to specify that this account is going to be mutable in order to modify the balance of the token account because we
14:32
are going to transfer tokens from this uh token account or Associated token
14:37
account into the escro token account next there are two important
14:43
constraints in order to tell the anchor that this is associated token account
14:48
and in order to tell the anchor that uh as I said assoc token account have or
14:57
sorry has uh its address derived from the owner public key and the mint public
15:03
key so we need to tell anchor that look this account is going to be assoc token
15:09
account so check if the rules for the for the address are met so we can do it
15:18
this way specify Associated token then mint is going to be a to be
15:27
mint and the next input or the next seat for the associative token account address is
15:36
actually the owner or in this case it is called Authority but it's the
15:43
same and Authority sorry not authorize author and this should
15:50
be site a okay so right now we are telling the anchor look this is going to
15:57
be Associated token account so use those two public Keys AK a public key for me
16:04
and a public key for site a derive a program derived address from those two seats and uh check if the addresses are
16:15
equal as you may see uh we are getting error here cannot find the token account
16:21
in this scope so this means in order to work with u SPL token program we need to
16:27
specify uh depend for that so let's go to cargo.
16:33
Tomo and uh as we are working within the anchor we need to specify
16:39
anchor SPL equals
16:47
028.0 this will provide uh necessary structures and functions in order to
16:52
communicate with SPO token program so let's get back into initialize exchange
16:58
and now now we can use use Anor
17:05
SPL
17:12
BR okay let me drink some
17:19
water and let's move on so right now you can see that we are not
17:27
receiving error anymore for the token account so let's move on into the escore
17:33
token account uh the escort token account in the in this example is not going to have
17:40
the address for the associated token account but we are going to create
17:45
program derived address for this token account next as I said for the exchange
17:53
we are going to initialize this uh token account that means we need to also specify that we want to actually
17:59
initialize the escor toen account so we can do it this
18:04
way again we need to specify mcro and the inputs are in
18:10
it then payer which equals side a as I said Alis is going to
18:19
pay rent for escrow and escrow token account and it's not a problem because she won't lose any Solana because within
18:26
the cancel exchange or find WI exchange we are actually going to close those accounts and the rent will be refunded
18:33
back to Alis so that means the rent she paid for the for the initialization or
18:40
the fees she paid for the initialization she will get refunded later on then this
18:46
is quite different from the escrow account because uh in order to create
18:51
escro account we need to specify space because uh anchor does not know in
18:57
advance how how much space we want to use but on the other hand as we have
19:02
specified here that this is going to be token account and uh data within the
19:07
token account has uh or have deterministic size that means we do not need to specify actually space because
19:14
the size of data within the token account is always the
19:20
same rather we need to specify to which mean or the tokens of
19:27
which mean this token account is going to hold so that mean we need to specify
19:33
a to be mean then we also need to
19:39
specify authority over this mean and here are the the three options
19:48
for the authority first option is uh let's set the authority as Alis then
19:54
let's set the authority as Bob and lastly let's set set the Authority as a scroll and uh we cannot set the
20:02
authority as as sorry as Alis because that would mean if you want to finalize
20:08
Exchange in order to transfer tokens the locked tokens from this account into the
20:14
Pop's token account or Associated token account the alies would need to uh sign
20:20
the transaction in order to be able to transfer the tokens because uh authority
20:26
over assoc token account always needs to sign the transaction if you want to transfer tokens from the from the to uh
20:34
from the token account on the other hand if Bob is uh authority over this token
20:39
account that would mean that Bob can uh withdraw tokens from this from this
20:47
Vault or from this token account without sending without actually sending the
20:53
dollars to the Ellis so the result would be that
20:58
he actually scammed her so that's why we have escrow
21:04
here lastly we are going to specify seats because uh as I said we do not
21:11
have uh specific rules for token accounts or for sorry for address of
21:17
token accounts um in order to recap we have token account which is uh which can
21:23
be created on whatever address so we can use actually PDA we can use uh regular
21:30
key on the other hand we have the associated token account which can be uh
21:37
seen here and here we are specifying actually the seeds for Associated token
21:42
account address on the other hand for the token account as I said we do not uh need these rules or we do not have these
21:48
rules so we can use act PDA and as I said before the PDF for the
21:54
escrow is sufficiently unique so that means I'm going to use for this example
22:00
I'm going to use escro public key as seat for this PDA lastly we need to
22:07
specify debm and I'm going to drink coffee so
22:13
sorry guys hopefully I'm not noisy with my
22:21
sipping okay so we are done with the context uh no we are not done yet uh you
22:30
can see we have mint accounts here and for those uh accounts we do not
22:36
need to actually specify any kind of constraints uh one thing that we need to
22:41
specify is that uh we need to include the mean from the Anor PL as I uh as I
22:48
made for the token account so let's include the
22:56
means we need to just uh actually we are including the Min uh we can uh check
23:03
what the Min means and this is actually uh public
23:09
structure so we are telling the anchor that we expect the mint account on the
23:16
address provided within the within the context so anchor will check that this
23:22
is uh or this account has correct structure within its data same go for
23:28
the B2 a me and you can see last error cannot find type token so
23:35
this goes uh as same for the for the mean so we need to specify also token and this token
23:43
program actually why we need to specify the token this check ensures that uh or sorry anchor
23:51
will check that the account specified uh as a at the last field of
23:57
the context is actually program and the program is actually token SPL sorry SPL token program why we need to use token
24:05
program within our context because we are going to transfer transfer tokens from token
24:13
accounts and in order to use transfer function which is from SPL token program
24:18
we need to use sorry we need to uh we need to specify this token program
24:23
program within our context so let's move on inside the
24:30
function body and as I said firstly we need to uh initialize this escrow and
24:37
secondly we are going to transfer tokens from Ellis to the escrow token program
24:42
sorry escrow token account so let's first initialize values within the
24:47
escrow account that
24:56
means we are going to to specify the escrow variable which is uh actually
25:01
pointing on on onto the or into the escrow account now let's F
25:09
the
25:17
variables same goes for the side
25:24
B then we have the
25:34
amounts same goes for the amount uh for the receiving amount from
25:40
the Lis perspective then we need to store the
25:48
Means A to B mean equals context do account
25:54
dot A2B mean. key do key function will return uh basically public key so we are
26:02
storing public Keys within these variables same goes for
26:08
the receiving me from the uh aside a
26:14
perspective or Alice perspective lastly we need to store the store the bumps of
26:20
the uh program direct address so escrow do bump equals and
26:28
we need accounts uh sorry not accounts bumps
26:38
doget and we need to specify the key for the hashmap or I think it's hash
26:44
stre and the key is actually the variable name so
26:50
escroll and now let me copy the variable name of the escr token
26:56
account and don't forget to update this variable as this is going to be escr to
27:05
bum okay so right now we
27:11
uh successfully initialize the variables within the escrow account and now we are
27:17
going to perform the transfer from the alysis ATA or SCT
27:23
token account to the scroll token account let me open the
27:29
obsidian we are going to perform transfer from this Associated token account into this fresher initialized
27:35
escr token account so for this we need to specify transfer function from the
27:45
MPL and this transfer function we actually call uh transfer function
27:52
within our token program but we we obviously need to specify the that we
27:57
want to we want to uh invoke function with sorry from token program we need to
28:05
specify it in this way cross program invocation
28:10
context new then there is the program so this is the public key of the program we are
28:17
going to call that's the context do accounts. token program as I
28:24
said uh to account info sorry to account
28:30
info then we need accounts for the accounts we need to specify the structure we are going to
28:37
use and the structure is the structure name is almost The Identical because
28:42
it's called transer and within this
28:47
structure or this structure has Fields as follows from which is context
28:56
do accounts Dot site a send toen account
29:02
to account info uh I will recap this structure
29:10
two is accounts escr token accounts to account
29:15
info this is we are basically now specifying the context for calling the
29:20
program it's almost the same as specifying the context within this
29:26
within within our program okay and Authority
29:33
is at this uh lastly we need to we need to
29:41
specify what amount we are going to transfer so actually this is the A2B
29:48
amount okay so let's recap we are calling transfer
29:55
function within the transfer function we need to specify the CPI context the
30:00
context sorry the context needs to contain which program we are going to
30:06
call so we are going to call token program within the
30:12
SPL uh from the context perspective as I said this ensures that the program is
30:19
correct because anchor will check that that the public keep provided uh as within this field on the
30:27
input or on the client side or within the test side that the public provided
30:32
here is actually SPL token program so that means it's
30:39
safe then we need to specify the uh account structure or transfer structure
30:45
that will tell us the transfer function that we want to send tokens from site a
30:51
send token account or aka the associated token account of Alis then then we need to specify two so
30:59
we are sending tokens from this account to this account uh this is the escrow
31:04
token account which was uh freshly initialized and there is the authority
31:10
over site a send token account which is side A that means the Lis lastly we need
31:16
to specify the amount and as you may remember I said uh site a needs to sign
31:22
the transaction because she is the authority over this sorry
31:28
over this token account that means the signature or the Privileges are going to
31:34
be delegated from this uh from from this context inside this cross program
31:40
invocation context okay we are complete within our
31:45
initialized exchange then we can proceed into the finalized exchange and you may see initially that
31:54
uh these are the identical errors for the the dependencies so let me just copy
31:59
the dependencies
32:06
here and as you may see the structure is basically the same we have finalized exchange and there is the finalized
32:11
exchange function so we are going to implement the exchange and I'm going to
32:17
uh talk about the the context so firstly finalized exchange is uh going to be
32:24
signed by side B firstly the side B is not required to be mutable account
32:29
because side B is actually not going to pay any rent for anything and again the side b or Bob
32:38
needs to sign the transaction because we are going to transfer we are going to transfer tokens
32:44
from his token account sorry from his Associated token account for Dollars into L's associate token account for
32:52
dollars and Bob is authority over this token account that means he needs to
32:58
sign transaction in order to delegate the Privileges for the uh cross program
33:03
invocation context actually that's the same as uh we were doing within the initialized exchange
33:12
function next as I said within finalized exchange we are going to close the
33:17
escrow account so that's why you need to specify close and site a site a is going
33:24
to receive the the r and that means as I said at least won't lose any Solana for
33:31
rent so uh yes she will receive the run back then the account is or has to be mutable
33:38
in order to close it then these are the seat seats and lastly we check that the
33:45
uh bumb is correct then there is the site a unchecked account this means that the
33:53
there are no checks performed on this account uh and the account is marked as
34:02
mutable that would it would be safer to use site a as a seat in this example
34:10
so um why this uh account needs to be mutable is because we are going to
34:17
transfer or modify balance because we are transferring the the rent to back to Ellis so the the
34:25
account needs to be mutable in in order to modify the account then we have constraint for the
34:33
associated token token account this is actually the same as for uh initialized
34:38
exchange but the variables are different here for the corresponding uh authorities and for the corresponding
34:45
means this means this is site a reive token account from the uh escr
34:51
structure it actually means that this is uh sorry this receive Associated token
34:57
account authority over this account is Alis AK side B and this token account is
35:02
tied to this me that means this token account holds tokens of this me AK the
35:08
dollars okay again the account needs to be mutable in order to modify the data
35:14
or the amount within the within the token account actually in order to
35:21
perform the transfer which will modify the amount same goes for S site B receive
35:29
token account there are the corresponding uh mint and Authority pup
35:34
Keys then this is the uh I'm talking right now about the this is the sideb
35:41
send token account this is the side B receive token account so from this token
35:48
account we are going to perform transfer to this token account and from uh this
35:54
Vault where are the locked eurs we we are going to perform transfer here so we just need to check that the
36:02
Min me is correct and then the authority is also correct lastly we have a scroll token
36:10
account as I said earlier we are going to close this account so we are going to transfer rent to Ellis or site a that
36:18
means the account needs to be mutable further we check that the corresponding
36:24
me is actually correct uh again we check the authorities also correct and they
36:29
said for escrow there are the seats uh necessary for deriving the program dered
36:35
address and here is the saved bump lastly as we are going also to
36:41
perform transfer we need to or SPO token transfer to be to be exact we need to
36:48
specify that we are expecting token program inside our
36:53
context so let's work uh on function body so as I said firstly we
37:01
are going to transfer dollars from this Associated token account into alysis
37:07
token or sorry alysis Associated token account to be exact so for this purpose
37:14
I can just copy this transfer and alter the or modify the
37:22
from to an authority so firstly oh s sorry this is cancel exchange I want to
37:28
make it within uh finalize exchange so transfer uh context is the same token
37:34
program is the same because we are uh invoking uh token program transfer here is the from account but
37:42
this time we are transferring from site site B send token account
37:50
into site a receive token account Authority here is the b or side
37:57
B so he signed the transaction the Privileges are going to be delegated
38:03
within this uh cross program invocation context that means this uh transfer is going to pass again we need to specify
38:11
variable that will hold data from escroll or hold I would say read so
38:21
context. account escroll so we can use those dat
38:27
in order to perform transfer so we can read and there is no A2B amount or
38:34
rather B to a amount because
38:39
again we are transferring from this token account into this token account so
38:45
that means we need to transfer B to a amount not not
38:52
otherwise next we are going to okay I can open it again next we are going to
38:58
perform transfer from this escr token account into this Associated token
39:03
account for this purpose I can also just copy this
39:11
transfer and firstly this transfer is going to be performed from as I said es
39:18
scr token account this time into side B receive
39:24
token account but as you may remember authority over escroll token account is
39:32
escroll uh there is the amount we are going to transfer which is a to be
39:38
amount okay and right now uh before
39:44
I deep dive into the transfer let me drink my
39:54
coffee okay you may ask but Andre ESR did not sign the
40:02
transaction it's only program derived address and we know that program derived
40:08
addresses actually do not have corresponding private key yes that's true but there
40:16
not that that not means that you cannot actually sign uh transactions or uh
40:23
cross program uh better cross program invocations with uh program derived
40:29
addresses it's because when you actually uh create PDA
40:36
one of the seats that is not specified here but is automatically used within
40:42
the derivation process is program ID so that means I can specify here the seats
40:50
of this uh PDA and the program progr ID our program ID to
40:58
be to be exact is automatically going to be included within the seats that
41:05
means uh we could call this cross program invocation actually only within
41:11
uh within our program so that means the signature is correct okay because no one
41:18
else actually could derive the program derived address as only our program
41:26
could derive it because our program's ID is unique ac across the Solana
41:35
blockchain and in order to use the signer
41:40
seats we can include those oh sorry first we need to specify
41:46
that the function is not uh sorry the cross program invocation function uh
41:52
sorry we are not going to create CPI context like this we need to specify
41:57
that we are also going to sign the context and in order to sign the context
42:03
with the escrow we can specify the escr seats again the program
42:10
ID of our program is automatically going to be included within the seats that
42:15
means only uh we that means we could call the
42:20
transfer function only from our program
42:27
and again uh this will ensure that
42:32
the that the seats are correct because if this exactly same transfer would be
42:41
performed within another program the program ID would be different that would
42:46
mean that the PDA won't be uh equal to
42:52
the escr PDA
43:02
okay so let's recap we are um invoking transfer within token program
43:09
transferring from escro token account into the sideb receive token account Authority here is escroll here are the
43:18
seats there is the bump and there is the amount let me check if the amount is correct yes so we are transferring from
43:25
this token account into this token account so that that means it's the A to B amount and here is B to a amount so
43:33
let me check that the amount from the previous yes there is the b2a amount
43:40
okay so and lastly we also need to specify uh cancel
43:48
here because uh there is this is quite
43:54
different because we can close the escrow account in this way because uh
44:01
the escrow account is owned by our program as the PDA is derived with the
44:07
within our program on the other hand this token account is not owned by
44:16
our program that means we cannot simply do close equals you know site a and uh
44:24
next it won't simply close the account in order to close token account we need to invoke
44:33
again close account function and I would say I have nope so I need to specify by
44:40
hand this this function and for this
44:47
purpose we need to close account okay is automatically included and we need to
44:53
specify the context and actually the context is is going to be same as for
44:58
the transfer as we are going to close the escroll sorry escr token account
45:05
that means we need to actually the context is the same again with SRO again
45:11
we are invoking token program but this time with a different function which is called close account the this structure
45:18
is going to be quite different and the signts again are the same because the authority over the escort token account
45:25
is escroll so let me specify the context which is CPI
45:30
context new signer program is going to be context. accounts
45:38
do escroll uh sorry not not escr but token token
45:44
program account info next accounts for this purpose are uh sorry we need to use
45:52
a structure called close
46:02
account and within this structure we have Fields such
46:09
as account destination Authority so account is the account we are going to
46:14
close that means it's context account es token account to account info next there
46:22
is the destination actually the destination is account that is going to receive the the rent back so this is the
46:29
Alis actually because she's going to receive the Solana back context. accounts. site a. to
46:37
account info and again as uh within the transfer function or within the transfer
46:44
struct here on the line 26 there is the authority over this escr token account
46:49
and the authority is es scroll
46:54
okay three account info and we need to
47:01
specify sign seed so let me just copy the signer seats from the transfer
47:09
function okay then this transfer need to delegate
47:16
the result also this transfer so question mark question mark and this
47:24
should be okay and and I have warning here for domain that is
47:32
unused AKB amount b2a amount and closing account uh let me just quickly copy this
47:41
because we are running out of time and within the cancel exchange as I said or
47:48
okay let me firstly go through the uh canel exchange context so firstly site a
47:55
is signer because only Ellis can as Ellis initialize the exchange again she
48:00
can only cancel the exchange account needs to be mutable in order to modify the balance because we are going to
48:06
close the account basically same as for finalized exchange we are going to close the escro account and the escrow token
48:13
account here are the seats then we check the bump this is uh totally the same as for
48:23
finalized exchange the account is mutable we are closing uh then we check the correct
48:30
mean and Authority here are the seats and here is the bum firstly let me just paste this here
48:39
and then I need to copy the uh use
48:44
statement because we are going to use close account we are also going to use transfer this okay okay this is also
48:51
okay and this is also Okay so this is not anymore triggering
48:57
the error and lastly we have the site a send token account so let me open the
49:03
the canvas we are including this Associated token account here because as
49:09
I said we are going to cancel the exchange that means the tokens that were sent from this Associated token account
49:15
into the escrow token account are now going to be sent or transferred back
49:21
because we don't want Alice to lose any tokens so she will receive reive the lock tokens back okay so and in order to
49:29
perform the correct checks checks uh the account is uh mutable because we are
49:35
going to change the balance then we need to specify that this is associate token account the authority over the account
49:41
is Ellis the mint connected to this account or the tokens that will that uh
49:47
sorry yes the tokens that this account holds are from the A2B me hopefully I
49:55
said correct uh so we need to specify the mean and yeah that's it and also we need
50:03
to specify token program because we are going to invoke transfer and close account
50:08
function so firstly I'm going
50:14
to so first let me copy this uh this transfer because this transfer is
50:19
probably going to be the same or at least the structure is going to be the same and before I update the values let
50:26
me just uh specify the escroll equals context. account. escroll the variable
50:33
holds data from the escrow account okay we are performing transfer with signer
50:41
because escrow is authority over escrow token account we are transferring tokens
50:46
back to Alis so this means to be site a send token account uh what did I
50:54
miss then there are the seeds and then lastly
50:59
this is the amount and this is actually the amount which was initially sent from the associated token account of Alis
51:06
sorry into the escr token account so as we are canceling the exchange this is
51:12
triggering error why it's wrong okay this needs to be
51:21
referenced um as we are transferring the tokens backs sorry tokens back to the
51:28
Ellis so we are transferring actually the A2B amount which was initially transferred from
51:34
Ellis then we are specifying the close account function again new with signer
51:41
we are specifying token sorry we are using token program we are closing we
51:46
are going to close escor token account here is the here is the account that we
51:52
received the rent back so sign a and escrow is Authority again we need to
51:57
specify signer seeds in order to to uh sign the invocation
52:06
context so right now this should be correct let me check
52:12
okay question mark let me aner
52:18
build and let me sip my coffee okay we have warning here
52:26
so what's warning telling finalize exchange we need to specify the question
52:31
mark So what's wrong okay disclose account function so again anchor
52:41
build and lastly I want to show you the test file in order for you to know how
52:47
to work with means and tokens within the test or actually I would say it's almost
52:53
identical for the front end or for the client side so firstly uh we need to specify a library
53:00
that is called Solana token and in order to do that we can use
53:09
Yar Solana SPL
53:14
token this will import the library into into our package
53:19
so it's okay now then we can call Anchor test
53:26
and while we are testing I will just briefly briefly comment on
53:32
the on the cite implementation so firstly we are specifying Alice and Bob
53:38
which are randomly generated key pairs we see we can see that the test
53:45
tests passed so hopefully I'm going to comment on that um then we we are specifying the
53:53
main authorities as I said the mint accounts uh have the authority and the
54:00
authority basically can mint from these uh from these mint accounts that means
54:06
if your let's say your parent is uh let's say your parent is me authority
54:12
over any kind of mean that means uh your parent can mean you the tokens
54:19
of the of the mean uh we are specifying uh random key pair
54:26
here then there is the amount we want to transfer let's forget about this a Toc
54:32
Min Authority as these uh key Pairs and these uh means authorities and so on are
54:38
used later in the test so just for the informative purpose it's okay to only
54:44
focus on to A2B mean Authority and A2B amount uh then A2B amount we are
54:51
transferring uh 15 tokens from Alis to Bob and in exchange we want to receive 38 tokens from Bob to
54:59
Ellis to me is the initial value of tokens we are going to mean for Alis and
55:06
Bob so let's say from the uh earlier example we are going to mean f mint
55:12
fresh 100 to Ellis and fresh $100 to Bob
55:18
and they are going to exchange uh 15 for $38 then we need to spef if y air draw
55:26
because uh those authorities are going to pay for the for the means later on
55:31
and then uh Alis and Bob are going to pay a fees such rent and transaction
55:37
fees then there is the function for create mean so uh this function takes uh few
55:46
arguments the maybe the most important is the mint Authority which is A2B mint
55:52
then we have fre Authority which is option this freeze autor can actually freeze token account so that means uh if
56:01
the if the token account is Frozen uh we cannot perform transfer from the token
56:06
account but this is I would say maybe a little bit of advanced stuff then there
56:12
are the decimals why did I use nine and six based on the experience is most most
56:19
common value and lastly there is the option of keeper so the resulting mean is going to
56:27
have um random actually random public key so these are the functions for the
56:34
meanss again for the me then we have token create account uh the most
56:41
important part here is that if you open create account you can see that there is the one to fifth argument which is
56:48
optional keeper and this uh optional keeper is defaulting to the associated
56:53
token account for the meain and on that means uh we specify A to B
57:01
me at is uh public key and this is actually the mint this is actually the
57:06
owner if and if we do not specify the fifth argument this function will
57:12
automatically create Associated token account address so the associated token
57:18
account address is actually PDA derived from this me and this
57:23
owner uh the second argument is or the second second parameter is Alis which is
57:29
the payer for the account creation same goes for the uh second ATA which is uh
57:37
used later on within the test and test and sry same goes for the Bob which is
57:44
actually uh Associated token account but from the other side so you can see there
57:49
is the mint and there is the OWN lastly in order to Mint
57:55
as I said we are going to Freshly mean $100 and 100 so we can perform token do
58:02
me to there is the Bob which is I would say payer for this mint then there is
58:10
the mint address from which uh we are going to Mint there is the token address
58:15
which is going to hold the tokens then there is the mint Authority which needs to sign the the transaction and there is
58:23
the amount sorry there is the amount we are going to Mint initially so we are
58:29
using uh to Mint which is $100 or Euros in whatever case you
58:35
want and that's it from this side I run out of time so you can see that all the
58:43
tests have passed we wanted to sign uh sorry we wanted to exchange a 15 uh EUR
58:50
for $48 we initialize the exchange now you can see escr token account holds 15
58:56
EUR and side a balance after initialization is 100us 15 which means
59:02
85 and then after finalized exchange we have 38 38 tokens within the site a site
59:10
a Associated token account that's the token account for dollars and on the
59:15
other hand side we have 15 within the side B Associated token account for
59:21
Heroes so we successfully finalized exchange and uh it went actually SEC
59:28
secur and no one scammed any anybody within this lecture we went
59:34
through the basic basics of the token program within the Solana program Library I also showed you how you can
59:42
use the token program within your own chain programs and also the idea behind
59:48
communication with the SPL token program from the offchain site AK from the Cent
59:54
side or test side now I want to thank you for your attention and I hope you
1:00:00
get inspired for the final projects and of course I look forward to
1:00:06
your submission so bye and see you next time
```