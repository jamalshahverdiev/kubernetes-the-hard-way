# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
vars = YAML.load_file('depvars.yml')

Vagrant.configure("2") do |apilb|
  apilb.vm.box = "debian/buster64"
  apilb.vbguest.auto_update = false
  (1..3).each do |i|
     apilb.vm.define "kubecontroller#{i}" do |kubecontroller|
       kubecontroller.vm.network :private_network, ip: vars['subnet'] + "1#{i}"
       kubecontroller.vm.hostname = "kubecontroller#{i}"
       kubecontroller.ssh.forward_agent = true
       kubecontroller.vm.network :forwarded_port, guest: 22, host: vars['sshportPoint'] + 6 + i, id: "ssh"
       kubecontroller.vm.provider :virtualbox do |v1|
         v1.customize ["modifyvm", :id, "--name", "kubecontroller#{i}", "--memory", "2048", "--cpus", "2"]
       end
       kubecontroller.vm.provision "shell", path: "scripts/debGLscript.sh"
     end
  end
  (1..3).each do |i|
     apilb.vm.define "kubeworker#{i}" do |kubeworker|
       kubeworker.vm.network :private_network, ip: vars['subnet'] + "2#{i}"
       kubeworker.vm.hostname = "kubeworker#{i}"
       kubeworker.ssh.forward_agent = true
       kubeworker.vm.network :forwarded_port, guest: 22, host: vars['sshportPoint'] + 2 + i, id: "ssh"
       kubeworker.vm.provider :virtualbox do |v1|
         v1.customize ["modifyvm", :id, "--name", "kubeworker#{i}", "--memory", "2048", "--cpus", "2"]
       end
       kubeworker.vm.provision "shell", path: "scripts/debGLscript.sh"
     end
  end
  apilb.vm.define "apilb" do |apilb|
    apilb.vm.network :private_network, ip: vars['subnet'] + '41'
    apilb.vm.hostname = "apilb"
    apilb.ssh.forward_agent = true
    apilb.vm.network :forwarded_port, guest: 22, host: vars['sshportPoint'] + 41, id: "ssh"
    apilb.vm.provider :virtualbox do |v1|
      v1.customize ["modifyvm", :id, "--name", "apilb", "--memory", "2048", "--cpus", "2"]
    end
    apilb.vm.provision "shell", path: "scripts/debGLscript.sh"
    apilb.vm.provision "shell", path: "scripts/installAnsible.sh"
    apilb.vm.provision "shell", path: "scripts/executeAnsible.sh"
  end
end
