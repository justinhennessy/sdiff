Puppet sdiff module
=====

A puppet module for suppressing diff output based on file and line patterns

Notes:
=====

Installation:
=====

Install in your puppet master's modulepath as a directory named 'sdiff'.

```ruby
include sdiff
```

You will need to add the following to your puppet.conf

```ruby
[main]
.
.
.
.
diff=/usr/local/bin/cdiff
diff_args=-u
```

Usage:
=====

Contributors:
=====

Justin Hennessy (@justinhennessy) - Module creator

Alexandra Spillane (@) - Script teamplate creator
