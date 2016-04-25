#!/usr/bin/env bash

# Post Scripts
################

if foobar_loc="$(type -p "apachectl")" || [ -z "$foobar_loc" ]; then
    sudo apachectl restart
fi
