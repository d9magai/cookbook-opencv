# -*- coding: utf-8 -*-

file_path="#{Chef::Config['file_cache_path']}/#{node["opencv"]["version"]}.zip"
execute "install opencv" do
  command "curl -o #{file_path} #{node["opencv"]["url"]}"
  not_if{ ::File.exists?("#{file_path}")}
end

