#!/bin/bash

# Ensure Node js is installed
if ! command -v node &>/dev/null; then
    echo "Node js and npm are not installed. Installing ..."
    sudo apt update
    sudo apt install nodejs npm -y
fi

# Ensure PNPM is installed
if ! command -v pnpm &>/dev/null; then
    echo "pnpm not installed. Installing ..."
    sudo apt update
    sudo npm install -g pnpm
fi

# Ensure Git is installed
if ! command -v git &>/dev/null; then
    echo "git not installed. Installing ..."
    sudo apt update
    sudo npm install git
fi

# Ensure Directory (/www) exists
if ! command -d www &>/dev/null; then
    echo "www directory not found. Creating www ..."
    mkdir www
    echo "Directory www is created.."
    cd www
fi

# Ensure Directory (/www/repos) exists
if ! command -d repos &>/dev/null; then
    echo "repos directory not found in www. Creating repos ..."
    mkdir repos
    echo "Directory repos is created in www.."
fi

# Ensure Directory (/www/logs) exists
if ! command -d logs &>/dev/null; then
    echo "logs directory not found in www. Creating logs ..."
    mkdir logs
    echo "Directory logs is created in www and navigating towards repo directory."
    cd repos
fi

# Cloning repo from git
if [ -z "$(ls -A)" ]; then
    echo "Repo directory is empty. Cloning repo from git (https://github.com/Vidhya-Skill-School/NodeJS-Express-API-V1.git) ..."
    git clone "https://github.com/Vidhya-Skill-School/NodeJS-Express-API-V1.git"
    echo "Repo cloned successfully."
fi

# Check if the directory exists
if [ -d "NodeJS-Express-API-V1" ]; then
    echo "Moving into cloned repo (NodeJS-Express-API-V1) ..."
    cd NodeJS-Express-API-V1

    echo "Installing pnpm dependencies..."
    if pnpm install; then
        echo "pnpm dependencies installed successfully."

        echo "Running app..."
        pnpm dev
    else
        echo "Failed to install pnpm dependencies."
    fi
else
    echo "Directory NodeJS-Express-API-V1 does not exist."
fi
