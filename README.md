# DevOps Exercises at Altschool of Engineering

This repository contains exercises relating to topics taught and learnt during my time at altschool

## [Exercise 1 - Setting up vagrant with ubuntu 20.04 LTS](./vagrant-setup-ubuntu20.04)

Set up Ubuntu 20.04 LTS on your local machine using Vagrant

#### Instructions:

- Customize your Vagrantfile as necessary with private_network set to dchp
- Once the machine is up, run ifconfig and share the output in your submission along with your Vagrantfile in a folder for this exercise

## [Exercise 2 - Linux commands](./linux-commands)

Learning linux commands and how to use them to interact with the unix resource system

- Research online for 10 more linux commands aside the ones already mentioned in this module
- Explain what each command is used for with examples of how to use each and example screenshots of using each of them

## [Exercise 3 - Application Package Management](./php7.4-installation)

Install `PHP 7.4` on your local linux machine using the `ppa:ondrej/php` package repository

- Learn how to use the `add-apt-repository` command
- Submit the content of `/etc/apt/sources.list` and the output of `php -v` command.

## [Exercise 5 - CIS Benchmark for Ubuntu2004](./cis-benchmark-ubuntu2004)

This exercise involves understanding and implementing the CIS benchmark for compute infrastructure

- We are tasked to review and effect any 10 CIS benchmarks on our local virtual machine
- Level 1 - Server applicability profile is the focus for this exercise

## [Exercise 8 - Bash Scripting and Cron jobs](./bash-scripting-and-cronjobs)

The foundations of automation through `bash scripting` and task scheduling via `crontab`

- Create a bash script to run at every hour, saving system memory (RAM) usage to a specified file
- At midnight it sends the content of the file to a specified email address, then starts over for the new day.

## [Exercise 9 - Configuration management with Ansible](./ansible)

As a broader subject, configuration management (CM) refers to the process of systematically handling changes
to a system in a way that it maintains integrity over time. Even though this process was not originated in the
IT industry, the term is broadly used to refer to server configuration management.

This exercise focuses [ansible](https://docs.ansible.com/ansible/latest/), a popular, minimalistic yet power tool.

- Create an Ansible Playbook to setup a server with Apache
- The server should be set to the Africa/Lagos Timezone
- Host an index.php file with the following content, as the main file on the server:
