#
# Cookbook Name:: resolv4flxnt
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package ["golang","git"]  do
  action :install
end

bash "set_gopath" do
   user "root"
   code <<-EOS
   echo "GOPATH=$HOME" >> /etc/environment
   EOS
   not_if "grep -q GOPATH /etc/environment"
end

bash "get resolv4flx" do
   code <<-EOS
   go get github.com/odacremolbap/resolv4flx/
   EOS
end

cookbook_file "#{ENV['HOME']}/query.txt" do
   source "query.txt"
   mode "0644"
end


execute "run resolv4flx" do
   cwd "#{ENV['HOME']}"
   command "bin/resolv4flx -w 10 query.txt >> result.txt"
   user "vagrant"
end


log "---------------------------------------------------------------"
log "Hi folks ar FLXNT, look for result.txt at #{ENV['HOME']}/result.txt"
log "---------------------------------------------------------------"

