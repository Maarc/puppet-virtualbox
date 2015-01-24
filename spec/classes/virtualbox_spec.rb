require 'spec_helper'

describe 'virtualbox' do
  it do
    should contain_exec('Kill Virtual Box Processes').with({
      :command => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
      :path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      :refreshonly => true,
    })
  end
  it do
    version = "4.3.20"
    patch_level = "96996"
    should contain_package("VirtualBox-${version}-${patch_level}").with({
      :ensure   => "installed",
      :source   => "http://download.virtualbox.org/virtualbox/${version}/VirtualBox-${version}-${patch_level}-OSX.dmg",
      :provider => "pkgdmg",
      :require  => "Exec[Kill Virtual Box Processes]",
    })
  end
end
