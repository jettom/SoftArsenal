# Lecture 2, here we go  @here  🫶🏻 

Where: https://youtu.be/rwOv8t7X-J0

Wen: Today, September 27, 6PM UTC  (you can watch anytime after the premiere)

Today we will breeze through the absolute basics of Rust concepts to prepare you for Solana Programming Model next week!


Run Rust snippets directly in your browser:
https://play.rust-lang.org/
The Rust Programming Language Book will give you an overview and in-depth look at Rust:
https://doc.rust-lang.org/book/

More useful links: 
Ackee Solana Handbook:
https://ackeeblockchain.com/solana-handbook.pdf
Development tools :
Rust: https://www.rust-lang.org/
Rust Analyzer: https://rust-analyzer.github.io/
Solana CLI: https://docs.solana.com/cli/install-solana-cli-tools
Anchor: https://www.anchor-lang.com/docs/installation 
```
# cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
cargo install --git https://github.com/project-serum/anchor anchor-cli --force
cargo install --git https://github.com/project-serum/anchor avm --force

sudo apt-get update && sudo apt-get upgrade && sudo apt-get install -y pkg-config build-essential libudev-dev libssl-dev
avm install latest
avm use latest
anchor --version

```

You have just completed the second lecture at the Autumn School of Solana 2023. To proceed, follow the https://classroom.github.com/a/32XaSqwF to access the second task. This time you are going to touch some Rust programming. Inside the generated directory, you will find all the necessary information for the next steps. Good luck!


