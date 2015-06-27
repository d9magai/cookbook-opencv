# -*- coding: utf-8 -*-

execute "install opencv" do
  command  "curl -o #{Chef::Config['file_cache_path']}/#{node["opencv"]["version"]}.zip #{node["opencv"]["url"]}"
end

