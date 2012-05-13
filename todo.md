

**todo**: bunch of stuff.

At first, was just a collection of snipmate snippets for node, generated
from nodejs.org api doc.

Might very well ends up in slightly more featured plugin.

---

nodejs api helpfile, generated from nodejs.org/api/*.markdown. very much
like how snippets are generated, but for documention.

Should provide the full node api as `h node-*`

---

Easier navigation.

"goto file" should know about some related to node context, like `gf` in
a require.

```js
var someModule = require('../relat*ive');
``

`*` is the cursor position. Hitting `gf` should go to the relative file
automatically.

Would be nice if it works too with node_modules dependencies (by
`require.resolve`-ing the given module).

Same for node's core module, hitting gf near a `require('fs')` should
automatically open the given source file from
`https://github.com/joyent/node/blob/<node-version>/fs.js`


---

npm wrapper

For commands that make sense, provides a set of commands to work with
npm from vim.

* see a npm's package readme (`npm info readme`) in a local buffer.

* `:NpmExplore` opens in a new buffer the modules dependencies (`npm ls`),
  with local to buffer mapping to jump to next / previous dep, to cd in
  the given package directory, to view / list the package dependencies,
  ...

* `:NpmTest` wrapper to `npm test` script. A failed run should open the
  relevant error in the quickfix window.

* `:NpmSearch` basically searching for package like if it was done on
  http://search.npmjs.org/

* `:NpmScript` wrapper to `npm run-script`.

---

node repl

from inside a vim buffer with some special mapping.

- `<Ctrl+R>` execute the whole buffer
  - should accept visual range, in which case only selected lines are
    evaluated.

- a readline mode
  - last line in buffer starting with `>>` is evaluated, output is
    displayed right below the last `>>` line.






