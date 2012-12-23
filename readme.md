# vim nodemate

Collection of snippets, utilities and custom completion for node.

*work in progess*

## Installation

**Install for [pathogen](https://github.com/tpope/vim-pathogen)**

```sh
cd ~/.vim/bundle
git clone git://github.com/mklabs/node.snipmate.git
```

You need [snipmate](https://github.com/msanders/snipmate.vim) plugin
installed to be able to expand the bult-in generated snippets.

## Snippets

[http://nodejs.org/api/documentation.html](http://nodejs.org/api/documentation.html])

> Every .html document has a corresponding .json document presenting the
> same information in a structured manner. This feature is experimental,
> and added for the benefit of IDEs and other utilities that wish to do
> programmatic things with the documentation.


The whole nodejs documentation is available as `.json`, this allow us to
do some fancy things with this information.. like generating a bunch of
snipmate snippet.

Snippet generated from nodejs.org/api/ are all placed in a subdirectory
`snippets/javascript/<module>/<name>.snippet`

To regenerate the list of snippet, simply cd into the plugin location
(usually `~/.vim/bundle/nodemate/`) and run `npm install` (this will
install devDepencies and trigger the `./bin/generate` script)


In addition, these snippets files are used to setup the omni-completion
below.

## Omni Completion

See:

* `:h new-omni-completion`
* `:h complete-functions`

This plugin enables and setup, for the `javascript` filetype, both
`completefunc` and `omnifunc` to complete against the list of built-in snippet
files, **or** if no snippets where found, using `require.resolve('...')` plus
object introspection with `Object.keys(require('...'))`.

It should auto-complete whenever the text in front of the cursor includes one
of node's core modules, *or* any npm installed module. (as long as
`require.resolve()` returns the module being completed)

Use `CTRL-X CTRL-O` in Insert mode to start the completion, when the
cursor in in front of something like:

    fs.*
    fs.read*
    path.*

    # npm install request
    request.*

### Preview window

If `"preview"` appears in your `completeopts` options, then it shows
extra information about the currently selected completion in the preview
window.

For snippet based completion, the preview window will show the the snippet
content.

When using `require.resolve()`, then the preview window will show the result of
String conversion of `require(':module')['property']`. In the case of methods,
it will show you the function signature and content, which can be incredibly
usefull.

## List of Snippets

Here is the full list of generated snippets, available for both snippet
expands or omni-completion.

    .
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
    │   ├── getDiffieHellman.snippet
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
    │   ├── appendFile.snippet
    │   ├── appendFileSync.snippet
    │   ├── chmod.snippet
    │   ├── chmodSync.snippet
    │   ├── chown.snippet
    │   ├── chownSync.snippet
    │   ├── close.snippet
    │   ├── closeSync.snippet
    │   ├── createReadStream.snippet
    │   ├── createWriteStream.snippet
    │   ├── exists.snippet
    │   ├── existsSync.snippet
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
    │   ├── createClient.snippet
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
    │   ├── tmpDir.snippet
    │   ├── totalmem.snippet
    │   ├── type.snippet
    │   └── uptime.snippet
    ├── path
    │   ├── basename.snippet
    │   ├── dirname.snippet
    │   ├── extname.snippet
    │   ├── join.snippet
    │   ├── normalize.snippet
    │   ├── relative.snippet
    │   └── resolve.snippet
    ├── process
    │   ├── abort.snippet
    │   ├── chdir.snippet
    │   ├── cwd.snippet
    │   ├── exit.snippet
    │   ├── getgid.snippet
    │   ├── getuid.snippet
    │   ├── hrtime.snippet
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
    │   ├── error.snippet
    │   ├── format.snippet
    │   ├── inherits.snippet
    │   ├── inspect.snippet
    │   ├── isArray.snippet
    │   ├── isDate.snippet
    │   ├── isError.snippet
    │   ├── isRegExp.snippet
    │   ├── log.snippet
    │   ├── print.snippet
    │   ├── pump.snippet
    │   └── puts.snippet
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

    22 directories, 205 files

