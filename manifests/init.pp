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
#   * System modifications will be reverted
#     (e.g. removal of created users, services, changed log settings, ...).
#   * Absent is a destructive action
#
# [*color*]
#   Boolean. Optionally color line in diff output (red for deletions, green for
#   insertions and yellow for supression).
#
# [*file_pattern*]
#   String. The pattern that is used to determine which files not to show
#   diffs for. This value can be configured in hiera using
#   the sdiff::file_pattern key.
#
#   Example:
#   sdiff::file_pattern: '\.env'
#
# [*line_pattern*]
#   String. The pattern that is used to determine lines in a diff to not
#   show diffs for.  This value can be configured in hiera using the
#   sdiff::line_pattern key.
#
#   Example:
#   sdiff::line_pattern: 'MERCHANT_ID=.*\|PRIVATE_KEY=.*\$'

class sdiff (
  $ensure,
  $color        = hiera('sdiff::color'),
  $file_pattern = hiera('sdiff::file_pattern'),
  $line_pattern = hiera('sdiff::line_pattern'),
) {

  $file_ensure = $ensure ? {
    present => file,
    absent => absent,
  }

  file { '/usr/local/bin/sdiff':
    ensure  => $file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('sdiff/sdiff.erb'),
  }
}
