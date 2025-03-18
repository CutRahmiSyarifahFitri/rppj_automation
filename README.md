# Installation Guide for rbenv and Ruby 3.3.1

This guide will help you install `rbenv` and Ruby version 3.3.1 on both UNIX-based systems and Windows. Follow the steps carefully to ensure a smooth installation process.

---

## Table of Contents

1. [Installation](#installation)
   1. [Installation on MacOS Systems](#installation-on-macos-systems)
      - [Install homebrew](#install-homebrew)
      - [Install rbenv and ruby-build](#install-rbenv-and-ruby-build)
      - [Set up rbenv in your shell](#set-up-rbenv-in-your-shell)
      - [Install a Ruby version](#install-a-ruby-version)
      - [Set the global Ruby version](#set-the-global-ruby-version)
      - [Set the local Ruby version (optional)](#set-the-local-ruby-version-optional)
   2. [Installation on Windows Systems](#installation-on-windows-systems)
2. [Setup Cucumber Automation](#runing-cucumber-automation)
   - [Clone The Repository](#clone-the-repository)
   - [Setup The Env](#setup-the-env)
     - [Environments](#environments)
     - [Credentials](#credentials)
   - [Installing The Dependencies](#installing-the-dependencies)
3. [Running The Automation](#running-the-automation)
   - [Run the all scenario in feature](#run-the-all-scenario-in-feature)
   - [Running with tag](#running-with-tag)
   - [Running with multiple tags](#running-with-multiple-tags)
   - [Running for Specific Line](#running-for-specific-line)
   - [Running with rake task](#running-with-rake-task)
     - [Rake Run All Features](#rake-run-all-features)
     - [Rake Run Specific Tags](#rake-run-specific-tags)
     - [Rake Run Multiple Tags](#rake-run-multiple-tags)
   - [Running from Docker](#running-from-docker)
     - [Backend](#backend)
     - [Frontend](#frontend)
     - [Docker Run Specific Tags](#docker-run-specific-tags)
     - [Docker Run Multiple Tags](#docker-run-multiple-tags)
     - [Remove all build, volume, image, and container](#remove-all-build-volume-image-and-container)

---

# Installation

## Installation on MacOS Systems

- #### Install homebrew
  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- ### Install `rbenv` and `ruby-build`
  ```sh
  brew install rbenv
  brew install ruby-build
  ```
- ### Set up rbenv in your shell

  To make rbenv available in your terminal, you need to add it to your shell's configuration file. Add the following lines to your `~/.bash_profile` or `~/.zshrc` file, depending on whether you use Bash or Zsh:

  ```sh
  # For Bash
  echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
  source ~/.bash_profile

  # For Zsh
  echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc
  source ~/.zshrc

  ```

- ### Install a Ruby version
  Once `rbenv` is set up, you can install a specific version of Ruby. Here we use Ruby 3.3.1, to install, you can run:
  ```sh
  rbenv install 3.3.1
  ```
- ### Set the global Ruby version
  After installing a Ruby version, set it as the global version to be used by default:
  ```sh
  rbenv global 3.3.1
  ```
- ### Set the local Ruby version (optional)
  If you want to set the Ruby on each local project, you can run:
  ```sh
  cd project_dir
  rbenv local 3.3.1
  ```

---

## Installation on Windows Systems

make sure you are running all below steps from windows subsystem for linux (wsl)

### 1.Update Your Package List

`sudo apt update`

### 2.Install Prerequisites

Install the dependencies required for building Ruby from source:

```
sudo apt install -y \
git \
curl \
autoconf \
bison \
build-essential \
libssl-dev \
libyaml-dev \
libreadline6-dev \
zlib1g-dev \
libncurses5-dev \
libffi-dev \
libgdbm-dev \
libdb-dev
```

### 3.Install rbenv and ruby-build

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
```

### 4.Add rbenv to your shell to enable it:

```
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

### 5. install ruby-build as a plugin for rbenv:

```
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

### 6. Install a Ruby Version

```
rbenv install 3.2.2
rbenv global 3.2.2
```

### 7. Verify the installation:

```
ruby -v
```

### 8. Install Bundler

Bundler is a tool for managing Ruby gems. Install it with:

```
gem install bundler
```

### 9. Verify Everything is Set Up

Run the following to ensure everything is configured correctly:

```
rbenv rehash
```

---

# Runing Cucumber Automation

- ## Clone The Repository
  ```sh
  git clone https://gitlab.ugems.id/qa-automation/insting_automation.git
  ```
- ## Setup The Env

  - ### Environments
    Go to `environments` folder and copy paste:
    - `.env.cred.sample` to `.env.cred.staging`
    - `.env.sample` to `.env.staging`
  - ### Credentials
    Go to `config/credentials` folder and copy paste:
    - `client_secret.json.sample` to `client_secret.json`
    - `service_account.json.sample` to `service_account.json`

  ### **Notes:** These env and creadentials are for sample only.

- ## Installing The Dependencies

  The automation consist of **backend** and **frontend** automation type. Installing each type dependencies.

  ```sh
  # Install bundler
  gem install bundler

  # Install dependencies
  # backend
  cd automation/backend
  bundle install

  # frontend
  cd automation/frontend
  bundle install
  ```

---

# Running The Automation

We can run the automation with many ways, here how we can run it:

- ## Run the all scenario in feature

  ```sh
  # backend
  cd Automation/backend
  bundle exec cucumber features/login.feature

  # frontend
  cd Automation/frontend
  bundle exec cucumber features/login.feature

  ```

- ## Running for Specific Line
  ```sh
  bundle exec cucumber features/login.feature:6
  ```
- ## Running with tag
  ```sh
  bundle exec cucumber features/login.feature --tags @staging
  ```
- ## Running with multiple tags
  ```sh
  bundle exec cucumber features/login.feature --tags '@staging and @p0'
  ```

---

- ## Running with rake task
  - ### Rake run all features
    This will run all feature depends on **backend** or **frontend**.
    ```sh
    rake rake_automation:parallel_run
    ```
  - ### Rake run specific tags
    Running rake task with specific tags, run command
    ```sh
    TAGS=@staging rake rake_automation:parallel_run
    ```
  - ### Rake run multiple tags
    Running rake task with specific tags, run command
    ```sh
    TAGS='@staging and @p1' rake rake_automation:parallel_run
    ```

---

- ## Running from Docker

  On root project `/*_automation`
  Run this command to build and run the docker image and container for backend or frontend automation

  - ### Backend
    ```sh
    docker-compose up --build backend
    ```
  - ### Frontend
    ```sh
    docker-compose up --build frontend
    ```
  - ### Docker run specific tags
    Running automation with docker and specific tags, run command
    ```sh
    TAGS=@staging docker-compose up --build backend
    ```
  - ### Docker run multiple tags
        Running automation with docker and specific tags, run command
        ```sh
        TAGS='@staging and @p1' docker-compose up --build backend
        ```
    Wait until the docker process done (creating image, volume, and container).

  The end result is an automation report email will send to the admin

---

## Clean up

- ### Remove all build, volume, image, and container
  After completed run with docker then we want to remove all the build result, use this
  ```sh
  docker-compose down --rmi all -V
  ```
