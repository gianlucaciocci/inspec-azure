#!/usr/bin/env bash


pwd

alias terraformnt='docker run -i -v ${PWD}/test/integration/build:/share --workdir=/share hashicorp/terraform'
#
#shopt -s expand_aliases
#source ~/.bash_profile
terraformnt "$@"

pwd
