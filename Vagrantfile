# -*- mode: ruby -*-
# vi: set ft=ruby :

#paths to scripts
github_user = "giadc"
github_repo = "seven"
github_branch = "master"
#path_to_scripts = "/local/path/to/scripts"
path_to_scripts = "https://raw.githubusercontent.com/#{github_user}/#{github_repo}/#{github_branch}/scripts"

#server configs
server_ip = "10.44.4.4"
server_mem = "1024"
host_share_location = "."
guest_root = "/vagrant"

# Httpd ( Apache ) configs
include_httpd = true
include_apache_helpers = true

# MariaDB ( Mysql ) configs
include_mariadb = true
db_passwd = "root"
mysql_port = 3308

# Php 7
include_php = true
include_composer = true

# Redis
include_redis = true

# Beanstalkd
include_beanstalkd = true

# Node
include_node = true

# End of config options

Vagrant.configure(2) do |config|

    config.vm.box = "centos/7"

    config.vm.network "forwarded_port", guest: 3306, host: mysql_port

    config.vm.network "private_network", ip: server_ip

    config.vm.synced_folder host_share_location, guest_root,
        id: "core",
        :nfs => true,
        :mount_options => ['nolock,vers=3,udp,noatime,actimeo=2,fsc']

    config.vm.provider "virtualbox" do |vb|
        vb.memory = server_mem
    end

    # Provisioning Scripts ( first arg indicates if dev environment )

    config.vm.provision "shell", path: "#{path_to_scripts}/base.sh", args: "true"

    if include_httpd === true
       config.vm.provision "shell", path: "#{path_to_scripts}/httpd.sh", args: "true #{include_apache_helpers}"
    end

    if include_mariadb === true
       config.vm.provision "shell", path: "#{path_to_scripts}/mariadb.sh", args: "true #{db_passwd}"
    end

    if include_php === true
       config.vm.provision "shell", path: "#{path_to_scripts}/php.sh", args: "true #{include_composer}"
    end

    if include_redis === true
       config.vm.provision "shell", path: "#{path_to_scripts}/redis.sh", args: "true"
    end

    if include_beanstalkd === true
       config.vm.provision "shell", path: "#{path_to_scripts}/beanstalkd.sh", args: "true"
    end

    if include_node === true
       config.vm.provision "shell", path: "#{path_to_scripts}/node.sh", args: "true"
    end

    config.vm.provision "shell", path: "#{path_to_scripts}/post.sh", args: "true"
end
