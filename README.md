# urweb-queryX1-dyn-ctextbox-onkeyup

This compiles and runs more-or-less correctly now.

The working code for the present example is in this GitHub repo:

https://github.com/StefanScott/urweb-queryX1-dyn-ctextbox-onkeyup

Note: Currently, you have to add the records to the table using psql, etc. (ie, there is no web interface to add records yet).

Actually there is also a script called `insert.sql` which will add the 50 US states for you.

The file `script.txt` contains all the Linux commands to:

- get this compiled, 
- (optionally drop and) create the database, and
- (optionally) insert the 50 US states

using Postgres as the database.

[screenshot](screenshot.png)

---

There are a few caveats:

(1) This is basically my first attempt at FRP, so I have no idea if this is best / proper way to wire the source and signal together.

(2) Ideally, the page should be able to display *all* the records when it initially loads.

I tried to do this by copying the code from `<ctextbox onkeyup={...}` to `<body onload={...}>` - but I got error messages.

(2) Since a signal is *automatically* updated when its source changes (without the need to write any `on_` event code), it feels kinda kludgy to be using the `onclick` event of the the `<ctextbox>`.

So I wonder if there is a way to update the recordset simply in response to the user typing in the `<ctextbox>` - without using an `on_` event anywhere.

This has been done for another example - but that example used only client-side data:

https://github.com/StefanScott/urweb-ctextbox-echo

So I'm not sure if the present example, which involves reading data from the server-side (ie, running `queryX1`), can be done without using an `on_` event - because of the questions below:

Question (1)

For an example like this, which does a transactional "read" (but no transacational "write") on the server (ie: it uses `queryX1`), is it *obligatory* to have a "blocking" call to `rpc` somewhere in the code?

Question (2)

If the answer to (1) is "YES", then does this further imply that a control *must* be used which has an `on_` event (eg, currently the `onkeyup` event of the `<ctextbox>` control) - simply because it's necessary to have an `on_` event somewhere, in which make the call to `rpc`? 

I suspect the answer  to (2) *may* "NO" here - eg, maybe the call to `rpc` could be done from inside a `<dyn>` tag, which would obviate the need for an `on_` event.

I've been trying this, but so far have not gotten it to work - I keep getting type errors. (I think the result type of an `on_` event is `transaction unit` - whereas the result type of the code in the `signal` attribute of a `<dyn>` is `signal xml` - so this may be causing the type errors). 

---

Minor quibble:

The `LIKE` operator in Postgres is case-sensitive. There is also a non-case-sensitive version `ILIKE`, but it does not appear to have been implemented yet in Ur/Web. 

Of course, a case-insensitive pattern-match could be done using a work-around: eg, before searching, simple convert the search string to all lower-case (resp. all upper-case), and then while doing the search, also convert the column being searched to all lower-case (resp. all upper-case). 

I imagine that it might not be too difficult for a programmer to add support for Postgres `ILIKE` (plus whatever the corresponding operator is in MySQL) to the Ur/Web compiler.

---

Thanks for any feedback. It feels really cool to see Ur/Web using FRP to instantly filter records like this!

###

