apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end

include_recipe "nginx::default"

["default", "000-default"].each do |unused_default|
  nginx_site unused_default do
    enable false
  end
end
