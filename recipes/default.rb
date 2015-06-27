# -*- coding: utf-8 -*-

file_path="#{Chef::Config['file_cache_path']}/#{node["opencv"]["version"]}.zip"
remote_file file_path do
  source node["opencv"]["url"][node['opencv']['version']]
  checksum node["opencv"]["checksum"][node['opencv']['version']]
  backup false
end

include_recipe "build-essential"

%w(
unzip
cmake
).each do |pkg|
  package pkg do
    action :install
  end
end

build_path="opencv-#{node["opencv"]["version"]}/build"
execute "install opencv" do
  cwd Chef::Config['file_cache_path']
  command "unzip #{file_path} "
  command <<-EOH
      unzip #{file_path} 
      mkdir -p #{build_path}
      cd #{build_path}
      cmake -DCMAKE_INSTALL_PREFIX=/opt/opencv ..
      make -j2
      make install
  EOH
end

template "/etc/ld.so.conf.d/opencv.conf" do
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[run ldconfig]"
end

# ldconfigコマンドで更新した共有ライブラリのパスを認識させる
execute "run ldconfig" do
  user "root"
  command "/sbin/ldconfig"
  action :nothing
end

