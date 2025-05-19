#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
   echo "Setting up for MacOS..."
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
   echo "Setting up for Linux..."
fi

# neovim
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install neovim
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    ./nvim-linux-x86_64.appimage --appimage-extract
    ./squashfs-root/AppRun --version
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'alias vi=nvim' >> ~/.zshrc
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo 'alias vi=nvim' >> ~/.bashrc
fi

# telescope live_grep
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install ripgrep
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get install ripgrep
fi

pip install --upgrade pynvim

git clone https://github.com/microsoft/java-debug && cd java-debug && ./mvnw clean install
git clone https://github.com/microsoft/vscode-java-test && cd vscode-java-test && npm install && npm run build-plugin
