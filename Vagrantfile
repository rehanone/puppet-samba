
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/ubuntu-22.04"
  config.vm.box_url = "https://app.vagrantup.com/bento/boxes/ubuntu-22.04"

  config.vm.synced_folder ".", "/etc/puppetlabs/code/environments/production/modules/samba"

  config.vm.provision :shell, inline: <<-EOF
    readonly source_file="puppet7-release-focal.deb"
    readonly source_url="https://apt.puppetlabs.com/"

    if [ -f ${source_file} ]; then
       echo "File ${source_file} exists."
    else
      echo "File ${source_file} does not exist."
      echo "Downloading it from ${source_url}${source_file}"
      apt-get install -y wget
      wget ${source_url}${source_file}
      dpkg -i ${source_file}

      apt-get update
      apt-get install -y puppet-agent
    fi

    puppet module install puppetlabs/stdlib
    puppet module install puppetlabs/augeas_core
  EOF

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "examples"
    puppet.manifest_file  = "init.pp"
#	puppet.module_path    = ["."]
#    puppet.options        = "../"
#    puppet.options        = "--verbose --debug"
  end
end
