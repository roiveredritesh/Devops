#!/bin/bash

# Ensure Git is installed
if ! command -v git &>/dev/null; then
    echo "git not installed. Installing ..."
    sudo apt update
    sudo install git
fi

# Ensure NVM is installed
if ! command -v nvm &>/dev/null; then
    echo "Installing the latest LTS version of nvm..."
    sudo apt update
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

# Ensure Node.Js is installed
if ! command -v node &>/dev/null; then
    echo "Installing the latest LTS version of node..."
    nvm install --lts
fi

# Ensure PM2 is installed
if ! command -v pm2 &>/dev/null; then
    npm install pm2 -g
fi

# Ensure Mongodb is installed
if ! command -v mongod &>/dev/null; then
    echo "Installing the latest mongo db..."
    sudo apt update
    sudo apt-get install gnupg curl
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
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
        pm2 start ./src/main.js
        pm2 ls
        echo "pm2 started."
    else
        echo "Failed to install pnpm dependencies."
    fi
else
    echo "Directory NodeJS-Express-API-V1 does not exist."
fi
