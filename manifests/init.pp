# Installs VirtualBox
#
# Usage:
#
#   include virtualbox
class virtualbox (
  $version = '4.3.20',
  $patch_level = '96966'
) {

  exec { 'Kill Virtual Box Processes':
    command     => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }

  package { "VirtualBox-${version}-${patch_level}":
    ensure   => installed,
    provider => 'pkgdmg',
    source   => "http://download.virtualbox.org/virtualbox/${version}/VirtualBox-${version}-${patch_level}-OSX.dmg",
    require  => Exec['Kill Virtual Box Processes'],
  }
}
