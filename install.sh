#!/bin/sh

source "install_helpers.sh"

install_check_zshenv
install_xcode
install_homebrew
install_fonts
is_lib_installed brew && lib_install git
is_lib_installed brew && lib_install fnm


