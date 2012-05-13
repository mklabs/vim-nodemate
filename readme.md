
# vim node

Collection of snippets, utilities and custom completion for node.

*work in progess*

## Installation

**Install for [pathogen](https://github.com/tpope/vim-pathogen)**

```sh
cd ~/.vim/bundle
git clone git://github.com/mklabs/node.snipmate.git
```

## Documentation

**What it does**

---

Node omni-omnicompleter.

`:h new-omni-completion`.

> This could also be called "intellisense", but that is a trademark.

Should auto-complete whenever the text in front of the cursor includes
one of node's core modules:

```js
var core = [
  'assert', 'buffer', 'child_process', 'cluster', 'console',
  'constants', 'crypto', 'dgram', 'dns', 'events', 'freelist',
  'fs', 'http', 'https', 'module', 'net', 'os', 'path',
  'punycode', 'querystring', 'readline', 'repl', 'stream', 'string_decoder',
  'sys', 'timers', 'tls', 'tty', 'url', 'util', 'vm', 'zlib'
];
```

It works by inspecting the current line below the cursor for a match to
a known node module, in which cashe the given module is required, on
which `Object.keys()` is called to complete with a list of match.

Use `CTRL-X CTRL-U` in Insert mode to start the completion, when the
cursor in in front of something like:

    fs.*
    fs.read*
    path.*

The plugin also map the `<C-Space>` (Ctrl+space) to trigger the same
omnicompletion.


## Snippets

[http://nodejs.org/api/documentation.html](http://nodejs.org/api/documentation.html])

> Every .html document has a corresponding .json document presenting the
> same information in a structured manner. This feature is experimental,
> and added for the benefit of IDEs and other utilities that wish to do
> programmatic things with the documentation.


The whole nodejs documentation is available as `.json`, this allow us to
do some awesome things with these information.. like generating a bunch
of [snipmate](http://www.vim.org/scripts/script.php?script_id=2540)
snippet.

Snippet generated from nodejs.org/api/ are all placed in a subdirectory
`snippets/javascript/<trigger>/<name>.snippet' to allow multiple matches
using `*.snippet` files.

## Example: assert`<tab>`

For instance, typing the `assert` trigger word followed by a `<tab>` would
display the list of snippets for the `assert` module:

```sh
1. deepEqual
2. doesNotThrow
3. equal
4. fail
5. ifError
6. notDeepEqual
7. notEqual
8. notStrictEqual
9. ok
10. strictEqual
11. throws
Type number and <Enter> or click with mouse (empty cancels):
```

Snippets placeholder are also generated from the information provided by
nodejs' api as json, with the list of paramaters for each method.

## List

Want to see the full list of almost 200 snippets generated? Here it is!

```sh
├── assert
│   ├── deepEqual.snippet
│   ├── doesNotThrow.snippet
│   ├── equal.snippet
│   ├── fail.snippet
│   ├── ifError.snippet
│   ├── notDeepEqual.snippet
│   ├── notEqual.snippet
│   ├── notStrictEqual.snippet
│   ├── ok.snippet
│   ├── strictEqual.snippet
│   └── throws.snippet
├── child_process
│   ├── exec.snippet
│   ├── execFile.snippet
│   ├── fork.snippet
│   └── spawn.snippet
├── console
│   ├── assert.snippet
│   ├── dir.snippet
│   ├── error.snippet
│   ├── info.snippet
│   ├── log.snippet
│   ├── time.snippet
│   ├── timeEnd.snippet
│   ├── trace.snippet
│   └── warn.snippet
├── crypto
│   ├── createCipher.snippet
│   ├── createCipheriv.snippet
│   ├── createCredentials.snippet
│   ├── createDecipher.snippet
│   ├── createDecipheriv.snippet
│   ├── createDiffieHellman.snippet
│   ├── createHash.snippet
│   ├── createHmac.snippet
│   ├── createSign.snippet
│   ├── createVerify.snippet
│   ├── pbkdf2.snippet
│   └── randomBytes.snippet
├── dgram
│   └── createSocket.snippet
├── dns
│   ├── lookup.snippet
│   ├── resolve.snippet
│   ├── resolve4.snippet
│   ├── resolve6.snippet
│   ├── resolveCname.snippet
│   ├── resolveMx.snippet
│   ├── resolveNs.snippet
│   ├── resolveSrv.snippet
│   ├── resolveTxt.snippet
│   └── reverse.snippet
├── fs
│   ├── chmod.snippet
│   ├── chmodSync.snippet
│   ├── chown.snippet
│   ├── chownSync.snippet
│   ├── close.snippet
│   ├── closeSync.snippet
│   ├── createReadStream.snippet
│   ├── createWriteStream.snippet
│   ├── fchmod.snippet
│   ├── fchmodSync.snippet
│   ├── fchown.snippet
│   ├── fchownSync.snippet
│   ├── fstat.snippet
│   ├── fstatSync.snippet
│   ├── fsync.snippet
│   ├── fsyncSync.snippet
│   ├── futimes.snippet
│   ├── futimesSync.snippet
│   ├── lchmod.snippet
│   ├── lchmodSync.snippet
│   ├── lchown.snippet
│   ├── lchownSync.snippet
│   ├── link.snippet
│   ├── linkSync.snippet
│   ├── lstat.snippet
│   ├── lstatSync.snippet
│   ├── mkdir.snippet
│   ├── mkdirSync.snippet
│   ├── open.snippet
│   ├── openSync.snippet
│   ├── read.snippet
│   ├── readFile.snippet
│   ├── readFileSync.snippet
│   ├── readSync.snippet
│   ├── readdir.snippet
│   ├── readdirSync.snippet
│   ├── readlink.snippet
│   ├── readlinkSync.snippet
│   ├── realpath.snippet
│   ├── realpathSync.snippet
│   ├── rename.snippet
│   ├── renameSync.snippet
│   ├── rmdir.snippet
│   ├── rmdirSync.snippet
│   ├── stat.snippet
│   ├── statSync.snippet
│   ├── symlink.snippet
│   ├── symlinkSync.snippet
│   ├── truncate.snippet
│   ├── truncateSync.snippet
│   ├── unlink.snippet
│   ├── unlinkSync.snippet
│   ├── unwatchFile.snippet
│   ├── utimes.snippet
│   ├── utimesSync.snippet
│   ├── watch.snippet
│   ├── watchFile.snippet
│   ├── write.snippet
│   ├── writeFile.snippet
│   ├── writeFileSync.snippet
│   └── writeSync.snippet
├── http
│   ├── createServer.snippet
│   ├── get.snippet
│   └── request.snippet
├── https
│   ├── createServer.snippet
│   ├── get.snippet
│   └── request.snippet
├── net
│   ├── connect.snippet
│   ├── createConnection.snippet
│   ├── createServer.snippet
│   ├── isIP.snippet
│   ├── isIPv4.snippet
│   └── isIPv6.snippet
├── os
│   ├── arch.snippet
│   ├── cpus.snippet
│   ├── freemem.snippet
│   ├── hostname.snippet
│   ├── loadavg.snippet
│   ├── networkInterfaces.snippet
│   ├── platform.snippet
│   ├── release.snippet
│   ├── totalmem.snippet
│   ├── type.snippet
│   └── uptime.snippet
├── path
│   ├── basename.snippet
│   ├── dirname.snippet
│   ├── exists.snippet
│   ├── existsSync.snippet
│   ├── extname.snippet
│   ├── join.snippet
│   ├── normalize.snippet
│   ├── relative.snippet
│   └── resolve.snippet
├── process
│   ├── chdir.snippet
│   ├── cwd.snippet
│   ├── exit.snippet
│   ├── getgid.snippet
│   ├── getuid.snippet
│   ├── kill.snippet
│   ├── memoryUsage.snippet
│   ├── nextTick.snippet
│   ├── setgid.snippet
│   ├── setuid.snippet
│   ├── umask.snippet
│   └── uptime.snippet
├── querystring
│   ├── parse.snippet
│   └── stringify.snippet
├── readline
│   └── createInterface.snippet
├── repl
│   └── start.snippet
├── timers
│   ├── clearInterval.snippet
│   ├── clearTimeout.snippet
│   ├── setInterval.snippet
│   └── setTimeout.snippet
├── tls_(ssl)
│   ├── connect.snippet
│   ├── createSecurePair.snippet
│   └── createServer.snippet
├── url
│   ├── format.snippet
│   ├── parse.snippet
│   └── resolve.snippet
├── util
│   ├── debug.snippet
│   ├── format.snippet
│   ├── inherits.snippet
│   ├── inspect.snippet
│   ├── isArray.snippet
│   ├── isDate.snippet
│   ├── isError.snippet
│   ├── isRegExp.snippet
│   ├── log.snippet
│   └── pump.snippet
├── vm
│   ├── createContext.snippet
│   ├── createScript.snippet
│   ├── runInContext.snippet
│   ├── runInNewContext.snippet
│   └── runInThisContext.snippet
└── zlib
    ├── createDeflate.snippet
    ├── createDeflateRaw.snippet
    ├── createGunzip.snippet
    ├── createGzip.snippet
    ├── createInflate.snippet
    ├── createInflateRaw.snippet
    ├── createUnzip.snippet
    ├── deflate.snippet
    ├── deflateRaw.snippet
    ├── gunzip.snippet
    ├── gzip.snippet
    ├── inflate.snippet
    ├── inflateRaw.snippet
    └── unzip.snippet
```

