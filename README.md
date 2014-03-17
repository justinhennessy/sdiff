Puppet sdiff module
=====

A puppet module for suppressing diff output based on file and line patterns

Notes:
=====

Installation:
=====

Install in your puppet master's modulepath as a directory named 'sdiff'. This will use
the defaults or hiera if it has been configured.

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

For use with Hiera simply configure the following keys:

```
sdiff::file_pattern: '\.env'
sdiff::line_pattern: 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$'
```

If you want to pass in the values to the module, that is done as below:

```
class { 'sdiff':
  color        => false,
  file_pattern => '\.env',
  line_pattern => 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$',
}
```

When a file pattern is matched, sdiff will change

```
Notice: /Stage[main]//Node[vm6.edheroy.com]/Apps::Application[supporter]/File[/var/www/apps/supporter/shared/config/staging.env]/content:
--- /var/www/apps/supporter/shared/config/staging.env 2014-02-14 05:47:12.000000000 +0000
+++ /tmp/puppet-file20140218-25927-1tcg13c-0  2014-02-18 07:48:49.000000000 +0000
@@ -78,8 +78,7 @@
 TWITTER_KEY=gqZzxxxxxxxxxxxecw
 TWITTER_SECRET=xxxxxxxjE0qxxxxxxxxxxnRccTHxxxxxxxx0kN6Ag
 USE_SSL=true
-VOLUNTEERMATCH_API_KEY=cdxxxxxxxxxxc85e4077xxxxxxxxxx0026a
-VOLUNTEERMATCH_ENDPOINT=http://domain.com/api/call
+VOLUNTEERMATCH_API_KEY=70dxxxxxxxxxx8968e1xxxxxxxx05
+VOLUNTEERMATCH_ENDPOINT=http://domain2.com/api/call
 VOLUNTEERMATCH_USER=username
 ZENDESK_ENABLED=true
```

to

```
Notice: /Stage[main]//Node[vm6.edheroy.com]/Apps::Application[supporter]/File[/var/www/apps/supporter/shared/config/staging.env]/content:
Suppressing potentially sensitive diff of /var/www/apps/supporter/shared/config/staging.env vs /tmp/puppet-file20140314-24647-eem4az-0.
```

Line supression works similar but will only suppress matching lines.

Contributors:
=====

Justin Hennessy (@justinhennessy) - Module creator

Alexandra Spillane (@ajbw) - Script template creator
