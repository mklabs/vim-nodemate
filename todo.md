
## Generate Helpfiles

and this should be done dynamically from json files on nodejs.org/api/
for easy update with a single command.

basically the same as
https://github.com/mklabs/vim-backbone/blob/master/bin/gendoc /
https://github.com/mklabs/vim-backbone/blob/master/doc/backbone.txt

and then add a convenient command to jump to relevant part of the docs
based on file under cursor:

`f*s.readFile` -> leads to :h node-fs
`fs.re*adFile` -> leads to :h node-fs-readFile

----

even a basic one

figure out how to wrap snipmate in some way.

* needs alias

* better completion, when `fs.r<tab>` then should expand the list of
  snippets for `fs.r*`

* a `gf` like command to open appropriate part of node api doc with
  whatever is under the cursor.

* some commands to open and browse website api doc, or source on github.
  Something like :OpenURL
([ex](https://github.com/tpope/tpope/blob/master/.vimrc#L213-228))

* npm wrapper

* and a bunch of other idea I'll have, maybe.

---

:Node command

Minimalist command wrapper for node. Without args, equivalent to `:!node %` (eg. execute the current file)

Should accept range (default whole file). If range, execute only
specified line (handy to test a given snippet of code, I guess)

---

