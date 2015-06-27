#
# Cookbook Name:: opencv
# Attributes:: default
#

default["opencv"]["version"] = "2.4.11"

default["opencv"]["url"]["2.4.11"] = "https://codeload.github.com/Itseez/opencv/zip/#{node['opencv']['version']}"
default["opencv"]["checksum"]["2.4.11"] = "4a9e00fe1dd7888109c1bf06793d995ea805acd2c630c217db6cc5214949f81e"

