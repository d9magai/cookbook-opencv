#
# Cookbook Name:: opencv
# Attributes:: default
#

default["opencv"]["version"] = "2.4.11"
default["opencv"]["url"] = "https://codeload.github.com/Itseez/opencv/zip/#{node['opencv']['version']}"

