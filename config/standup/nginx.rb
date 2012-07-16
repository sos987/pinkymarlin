Standup.script :node do
  self.description = 'Nginx setup'

  REPOSITORY_NGINX = 'deb http://nginx.org/packages/ubuntu/ lucid nginx'
  #deb-src http://nginx.org/packages/ubuntu/ lucid nginx

  def run
    scripts.ec2.open_port 80, 443

    if repo_does_not_exists?
      #sudo add-apt-repository
      sudo "echo \"#{REPOSITORY_NGINX}\" >> /etc/apt/sources.list"
    end

    in_temp_dir do
      exec "wget http://nginx.org/packages/keys/nginx_signing.key"
      exec "cat nginx_signing.key | sudo apt-key add -"
    end

    sudo "echo \"deb http://ppa.launchpad.net/nginx/stable/ubuntu lucid main\" > /etc/apt/sources.list.d/nginx-stable-lucid.list"
    sudo 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C'
    sudo 'apt-get update'
    install_package 'nginx'

    sudo 'mkdir -p /etc/nginx/servers'

    upload script_file('nginx.conf'),
           :to => '/etc/nginx/',
           :sudo => true

    scripts.monit.add_watch script_file('nginx_monit.conf')
  end

  def repo_does_not_exists?
    sudo('cat /etc/apt/sources.list').match(/#{REPOSITORY_NGINX}/).blank?
  end

  def add_server_conf file, name = File.basename(file), restart = true
    upload file,
           :to   => "/etc/nginx/servers/#{name}",
           :sudo => true

    restart_nginx if restart
  end

  def restart_nginx
    scripts.monit.restart_watch 'nginx'
  end

end