#!/usr/bin/env bash

pwd

alias inspecnt='docker run -i -v $(PWD)/test/integration:/share --workdir=/share chef/inspec'
#shopt -s expand_aliases
#source ~/.bash_profile

pwd