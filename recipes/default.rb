# -*- coding: utf-8 -*-

file_path="#{Chef::Config['file_cache_path']}/#{node["opencv"]["version"]}.zip"
execute "install opencv" do
  command "curl -o #{file_path} #{node["opencv"]["url"]}"
  not_if{ ::File.exists?("#{file_path}")}
end


include_recipe "build-essential"

[
unzip
cmake
].each do |pkg|
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

