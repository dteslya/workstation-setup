#!/bin/bash
set -e

ANSIBLE_IMAGE_TAG=2.16-alpine-3.16
ANSIBLE_IMAGE_NAME=dteslya/ansible
ANSIBLE_IMAGE=$ANSIBLE_IMAGE_NAME:$ANSIBLE_IMAGE_TAG

function unsupported_os {
  echo "This is not a supported OS. (Ubuntu)"
  exit 1
}
function check_os {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" = "ubuntu" ]; then
      DISTRO_TYPE="ubuntu"
    else
      unsupported_os
    fi
  else
    echo "Cannot determine the operating system"
    exit 1
  fi
}

function install_docker {
  # Check if Docker is installed
  if [ -x "$(command -v docker)" ]; then
    echo "$(docker -v) detected. Skipping install..."
  else
    echo "Installing docker"
    if [ "${DISTRO_TYPE}" = "ubuntu" ]; then
      install_docker_ubuntu
      post_install_docker
    else
      unsupported_os
    fi
  fi
}

function post_install_docker {
  # instructions from:
  # https://docs.docker.com/engine/install/linux-postinstall/
  sudo groupadd -f docker
  sudo usermod -aG docker "$USER"
  echo "Please re-login to apply new group membership and run this script again"
}

function install_docker_ubuntu {
  # using instructions from:
  # https://docs.docker.com/engine/install/debian/#install-using-the-repository
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove -y $pkg; done

  # Add Docker's official GPG key:
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update -y

  sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function check_ansible {
  if docker inspect --type image localhost/$ANSIBLE_IMAGE &>/dev/null; then
    echo "Ansible image $ANSIBLE_IMAGE found. Proceeding..."
  else
    echo "Ansible image not found. Building..."
    docker build --build-arg="ANSIBLE_IMAGE_TAG=$ANSIBLE_IMAGE_TAG" -t localhost/$ANSIBLE_IMAGE ansible
  fi
}

function run_ansible {
  # Run Ansible in docker
  docker run \
    --rm -it \
    -v $(pwd)/ansible:/ansible \
    localhost/$ANSIBLE_IMAGE \
    ansible-playbook -i $(hostname), -c ssh --ssh-extra-args '-o StrictHostKeyChecking=no' --user $(whoami) --ask-pass --ask-become-pass /ansible/bootstrap.yml \
    --extra-vars "dotfiles_dir=$(pwd)/dotfiles home=$HOME user=$(whoami) group=$(id -g)" \
    "$@"
}

# Check if OS is supported
check_os

# Install Docker
install_docker

# Check Ansible Docker image
check_ansible

# Run ansible playbook
run_ansible "$@"