# 文字起こし
0:00
hello everyone welcome to another lecture of school of Solana today we'll
0:06
be talking about the introduction into the rust programming language before we begin uh let's talk a little
0:12
bit about the content of this lecture so yeah we'll be talking about the introduction to rust uh we'll not be
0:19
talking about Solana Concepts today yet that's for uh lecture for next week and
0:24
we'll be doing some of the Hands-On examples to get our hands dirty and introduce ourselves into how rust
0:30
programming works so yeah before we do any coding uh let's
0:35
just briefly talk about rust history uh how kind of rust came out to be one of
0:41
the most favorite programming languages currently in the software development ecosystem
0:47
so yeah rust is a modern systems programming language it prioritized safety speed and concurrency it is
0:54
statically and strongly typed programming language and it was founded as a personal project of great and
1:00
Horror in 2006. uh in 2009 it was sponsored by Mozilla foundation and
1:06
later a quote unquote acquired by Mozilla and it is maintained by Mozilla to this day it supports basm uh or
1:15
webassembly it has a lot of popularity and systems programming game engine
1:20
development and obviously into the blockchain ecosystem starting with Solana and a lot of the new L1 uh a lot
1:29
of the new layer one blockchains kind of popping up right now like appdos or sui
1:35
that also support trust as their main Pro or not main or but as their main or
1:41
as their programming language for developing programs there
1:46
so yeah the very first release of rust came to be in 2015 and it saw a rapid
1:53
growth uh in uh in the point that it established Its Own Foundation in 2021
1:58
which is only six years after the first release and it became a most loved
2:05
language since 2016's 2016 and rust popular popularity only
2:11
grows year by year there are many companies using rust right now and a lot of the popular
2:17
applications are written by rust but for us obviously it's Solana but you can
2:23
find difference like cloudflare or one password that are those where
2:28
fundamentals are already built on Rust programming language
2:34
so yeah that's up for the introduction and let's just let's Jump Right In and
2:39
talk about the basics of it all and that's obviously a hello world program so as you can already tell uh hello
2:47
world hello world program in Rust is very similar to hello world in pretty
2:52
much any other language so we are essentially defining our main function using an FM keyword and in that
3:00
function we are printing out the line with Hello World string so you can just go right ahead and uh
3:07
copy it into your development environment however if you have not yet set up your development environment you
3:14
can use something called rust playground I will just demo a rust playground
3:20
playground for now so essentially you can just copy different rust Snippets
3:25
and execute them directly in your browser so we have our hello world demo
3:30
already in the playground and we can just run it and see the output directly into the browser
3:37
so yeah uh so if you have not yet set up your development environment go ahead
3:43
and use rust playground but you can just go ahead and use uh whatever tools you
3:48
need to execute the Snippets that we'll be demonstrating today
3:55
in this slide we can see that we can Define variables in Rust using a lead keyword
4:01
keep in mind that rust is statically type language and that means that
4:06
compiler needs to know what type are the variables at the compile time but however in this slide we can see
4:13
that we are not explicitly defining what types of that what types are those different variables
4:19
uh this is because rust has something that is called inference engine and it's
4:25
pretty smart it does more than just looking at the type of the value expression during the
4:31
initialization but it also looks how the variable is used afterwards in the
4:36
program so that means that we can essentially Define variables without specifying the
4:42
data type let my sim really familiar to a lot of
4:47
you JavaScript developers but it's definitely not the same thing in Rust in JavaScript and many other languages
4:54
variables created with lead are mutable by default that means we can initialize
4:59
it with some value and then essentially change or re-initialize that value to a different one
5:05
uh this is however not the case in in Rust so if we take for example uh this
5:12
piece of code where I'm defining a variable called name and I'm assigning or initializing with the value Andre and
5:19
at the uh at the next line we're trying to change that value of that particular
5:25
variable this would be completely fine in JavaScript however if I try to run it in
5:31
in Rust we will end up with an error
5:36
that says we cannot assign twice to immutable variable name
5:42
this means that in Rust all variables created using let keyword are immutable
5:49
by default that means you cannot reassign their value once they already been assigned
5:55
however if I create if I create a variable and I will not assign it that
6:02
means I will assign it in into the in the next line this will still be fine in Rust we are
6:09
not mutating it we are just assigning or initializing with the value
6:15
foreign
6:21
if we get to the previous example and we want to create or make our variable
6:28
mutable we'll be doing that by adding a mut keyword which is short formutable
6:34
and if we uh add keyword mutable to to our variable
6:39
name we are then free to reassign the value so if I run it again
6:45
this will compile just fine
6:54
so if we take a look at the at this next slide we can see that we can obviously
7:01
manually specify the data types of the variable when defying it all of the standard variables types that
7:08
we know from other programming languages are available at our disposal so that means we can use assign and unsigned
7:14
integer uh floating Point types booleans characters and strings but we'll be
7:21
talking specifically about strings a little bit later so let's talk about strings in Rust
7:29
strengthen rust aren't as simple as strings in JavaScript for example in JavaScript both arrays and strings where
7:37
strings are pretty much just an array of characters are mutable and ever growing so all of us are kind of used to keep on
7:46
pushing to a string or array in JavaScript mutating its length and it works just fine
7:52
this is this is because strings in JavaScript uh JavaScript are Heap allocated and they don't have a fixed
7:58
line the this is however a little bit different in Rust so if we take this
8:03
example where we are creating a mutable list with a length of free and then we try to
8:11
reassign it to a list with a different length essentially trying to mutate the List's length this will fail
8:23
this is because arrays and rust are stack allocated and with fixed length
8:28
this doesn't mean that you can't have a collection in Rust which you can grow and Shrink with time as much as you want
8:35
it's that just it's a completely different data type that we are calling vector
8:41
so this also tells us that there will be a two different underlying types of
8:46
strings in Rust there are two so Str which is essentially a string slice
8:52
similar to an array it is fixed length and it is immutable on the other hand we have a string a
9:00
string is stored as a vector and it is used to store utf-8 data with not a
9:05
fixed lens so if we for example take our first example and we are using a
9:13
data type called SDR we can uh initialize it with some uh with some
9:20
value however we'll be unable to mutate its limb uh at the at the later stage in
9:27
the program so we are essentially tied down to this value
9:33
so this is typically what we don't want we want to have a little bit more fun with strings uh kind of resizing the
9:40
data structure and do whatever we are used to with doing with strings in different programming languages and this
9:47
is where string or data data type called string come to a help
9:53
so here you can see an example where I'm creating a mutable variable called name and we are creating a string from some
10:00
sort of uh from some sort of uh characters which in this case is ond and
10:06
then we can for example manipulate it as we are used to in different programming languages so I'm here I'm pushing here
10:13
I'm pushing more characters into the predefined string so if I run this one
10:26
okay it will work completely fine and you can see that R2 substrings are combined now
10:32
into one string so yeah our first example with the Str
10:40
data type they are uh always we are there are essentially string slides and
10:47
they are similar to array in Rust they are fixed length and unmutable the second one is a string object this
10:55
one is stored in a vector and it is used to store the utf-8 data with not a fixed
11:00
length and a little bit more freedom to work with with working with it as much as we are kind of used to from different
11:07
programming languages so let's sum up what we have learned
11:12
about data types and variables in Rust so even though rust is statically typed
11:19
language and that means compiler needs to know what types are the variables at the compile time we can create variables
11:27
without specifying its type and let the inference engine do its work
11:32
if we want to specify the type we can do it uh with the specification right after we
11:40
name our variable however in terms of naming our variable there are few rules we have to follow
11:48
letters digits and underscore characters are available for us to name our variables variables have to begin with
11:57
either a letter or an underscore and this is really important upper and
12:03
lowercase letters are distinct in terms of naming our variable and the key thing is that by default
12:10
variables are immutable which means if we want to reassign or change the value
12:16
of our variable we have to make our variable mutable by adding an mut
12:23
keyword so let's talk a bit about functions in
12:29
Rust functions in Rust are defined using an FN keyword
12:35
and with curly brackets so pretty much the structure is very similar to other programming languages we Define using an
12:42
FN keyword naming our function and then selecting the input parameters that our
12:47
function should have so in terms of we have already kind of defined our first function before in our
12:55
hello world program where we created a main function in every program which is
13:00
the main entry point but in this particular example we can see that our main function is calling a different
13:06
function called FN hello and FN hello then prints out a hello from function f
13:12
and hello so this is a like a really basic example how we can call different functions in Rust
13:19
if we want to talk about return types we have two different syntaxes that we can
13:25
use the first syntax is obviously specifying the return type with an arrow
13:30
and then returning it using a return keyword however there is some nice syntactic
13:37
sugar in Rust where we don't even have to use a return keyword to return our
13:42
value uh you you could we can totally skip the return keyword and the result of the
13:48
last expression in the function body will be returned automatically or essentially uh the the last resort
13:57
with no semicolon means that the value is automatically returned
14:02
so let's take a look at our sample here we have our main function where we are
14:08
calling our sum function which is essentially just summing the two X and Y
14:13
numbers that are in our uh that are in our function parameters and are returning a returning an unsigned 64-bit
14:21
integer so yeah if we try to execute it
14:27
you can see that we have our result value so we are essentially defining a new variable called result which will
14:34
take the return value of our sum function we can
14:40
see here that we are not even using our return keyword we're just essentially
14:46
doing x a plus Y without no semicolon this will automatically return our value
14:53
and then we are printing out the result from our variable
14:59
so let's briefly introduce a flow control and Loops in Rust
15:04
so just like any other programming language rust 2 has conditionals so both
15:09
if if else or else statements are pretty much identical to how they work in
15:15
JavaScript with two subtle differences if statements in Rust don't need
15:21
expression to be wrapped into parentheses and rust will not cast Expressions to
15:28
booleans for you like JavaScript does but if we look at a really simple sample
15:34
here let's just do this simple if condition where we are checking the value of our
15:42
variable so for example here we can see our if statement combined with some
15:48
logic operators those are obviously also available to us in Rust so you can see
15:53
that the structure of our L of our if statement is pretty much similar to the one in JavaScript and this one is
16:00
completely valid and will execute just fine so you can see that in terms of
16:06
conditionals you can carry a lot of the knowledge from a different programming language like JavaScript or pretty much
16:11
any any other programming language if we're talking about loops uh rust
16:18
obviously have loops too uh there are a few types of them and let's just introduce them briefly one by one
16:26
so uh the most basic one is essentially defining a loop using a keyword Loop so
16:34
if we do something like this we essentially create a Loop that is
16:42
equal to while true in JavaScript it is essentially uh just a simple Loop that
16:47
will be running into Infinity until some condition is met and uh we will manually
16:53
break our Loop using the break keyword so this is again something very similar
16:59
to other programming languages if we are if we want to use a different
17:04
type of loop we can for example use a while loop in Rust something that we are
17:10
well familiar with from different uh programming environment so if we do
17:15
something like a wild Loop where we are essentially adding a condition to our
17:20
Loop so the while loop uh is running until this condition is met so in this
17:26
particular case until the counter is less or equal to 10 our Loop will execute so if we run it we'll
17:32
essentially get Hello uh 10 times so yeah that's uh that's pretty much a
17:39
while loop and other really cool loop that we can use in in Rust is for in Loop for in
17:47
Loop will essentially let us Loop through um for example different elements in
17:54
Array so in this example we can see that we are looping through our La of sdrs so
18:00
my name is Andre and it will run through all of these elements and print them out line by line
18:13
so as you can see in terms of flow control and Loops you can carry a lot of the knowledge that you already have
18:19
there is uh a bit of a synthetic difference but essentially uh the basis
18:27
of flow control and Loops are pretty much the same in Rust if we want to shorten for example our if
18:34
statements we can do it by creating an inline if statement so this one is totally fine in Rust too so we can
18:42
create a condition variable and then uh we can essentially wrap our if statement
18:47
into a variable so let's Define a variable called number that will be assigned uh
18:56
that or or the value of this number variable will be assigned uh according
19:02
to this if statement so if the condition is true the value of our number will be
19:07
6 else the value will be the value will be 5 else the value will be 6. so yeah
19:13
that is totally fine in Rust two so let's talk briefly about memory
19:18
management in Rust uh when you write your code in JavaScript you never worry
19:24
about allocating and deallocating memory actually most of the JavaScript developers don't even know how to manage
19:30
memory properly memories automatically allocated under the hood when it's required by the
19:36
runtime environment and the JavaScript runtime engine usually is using
19:42
something that we call garbage collection so I believe that most of you are already familiar with the garbage
19:48
collection but essentially garbage collection is a hidden code in your runtime that is constantly keeping track
19:54
of the values in your program and checking if there are any references to them
19:59
uh when it sees that something is no longer referred to and it is marked as unnecessary it decides to deallocate it
20:07
and freed from the memory you can immediately tell that having something like this running during
20:13
runtime constantly comes at the performance cost but not only is a performance cost also as a security
20:19
concern because garbage collectors can sometimes screw up and it will result result in memory leaks
20:27
so Ross does not have a garbage collector and you are probably panicking
20:32
right now because you're familiar that c or C plus plus require programmer to
20:38
manually allocate and deallocate memory and if you're not skilled enough it can
20:43
be a really big security concern and it is really hard to master a proper memory
20:48
management so that's where borrow Checker comes in even though that the rust is not using a
20:55
garbage collector when you're riding in Rust you don't need to manually allocate or deallocate the memory it's already
21:02
taking care of you by the compiler the rust compiler automatically inserts
21:07
allocation and deallocation calls in the right places in your code and it can do
21:12
it because you have to follow strict rules about how you write your rust code and if you don't it will just not
21:18
compile so it may be hard at first but when you get the hang of it out of the nowhere
21:24
you're riding high performance and secure programs so let's learn about borrow checking and
21:29
ownership to kind of understand how memory management in Rust works
21:36
so now let's talk about bar Checker and this is what enables rust to automatically insert memory allocation
21:43
and deallocation in our code when it is compiled so to do this the bar Checker requires
21:50
us to follow this the simple concept of ownership it might be hard to understand at first but when you get the hang of it
21:58
it is pretty easy and it will help you write a secure and high performing code so we have prepared this simple test how
22:06
we can demonstrate the ownership in in just a brief snippet
22:12
so for example we have a main function that where we're defining a test
22:17
variable it is essentially string from this characters which is a testing
22:22
and then we passing our variable into the owner one and owner one function
22:28
will print out our variable so if we run this everything should work out fine
22:36
so you can see that the owner one uh print out the string that we wanted
22:41
but what if we do this thing so uh we ask owner one to print out the string
22:47
and we will ask our owner to function to essentially to essentially do the same
22:54
thing
23:01
and this is where we run into some issues and why is that uh it is because
23:07
one simple rule that we have to follow in Rust and that is every value in Rust must have a single owner and to kind of
23:15
demand demonstrate the ownership when we initialize the variable test
23:20
the string value testing is owned by our test variable then on
23:27
the next line we are passing our variable to owner one function and by
23:33
doing that we move our variable to owner one and at this point this variable is
23:39
no longer owned by our main function and it is owned by owner one this is what we
23:44
call a transferring of the ownership so the value is only owned by one hour
23:52
owner and the owner is responsible for deallocating the memory and that's where
23:59
the uh and it it deallocates it when the owner goes out of the scope
24:04
so essentially the owner is the error is telling us that we no longer have access
24:11
to our variable because we already moved it to a different owner and it just
24:17
essentially stuck there and we cannot work with our variable anymore
24:22
so how can we solve this we have two different ways of solving
24:27
this and the first one is bypassing the immutable references so uh we can create immutable references
24:36
very easily and that is essentially just by adding an ampersand before our data
24:42
type which is not which is now saying it is a reference to a string variable
24:49
and if we are expecting a reference we obviously have to hand over a reference
24:55
not the variable so we'll be handing out the reference to our test variable
25:00
so by doing this it should essentially fix our problem in this uh particular
25:08
case so yeah as you can see right now the
25:14
owner one and owner to print out the print out the string so by passing uh
25:21
the references we are essentially bending the rule that I mentioned before that every value in Rust must have a
25:27
single owner we are kind of bending it into a into a fact that
25:34
um a value can have any number of immutable or mutable references to it so but
25:42
bypassing an immutable reference it automatically tells us that we cannot
25:47
change uh the the variable from the immutable reference so what if we want
25:53
to change the value of our reference we can do that by passing mutable
25:59
references so I have pre prepared a different snippet of code to kind of demonstrate this we
26:07
have a simple main function and this main function has a mutable variable called greetings that is kind
26:14
of constructing hi my name is uh from from these characters into a string then
26:20
we want to mutate it the mutation will happen in a different function that is called mutate the mutate will push
26:28
string Andre into the greetings so essentially in the end it should print out hi my name is Andre
26:35
so you can immediately tell that we are again using ampersands to mention that
26:43
we are passing a reference and adding an mut as a mutable reference
26:48
a big warning here that if we are passing a mutable reference we have to
26:53
uh or we have to it we have to create a mutable reference to immutable variable
27:00
in the first place because if the variable is immutable and cannot be changed immutable reference would be
27:07
just completely meaningless so if we try to run this code everything should work out just fine
27:18
yeah so uh you see that we have uh hi my name is Andre ducana expand a little bit
27:24
on this let's just add a second mutate function and push another string just
27:32
some exclamation marks and we can run both of these mutation
27:37
strings and we should be all good
27:46
and as you can see uh we have passed the mutable reference to two different functions without passing the ownership
27:53
we have added a string in both of these functions and at the end we still had
27:58
access to our greeting strings so this is just a simple demo how ownership or
28:05
how ownership which is the basis for borrow Checker Works in Rust
28:12
so what have we learned about the ownership rules and memory management in Rust
28:17
each value in Rust has a variable that's called its owner every value in Rust have a single owner
28:26
and when the owner goes out of scope the value will be dropped and essentially marked as inactive and deleted from the
28:34
memory if we want to pass our values we can do it by using a references these
28:42
references can be immutable or mutable and the value can have any number of
28:47
references to it if we'll be passing an immutable reference please make sure
28:53
that we are passing a mutable reference to a mutable variable or a mutable value
29:00
so let's briefly touch on slices in the rust so
29:05
an array in Rust is a collection of objects of the same type and we are
29:11
defining and using the brackets we are specifying the data type and their length and the length of the array is
29:18
always known at the compile time slices on the other hand are similar to
29:25
a race but their length is not known at the compiled time instead a slice is
29:31
kind of a two-word object where the first word is a pointer to our array
29:37
that we are slicing and the second word is the length of the slice
29:43
a great example of a previous explanation is the Str type that we did
29:48
in the string section because we're calling Str a string slice as it is
29:54
exactly what it represents it's essentially a pointer to some memory that is including a valid udfa data
30:02
hence why string slice is not Global or mutable in any way because it is baked
30:08
in the binary itself so yeah and uh slices are obviously not
30:14
reserved for Strings only uh we will probably use them mostly on vectors or array
30:20
so to demonstrate this let's borrow an example from the rust documentation
30:26
so as we can see in the main function we are defining our array of numbers and we
30:33
can work with this array as we are kind of used to in JavaScript so for example we can print out values at the different
30:40
indexes so essentially just indexing Stars at the zero that's pretty
30:45
much classic and we can print out any of the values in the array for example we can also print out a
30:53
count of the elements or the array length so we can just do some of these
30:58
very familiar operations on the array in Rust 2. however uh
31:04
we can also borrow the array automatically as a slice and to do so
31:09
we just specify pointer to our array and then specify
31:16
the uh length of the slice that we want to do and we have these analyze slides
31:22
function to kind of perform all of the operations we're kind of used to on doing on the standard array we can also
31:30
do it on as a slice but we are obviously working only with the borrowed data so
31:36
if we run this example you can see that we did some of these
31:44
array operations on the whole array then we borrowed the array as a slice and did
31:50
the same operation only on the element that we borrowed using the slice
31:55
so let's briefly touch on how we can create structures in Rust there are three types of structures or
32:02
also shortly called structs that we can create using the struct keyword so as you can see the we are using
32:10
struct keyword to create a new structure we set the name of the structure and
32:15
using the curly brackets to set up the fields of the structure this is pretty similar to how we Define functions and
32:22
everything else in the rust so uh about the three different uh types
32:27
of structures uh there are Tuple structs which essentially are just name tuples or a pairs of two values a classic
32:36
c-structs that we are seeing on the screen right now so we are essentially gonna create uh different fields with
32:43
different data types for the structure and also uh unit structs which are
32:48
fieldless but are useful for generics so let's just demonstrate it real quick
32:59
so in this code we can see how we Define a unit structure as you can see they are
33:04
fieldless to construct Tuple struck is essentially a pair so here is a pair of integer at float and then we have a
33:11
struct or C like structure with Fields so in our main function we can see that we
33:18
are creating a new variable of of a point which is our structure and we are
33:24
setting up the chord in its X and Y to different values after we instantiate the point we can
33:30
def we can just easily work with its Fields so here we can see it demonstrated in the print line we are
33:36
printing out the coordinates X and Y from our point that we have previously created
33:44
foreign
33:50
so as you can see you are essentially creating structs very similarly to any other programming languages that do uh
33:57
enable us to create structures so next just briefly touch on
34:03
enumerators or enums uh enorms are essentially we are defining them using
34:10
an enum keyword and this allows us a creation of a type which may have one of
34:15
few different variants so this is a essentially demonstrations of Direction and we can see that uh
34:22
our different variants are up down left and right it's also worth pointing out that any
34:30
variant which is a valid as a struct is also valid as an enum
34:35
so this was just a brief introduction to enums and structs in Rust and as you can see if you know how to handle these from
34:41
any different programming languages they easily carry to rust also thank you for
34:47
attending today's lecture and now I will hand it over to my colleague to give you
34:52
details about our next assignment hello everyone so now that you have
34:58
learned how to use rust and the basics of rusts we have prepared our next task
35:04
for you you will have to finish an implementation of a calculator so it is
35:10
a simple calculator written in Rust again the repository will be on GitHub
35:17
classroom so we will share the link after this lesson on on Discord and you will also learn
35:24
something new you will learn about trades so it's basically an equivalent of interfaces in other languages
35:32
but don't worry you will have enough information in in readme
35:39
and to pass this task you have to pass the tests or your implementation and
35:46
basically you can test it very easily with the cargo test command that will
35:52
automatically run the tests so if you will pass the tests then you
35:59
should be all right and as always if you will have any questions don't hesitate to ask on
36:06
Discord so thank you very much for today I hope you enjoyed uh today's lecture and have
36:14
fun with the task and see you next time goodbye


