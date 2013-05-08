name             "stackful-python"
maintainer       "Hristo Deshev"
maintainer_email "hristo@stackful.io"
license          "Apache 2.0"
description      "Installs/Configures the Stackful.io Python stack"
long_description IO.read(File.join(File.dirname(File.dirname(File.dirname(__FILE__))), 'README.md'))
version          "1.0.0"

recipe "stackful-python", "The Stackful.io Python web app stack"

%w{ apt build-essential ohai postgresql psql }.each do |cookbook|
  depends cookbook
end

%w{ ubuntu }.each do |os|
  supports os
end
