# Deploy nginx web Server to server a php application on two private EC2 instance on AWS

This project is a fractional part of the major project titled "Setting up an application load balancer to distribute traffic to two nginx web server". A detailed description and step guide of the main project can be found [here](https://medium.com/@mendyslam/deploy-and-configure-two-nginx-web-servers-on-separate-private-ec2-instances-accessible-via-an-b7bf80d57b9a)

## Requirements
- A virtual private cloud across two availability zones (AZ) with one public and private subnet in each AZ
- One bastion instance in a public subnet
- One NAT instance in a public subnet
- Two private EC2 instances hosting the nginx web server

Use the [aws resource](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html) to set up the requirements

## Procedures
- Log into the bastion instance
- Update and upgrade the apt package manager
    - `sudo apt-get -y update`
    - `sudo apt-get -y upgrade`
- Install ansible `sudo apt install ansible`
- Clone this repository
    - `git clone https://github.com/Mendyslam/altschool-cloud-exercises.git`
- Run the playbook
    - `ansible-playbook main.yml -i inventory`

Head over to this [article](https://medium.com/@mendyslam/deploy-and-configure-two-nginx-web-servers-on-separate-private-ec2-instances-accessible-via-an-b7bf80d57b9a) to setup the application load balancer that directs traffic to the web servers using the round robin algorithm