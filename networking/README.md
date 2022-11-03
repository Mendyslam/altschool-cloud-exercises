# Networking:- IP addressing and Netmask

The learning objectives of this exercise are:

- What is an IP address and Subnet Mask
- To understand how devices commuinate on the internet
- How devices get their individual addresses
- How to determine the various Network identities

## Task
What is the Network IP, number of hosts, range of IP addresses and broadcast IP from this subnet?
- `193.16.20.35/29`

## Cheat Sheet
| Group Size | 128 | 64 | 32 | 16 | 8 | 4 | 2 | 1 |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Subnet | 128 | 192 | 224 | 240 | 248 | 252 | 254 | 255 |
| CIDR | /25 | /26 | /27 | /28 | /29 | /30 | /31 | /32 |

### Usage
1. Use given CIDR/Subnet mask to find column on Cheat Sheet
    - CIDR/Subnet Mask map to each other
    - Locate Group size
    - Start at `.0` in relevant octet
    - Increase by Group size until you pass `target IP`
2. Number before target IP is `Network ID`
3. Number after target IP is the `Next Network`
4. IP address before next network is `Broadcast IP`
5. IP address after network id is the `First Host`
6. IP address before broadcast IP is the `Last Host`
7. Group size is the `total number of available IP addresses on the network`
    - Note: total available IPs is Group size - 2

## Solution
The IP address given is a version 4 IP address. It is therefore made up of 32 bits of binary digits,
which are divided into 4 octets. From the given address, the IP is `193.16.20.35`, while the subnet
mask is `/29`. The minimum and maximum value of an IP are 0.0.0.0 and 255.255.255.255 respectively.
As a note these IPs are not given out, they are reserved for specific purposes. The minimum and 
maximum value of a subnet mask are 0 and 32. The lower the subnet mask the larger the network.
Let's represent the address and subnet mask in binary before we proceed to the solution.

|              | 1st octet | 2nd octet | 3rd octet | 4th octet |
| -----------: | --------: | --------: | --------: | --------: |
| 193.16.20.35 | 11000001  | 00010000  | 00010100  | 00100011  |
| 29           | 11111111  | 11111111  | 11111111  | 11111000  |

### Using the Cheat Sheet

1. Based on the given subnet, the `Group size` is `8`. Using this group size let's find the range of our target IP `193.16.20.35`.
Starting from `193.16.20.0` till we pass our target IP `193.16.20.35`:

| Count | IP values in steps of 8 | Description |
| ----: | ----------------------: | :---------: |
| 1 | 193.16.20.0 | - |
| 2 | 193.16.20.8 | - |
| 3 | 193.16.20.16 | - |
| 4 | 193.16.20.24 | - |
| 5 | 193.16.20.32 | Network ID. IP immediately less than target IP |
| 6 | 193.16.20.40 | Next Network ID. Target IP passed |

- From the table above:
    - `Network IP` - `193.16.20.32`
    - `Next Network` - `193..16.20.40`

### Solution Report

| name | value | calculation |
| :---: | :---: | :---: |
| Network ID | 193.16.20.32/29 | Network IP and Subnet mask |
| Number of Hosts | 6 | Group size (8) - 2 |
| Range of IP addresses | 193.16.20.33 - 193.16.20.38 (both inclusive) | Fisrt Host - Last Host |
| Broadcast IP | 193.16.20.39 | Address before Next Network |
