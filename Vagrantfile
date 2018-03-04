# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.box = "windows_10_enterprise_eval"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true
  config.vm.provision "shell", path: "scripts/chocolatey.ps1"
  config.vm.provision "shell", path: "scripts/packages.bat"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end
end
