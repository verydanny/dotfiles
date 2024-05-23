#!/bin/sh

XDG_CONFIG_HOME="$HOME/.config"
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
has_xcode=$( if xcode-select --version &>/dev/null; then echo 1; else echo 0; fi )
has_homebrew=$( if command -v brew &>/dev/null; then echo 1; else echo 0; fi )

# Install Xcode Command-Line Tools
install_xcode() {
  if [ ! "$has_xcode" ]; then
    echo "Xcode Command Line Tools are not installed."
    read -p "Do you want to install them now? (y/n) " choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      xcode-select --install
      echo "Please follow the installation instructions."
    else
      echo "Xcode Command Line Tools are required for this script to work."
    fi
  else
    echo "Xcode Command Line Tools are installed."
  fi
}

# Install Homebrew
install_homebrew() {
  if [ ! "$has_homebrew" ]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed."
  fi
}

# Install patched fonts
install_fonts() {
  FONT_DIR="fonts"
  MACOS_FONT_DIR="$HOME/Library/Fonts"

  for font in "$FONT_DIR"/*.ttf; do
    if [[ -f "$font" ]]; then
      # Extract filename from font
      font_name=$(basename "$font")

      #Check if font is successfully installed in directory
      if [[ ! -f "$MACOS_FONT_DIR/$font_name" ]]; then
        cp "$font" "$MACOS_FONT_DIR/"
        echo "$font_name installed succesfully."
      elif [[ -f "$MACOS_FONT_DIR/$font_name" ]]; then
        echo "$font_name already installed."
      fi
    fi
  done
}

install_zsh() {
  if [ "$has_homebrew" ]; then
    brew install zsh zsh-completions
    mkdir -p $ZDOTDIR
    cp -r zsh $XDG_CONFIG_HOME
  else
    echo "Please install Homebrew first."
  fi
}

install_files() {
  if [ "$has_homebrew" ]; then
    mkdir -p $ZDOTDIR
    cp -r zsh $XDG_CONFIG_HOME
    cp .zshenv $HOME
  else
    echo "Please install Homebrew first."
  fi
}

install_xcode
install_homebrew
install_fonts
install_zsh
install_files
