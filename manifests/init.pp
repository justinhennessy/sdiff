# == Class: sdiff
#
# This class adds a wrapper for the diff command puppet uses.
# It introduces the ability to suppress diff output, useful for encrypted data.
#
# This module requires changes to the puppet.conf file that is on the agents,
# suggest under the [main] section.
#
# diff=/usr/local/bin/sdiff
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
# [*color*]
#   Boolean. Optionally color line in diff output (red for deletions, green for
#   insertions and yellow for supression).
#   Defaults to <tt>true</tt>.
#
# [*file_pattern*]
#   String. The pattern that is used to determine which files not to show
#   diffs for. This value can be configured in hiera using the sdiff::file_pattern
#   key.
#
#   Example:
#   sdiff::file_pattern: '\.env'
#
#   Defaults to <tt>false</tt>.
#
# [*line_pattern*]
#   String. The pattern that is used to determine lines in a diff to not
#   show diffs for.  This value can be configured in hiera using the
#   sdiff::line_pattern key.
#
#   Example:
#   sdiff::line_pattern: 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$'
#
#   Defaults to <tt>false</tt>.

class sdiff(
  $ensure       = present,
  $color        = hiera('sdiff::color',true),
  $file_pattern = hiera('sdiff::file_pattern',false),
  $line_pattern = hiera('sdiff::line_pattern',false),
) {

  $file_ensure = $ensure ? {
    present => file,
    default => present,
  }

  file { '/usr/local/bin/sdiff':
    ensure  => $file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('sdiff/sdiff.erb'),
  }
}
