#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export CHEF_GEM=/opt/chef/embedded/bin/gem
chef_version="11.4.4"
chef_url="https://www.opscode.com/chef/download?v=$chef_version&prerelease=false&p=ubuntu&pv=12.04&m=x86_64"

if chef-solo -v | grep "$chef_version" > /dev/null ; then
    echo "Chef $version found"
else
    if ! [ -f /vagrant/.debs-cache/chef.deb ] ; then
        wget --progress=dot "$chef_url" -O /vagrant/.debs-cache/chef.deb
    fi

    /opt/chef/embedded/bin/gem uninstall chef
    apt-get purge --yes chef

    dpkg -i /vagrant/.debs-cache/chef.deb
fi

# Prepare stack attributes
mkdir -p /etc/stackful
cp /vagrant/node.json.sample /etc/stackful/node.json
