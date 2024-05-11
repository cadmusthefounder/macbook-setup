#!/usr/bin/env bash

NAME="Charlton Lim"
EMAIL="cadmusthefounder@gmail.com"

echo "Creating directories..."
mkdir ~/Documents/Workspace

echo "Installing xcode-stuff"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

# Git setup
echo "Installing Git..."
brew install git

echo "Git config"

git config --global user.name $NAME
git config --global user.email $EMAIL

echo "Generating SSH key..."
ssh-keygen -t ed25519 -C $EMAIL

echo "Copying SSH public key to clipboard..."
pbcopy < ~/.ssh/id_ed25519.pub

echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"

echo "Adding SSH key to ssh-agent..."
ssh-add ~/.ssh/id_ed25519

echo "Adding git aliases..."
git config --global alias.co checkout

LG_FORMAT="log --graph --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s\
 %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full"
git config --global alias.lg $LG_FORMAT

# Languages setup
echo "Installing JS stuff..."
brew install node
brew install yarn

echo "Installing Python stuff..."
brew install pyenv
brew install pipx
pipx ensurepath
pipx install poetry

echo "Installing Terraform..."
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew install terragrunt

echo "Installing useful CLIs..."
brew install awscli
brew install htop
brew install jq
brew install macvim
brew install trash
brew install tree
brew install wget
brew install zsh

echo "Installing Oh My Zsh..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Powerline..."
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

echo "Installing applications..."
# Apps
apps=(
    1password
    discord
    docker
    google-chrome
    iterm2
    notion
    slack
    spotify
    steam
    visual-studio-code
    zoom
)

# Install apps to /Applications
echo "Installing apps with Cask..."
brew install --cask ${apps[@]}
brew cleanup
