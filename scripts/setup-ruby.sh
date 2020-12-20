#!/bin/bash

sudo apt-get install -y ruby
gem install --user-install sass scss_lint
echo "export PATH=~/.gem/ruby/1.9.1/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
