#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export CHEF_GEM=/opt/chef/embedded/bin/gem
# Get rid of the ancient Vagrant Chef
# Not needed on boxes that already pack Chef 11
sudo /opt/vagrant_ruby/bin/gem uninstall chef ohai


# Install latest Chef release, if needed
chef_location=$(which chef-solo)
if [ -x "$chef_location" ] ; then
    echo "Chef Solo already installed: $chef_location"
else
    apt-get install --yes curl
    curl -L https://www.opscode.com/chef/install.sh | bash
fi
