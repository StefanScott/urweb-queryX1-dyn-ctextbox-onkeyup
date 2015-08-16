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

---

There are a few caveats:

(1) I have no idea if this is best / proper way to wire the signal and source together.

(2) Ideally, the page should be able to display *all* the records when it initially loads.

I tried to do this by copying the code from the `<ctextbox onkeyup={...}` to <body onload={...}> - but I got error messages.

(2) Since a signal is *automatically* updated when its source changes (without the need to write any `on_` event code), it feels kinda kludgy to be using the `onclick` event of the the `<ctextbox>`.

So I wonder if there is a way to update the recordset simply in response to the use typing in the `<ctextbox>` - without using an `on_` event anywhere.

This has been done for another example - but that example used only client-side data:

https://github.com/StefanScott/urweb-ctextbox-echo

So I'm not sure if the present example, which involves reading data from the server-side (ie, running queryX1), can be done without using an `on_` event - because of the two questions below:

Question (1)

For an example like this, which does a transactional "read" (but no transacational "write") on the server (ie: it uses `queryX1`), is it *obligatory* to have a "blocking" call to `rpc` somewhere in the code?

Question (2)

If the answer to (1) is "YES", then does this further imply that a control *must* be used which has an `on_` event (eg, currently the `onkeyup` event of the `<ctextbox>` control) - simply because it's necessary to have an event in which make the call to `rpc`? 

I suspect the answer *may* "NO" here - eg, maybe the call to `rpc` could be done from inside a `<dyn>` tag, which would obviate the need for an `on_` event.

I've been trying this, but so far have not gotten it to work.

Question (3)

Are...

- the "typing requirements" for the code inside the `signal` attribute of a `<dyn>` tag

...different from...

- the "typing requirements" for the code inside an `on_` event attribute of a `<button>` tag?

Minor issue:

The `LIKE` operator in Postgres is case-sensitive. There is also a non-case-sensitive version `ILIKE`, but it hasn't been implemented yet. Of course, a case-insensitive pattern-match could be done using a work-around: before searching, simple convert the search string to all lower-case (or all upper-case), and then while searching, convert the column being searched to all lower-case (or all upper-case). 

It would also be interesting to see if this is the kind of thing (eg, support for Postgres ILIKE - plus whatever the corresponding operator is in MySQL) which an "end user" could add to the Ur/Web compiler themselves. 

###

