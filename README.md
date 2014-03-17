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

You will need to add the following to your puppet.conf on each agent

```ruby
[main]
.
.
.
.
diff=/usr/local/bin/sdiff
diff_args=-u
```

Usage:
=====

```
class { 'sdiff':
  color        => false,
  file_pattern => '\.env',
  line_pattern => 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$',
}
```

```
sdiff::file_pattern: '\.env'
sdiff::line_pattern: 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$'
```

Contributors:
=====

Justin Hennessy (@justinhennessy) - Module creator

Alexandra Spillane (@ajbw) - Script template creator
