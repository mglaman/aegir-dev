require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

configValues = YAML.load_file("#{dir}/config.yml")
data         = configValues['vagrantfile']

Vagrant.configure("2") do |config|

  config.vm.box     = "#{data['vm']['box']}"
  config.vm.box_url = "#{data['vm']['box_url']}"

  if data['vm']['hostname'].to_s.strip.length != 0
    config.vm.hostname = "#{data['vm']['hostname']}"
  end

  if data['vm']['network']['private_network'].to_s != ''
    config.vm.network 'private_network', ip: "#{data['vm']['network']['private_network']}"
  end

  data['vm']['network']['forwarded_port'].each do |i, port|
    if port['guest'] != '' && port['host'] != ''
      config.vm.network :forwarded_port, guest: port['guest'].to_i, host: port['host'].to_i
    end
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  data['vm']['shared_dirs'].each do |i, folder|
    config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{i}", owner: 998, group: 999, mount_options: ['dmode=775', 'fmode=764']
    # group: "www-data", owner: "aegir"
  end

  config.vm.usable_port_range = (10200..10500)

  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.customize ['modifyvm', :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ['modifyvm', :id, '--memory', "#{data['vm']['memory']}"]
    virtualbox.customize ['modifyvm', :id, '--cpus', "#{data['vm']['cpus']}"]

    if data['vm']['hostname'].to_s.strip.length != 0
      virtualbox.customize ['modifyvm', :id, '--name', config.vm.hostname]
    end
  end

  #config.vm.provision :shell, :path => "#{dir}/.config/scripts/upgrade-puppet.sh"

  config.vm.provision :puppet do |puppet|
    puppet.facter = {
      'ssh_username'     => "vagrant",
      'provisioner_type' => ENV['VAGRANT_DEFAULT_PROVIDER'],
      'vm_target_key'    => 'vagrantfile-local',
      'fqdn'             => 'aegir.dev',
    }
    puppet.manifests_path = "#{dir}/.config/puppet/"
    puppet.manifest_file  = "site.pp"
    puppet.module_path    = [
      # File.expand_path('~/.drush/drush-vagrant/lib/puppet-modules/'),
      # File.expand_path('~/.drush/aegir-up/lib/puppet-modules/'),
      File.expand_path('.config/puppet/modules'),
    ]
  end

  config.vm.provision :shell, :path => '.config/scripts/startup.sh'
end
