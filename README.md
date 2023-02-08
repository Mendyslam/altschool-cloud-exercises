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

## [Exercise 10 - Networking: IP addressing and Subnet Mask](./networking)

Understanding how devices are addressed and how networks are classed.
This exercise enlightens on the calculation of IP addresses from a given IP and subnet mask.

- Given this `193.16.20.35/29` address:
    - What is the Network IP
    - Number of Hosts
    - Range of IP addresses
    - Broadcast IP of the subnet

## [Holiday Challenge](./deploy-nginx-web-servers/)

- Set up 2 EC2 instances on AWS(use the free tier instances).
- Deploy an Nginx web server on these instances(you are free to use Ansible)
- Set up an ALB(Application Load balancer) to route requests to your EC2 instances
- Make sure that each server displays its own Hostname or IP address. You can use any programming language of your choice to display this.

**Important notes:**

- I should not be able to access your web servers through their respective IP addresses. Access must be only via the load balancer
- You should define a logical network on the cloud for your servers.
- Your EC2 instances must be launched in a private network.
- Your Instances should not be assigned public IP addresses.
- You may or may not set up auto scaling(I advice you do for knowledge sake)
- You must submit a custom domain name(from a domain provider e.g. Route53) or the ALB’s domain name.