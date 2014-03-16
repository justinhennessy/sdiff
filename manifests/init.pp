# == Class: cdiff
#
# This class adds a wrapper for the diff command puppet uses as well as puppet.conf
# updates that are needed for puppet to use it on each node including the master.
# It introduces the ability to suppress diff output, useful for encrypted data.
#
# This module requires changes to the puppet.conf file that is on the agents,
# suggest under the [main] section.
#
# diff=/usr/local/bin/cdiff
# diff_args=-u
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#   * System modifications (if any) will be reverted as good as possible
#     (e.g. removal of created users, services, changed log settings, ...).
#   * This is thus destructive and should be used with care.
#   Defaults to <tt>present</tt>.
#
# [*file_pattern*]
#   String. The pattern that is used to determine which files not to show
#   diffs for. This value can be configured in hiera using the cdiff::pattern
#   key.
#   Defaults to <tt>\.eyaml</tt>.
#
# [*line_pattern*]
#   String. The pattern that is used to determine lines in a diff to not
#   show diffs for.  This value can be configured in hiera using the
#   cdiff::line_pattern key.
#
#   Example:
#   cdiff::line_pattern: 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$'
#
#   Defaults to <tt>false</tt>.

class cdiff(
  $ensure       = present,
  $file_pattern = hiera('cdiff::file_pattern',false),
  $line_pattern = hiera('cdiff::line_pattern',false),
) {

  $file_ensure = $ensure ? {
    present => file,
    default => present,
  }

  file { '/usr/local/bin/cdiff':
    ensure  => $file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('cdiff/cdiff.erb'),
  }
}
