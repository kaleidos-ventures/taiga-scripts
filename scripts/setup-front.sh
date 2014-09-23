#!/bin/bash
cd ~/taiga-front

gem-install-if-needed sass
npm-install-if-needed gulp bower

sudo npm install
bower install
