#!/bin/bash

# Install some dependencies for Ruby
sudo apt-get update
sudo apt-get -y purge ruby
sudo apt-get -y install git curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs

# Install Ruby using rbenv
cd
echo The user running these commands is $(whoami)
rm -vrf .rbenv
git clone --verbose https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

source ~/.bashrc
sudo -H -u ubuntu bash -i -c 'rbenv install 2.1.9'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'
sudo -H -u ubuntu bash -i -c 'rbenv global 2.1.9'
sudo -H -u ubuntu bash -i -c 'gem install bundler --no-ri --no-rdoc'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'

cd /vagrant
sudo -H -u ubuntu bash -i -c 'PUPPET_GEM_VERSION=">= 3.8.5" bundle install'

# Puppet currently is being installed by Gemfile
# apt-get -y install puppet

# use local nexpose module
#puppet resource file /etc/puppet/modules/nexpose ensure=link target=/vagrant

# setup module dependencies in the future
#puppet module install puppetlabs-stdlib
#puppet module install puppet-archive