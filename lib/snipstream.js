

var fs = require('fs'),
  path = require('path'),
  util = require('util'),
  stream = require('stream'),
  fstream = require('fstream');

module.exports = SnipStream;

// This is the stream generator for all of our
// generated snippets, from doc as json format

function SnipStream(o) {
  o = o || {};
  this.readable = true;
  this.writable = true;
  this.chunks = [];
  this.path = path.join(__dirname, '../snippets/javascript');
  stream.Stream.call(this);

  var self = this;
  this.on('pipe', function(src) {
    self.src = src;
  });
}

util.inherits(SnipStream, stream.Stream);

SnipStream.prototype.write = function(chunk) {
  this.chunks = this.chunks.concat(chunk);
};

SnipStream.prototype.end = function() {
  var self = this,
    json = JSON.parse(this.chunks.join('')),
    mods = json.modules || json.globals,
    ln = mods.length;

  mods.forEach(function(m) {
    m.snipdir = self.path;
    new SnipEntry(m).on('end', function() {
      if(--ln) return;
      self.emit('end');
    });
  });
};

function SnipEntry(m) {
  this.writable = true;
  stream.Stream.call(this);
  console.log('Generate', m.name, 'in', m.snipdir);
  console.log('Methods: ', Object.keys(m.methods || {}).length);
  console.log('Classes: ', Object.keys(m.classes || {}).length);

  if(!m.methods) return;
  m.methods.forEach(function(method) {
    var out = fstream.Writer(path.join(m.snipdir, m.name, method.name + '.snippet'));
    var sign = method.signatures[0],
      params = sign.params;

    var body = method.textRaw;
    params.forEach(function(p, i) {
      // cleanup trailing `)` (occuring on assert.ok);
      p.name = p.name.replace(/\)$/, '');
      // assert.ok kinda buggy, cause by a textRaw with two signatures
      if(/\(/.test(p.name)) return;
      var reg = new RegExp(p.optional ? '\\[' + p.name + '\\]' : p.name, 'g');
      // only split after a '(' for arguments, as p.name might match something before
      var parts = body.split('(');
        args = parts[1] || '';
      body = parts[0] + '(' + args.replace(reg, function(m) {
        return '${' + (i + 1) + ':' + p.name + '}';
      });
    });

    out.write(body + '\n');
  });

  console.log();
}

util.inherits(SnipEntry, stream.Stream);

SnipEntry.prototype.write = function(chunk) {

};

SnipEntry.prototype.end = function() {

};
