#!/bin/bash

echo "Setting up for MacOS..."

brew install neovim node
echo 'alias vi=nvim' >> ~/.zshrc

# telescope live_grep
brew install ripgrep
