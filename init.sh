#!/bin/bash

# Initialize the main repository and submodules
echo "Initializing the main repository and submodules..."
git submodule update --init --recursive

# Function to install npm dependencies in a directory
install_npm_dependencies() {
    if [ -d "$1" ]; then
        echo "Installing dependencies in $1..."
        cd "$1" && npm install
        cd - > /dev/null
    else
        echo "Directory $1 does not exist."
    fi
}


# Install dependencies for each specified submodule directory
echo "Installing dependencies for submodules..."
install_npm_dependencies "./emoji-reaction"
install_npm_dependencies "./emoji-full-stack/emoji-reaction-backend"

echo "Initialization and installation complete!"