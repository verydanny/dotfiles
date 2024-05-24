#!/bin/sh

default="\033[39m"
black="\033[30m"
red='\033[0;31m'
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
light_gray="\033[37m"
dark_gray="\033[90m"
light_red="\033[91m"
light_green="\033[92m"
light_yellow="\033[93m"
light_blue="\033[94m"
light_magenta="\033[95m"
light_cyan="\033[96m"
white="\033[97m"

function is_lib_installed() {
  command -v $1 >/dev/null
}

function dot_mes_red() {
  echo -e "${red} ${1}"
}

function dot_mes() {
  echo -e "${1} ${2}"
}

function dot_mes_install() {
  dot_mes ${green} "--> Installing ${1}"
}

function dot_mes_update() {
  dot_mes ${yellow} "--> Updating ${1}"
}

function dot_mes_warn() {
  echo -e "${red}/!\  ${1} /!\ "
}

function dot_install() {
  echo -e "${blue}-> Installing ${yellow}${1} ${blue}config"
  . "$DOTFILES/install/install-${1}.sh"
}

function dot_install_func() {
  echo -e "${blue}-> Installing ${yellow}${1} ${blue}config"
  . $DOTFILES/install/install-${1}.sh
  ${2}
}

function dot_sub_install() {
  echo -e "${green}--> Installing ${1}"
}

function lib_install() {
  echo "${light_cyan}--> Installing ${1}${default}"
  local output=$(brew install $1 2>&1)
  local exit_status=$?

  # echo for debug
  # echo "$output"
  # echo "$exit_status"

  if echo "$output" | grep -q -w "is already installed and up-to-date"; then
    echo "${green}--> Already installed ${1}.${default}"
  elif [ "$exit_status" == 0 ]; then
    echo "${green}--> Successfully installed ${1}.${default}"
  fi
}

CURRENT_DIR="$PWD"
TEMPLATE="$(sed "s|\${CURRENT_DIR}|$CURRENT_DIR|g" "ZSHENV_TEMPLATE")"
HAS_XCODE=$(xcode-select -p 1>/dev/null 2>&1 && echo 1 || echo 0)
HAS_HOMEBREW=$(is_lib_installed && echo 1 || echo 0)

# Install patched fonts
install_fonts() {
  local FONT_DIR="fonts"
  local MACOS_FONT_DIR="$HOME/Library/Fonts"
  local fonts_installed=0

  for font in "$FONT_DIR"/*.ttf; do
    if [[ -f "$font" ]]; then
      # Extract filename from font
      font_name=$(basename "$font")

      #Check if font is successfully installed in directory
      if [[ ! -f "$MACOS_FONT_DIR/$font_name" ]]; then
        cp "$font" "$MACOS_FONT_DIR/"
        echo "${green}-->$font_name installed succesfully.${default}"
      elif [[ -f "$MACOS_FONT_DIR/$font_name" ]]; then
        fonts_installed=$((fonts_installed + 1))
      fi
    fi
  done

  if [ $fonts_installed -gt 1 ]; then
    echo "${green}--> $fonts_installed fonts installed successfully.${default}"
  fi
}

# Install Xcode Command-Line Tools
install_xcode() {
  if [ ! "$HAS_XCODE" ]; then
    echo "${yellow}Xcode Command Line Tools are not installed.${default}"
    read -p "${yellow}Do you want to install them now? (y/n) ${default}" choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      xcode-select --install
      echo "${yellow}--> Please follow the installation instructions.${default}"
    else
      echo  "${red}--> Xcode Command Line Tools are required for this script to work.${default}"
    fi
  else
    echo "${green}--> Xcode Command Line Tools are installed.${default}"
  fi
}

# Install Homebrew
install_homebrew() {
  if [ ! "$HAS_HOMEBREW" ]; then
    echo "${light_cyan}--> Installing Homebrew...${default}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "${green}--> Homebrew is already installed.${default}"
  fi
}

install_check_zshenv() {
  if [[ ! -f "$HOME/.zshenv" ]] || ! grep -q -w "$TEMPLATE" $HOME/.zshenv; then
    echo "${green}--> Creating .zshenv template.${default}"
    echo "$TEMPLATE" > $HOME/.zshenv
  fi
}
