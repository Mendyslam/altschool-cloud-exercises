# 10 CIS Benchmarks for Ubuntu20.04 LTS Linux Operating System

The following benchmarrks are applicable to level 1 server, but not limited to just it.

## Ensure systemd-timesyncd is configured (Automated)

**Description:**
systemd-timesyncd is a daemon that has been added for synchronizing the system clock
across the network. It implements an SNTP client. In contrast to NTP implementations such
as chrony or the NTP reference server this only implements a client side, and does not
bother with the full NTP complexity, focusing only on querying time from one remote
server and synchronizing the local clock to it. The daemon runs with minimal privileges,
and has been hooked up with networkd to only operate when network connectivity is
available

**Rationale:**
Proper configuration is vital to ensuring time synchronization is working properly.

**Audit:**

- Verify that only one time synchronization method is in use on the system:
Run the following command to verify that ntp is not installed:
```
dpkg -s ntp
dpkg-query: package 'ntp' is not installed and no information is available
```
Run the following command to verify that chrony is not installed:
```
dpkg -s chrony
dpkg-query: package 'chrony' is not installed and no information is available
```

- Ensure that timesyncd is enabled and started
Run the following commands:
```
# systemctl is-enabled systemd-timesyncd.service

enabled
```

- Verify that systemd-timesyncd is configured:
Review /etc/systemd/timesyncd.conf and ensure that the NTP servers, NTP FallbackNTP
servers, and RootDistanceMaxSec listed are in accordance with local policy
Run the following command

**Remediation**
- Remove additional time synchronization methods:
Run the following commands to remove ntp and chrony:
```
# apt purge ntp
# apt purge chrony
```
- Configure systemd-timesyncd:
Run the following command to enable systemd-timesyncd
```
# systemctl enable systemd-timesyncd.service
```
Edit the file /etc/systemd/timesyncd.conf and add/modify the following lines:
```
NTP=0.debian.pool.ntp.org 1.debian.pool.ntp.org #Servers listed should be In Accordence With Local Policy

FallbackNTP=2.debian.pool.ntp.org 3.debian.pool.ntp.org #Servers listed should be In Accordence With Local Policy

RootDistanceMax=1 #should be In Accordence With Local Policy
```
Run the following commands to start systemd-timesyncd.service
```
# systemctl start systemd-timesyncd.service
# timedatectl set-ntp true
```

## 2. Stop and Mask unwanted services (Automated)
If any of these services are not required, it is recommended that they be
deleted from the system to reduce the potential attack surface. If a package is required as a
dependency, and the service is not required, the service should be stopped and masked.
The following command can be used to stop and mask the service:
```
# systemctl --now mask <service_name>
```

## 3. Disabling Unused File System (Automated)

The file system used to explain this benchmark is `cramfs`. The process is similar with other file system.

**Description:**
The cramfs filesystem type is a compressed read-only Linux filesystem embedded in small
footprint systems. A cramfs image can be used without having to first decompress the
image.

**Rationale:**
Removing support for unneeded filesystem types reduces the local attack surface of the
server. If this filesystem type is not needed, disable it.

**Audit:**
Run the following commands and verify the output is as indicated:
```
# modprobe -n -v cramfs | grep -E '(cramfs|install)'
install /bin/true
# lsmod | grep cramfs
<No output>
```

**Remediation:**
Edit or create a file in the /etc/modprobe.d/ directory ending in .conf
Example: vim /etc/modprobe.d/cramfs.conf
and add the following line:
```
install cramfs /bin/true
```
Run the following command to unload the cramfs module:
```
# rmmod cramfs
```

## 4. Ensure /tmp is configured (Automated)

**Description:**
The /tmp directory is a world-writable directory used for temporary storage by all users
and some applications

**Rationale:**
Making /tmp its own file system allows an administrator to set the noexec option on the
mount, making /tmp useless for an attacker to install executable code. It would also
prevent an attacker from establishing a hardlink to a system setuid program and wait for it
to be updated. Once the program was updated, the hardlink would be broken and the
attacker would have his own copy of the program. If the program happened to have a
security vulnerability, the attacker could continue to exploit the known flaw.
This can be accomplished by either mounting tmpfs to /tmp, or creating a separate
partition for /tmp.

**Impact:**
Since the /tmp directory is intended to be world-writable, there is a risk of resource
exhaustion if it is not bound to a separate partition.
Running out of /tmp space is a problem regardless of what kind of filesystem lies under it,
but in a default installation a disk-based /tmp will essentially have the whole disk available,
as it only creates a single / partition. On the other hand, a RAM-based /tmp as with tmpfs
will almost certainly be much smaller, which can lead to applications filling up the
filesystem much more easily.
/tmp utilizing tmpfs can be resized using the size={size} parameter on the Options line on
the tmp.mount file

**Audit:**
Run the following command and verify output shows /tmp is mounted to tmpfs or a system
partition:
```
# findmnt -n /tmp

/tmp tmpfs tmpfs rw,nosuid,nodev,noexec
```

**Remediation:**
Configure /etc/fstab as appropriate. Example:
```
tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime 0 0
```
OR Run the following commands to enable systemd /tmp mounting:
Run the following command to create the tmp.mount file is the correct location:
```
# cp -v /usr/share/systemd/tmp.mount /etc/systemd/system/
```
Edit /etc/systemd/system/tmp.mount to configure the /tmp mount:
```
[Mount]
What=tmpfs
Where=/tmp
Type=tmpfs
Options=mode=1777,strictatime,nosuid,nodev,noexec
```
Run the following command to reload the systemd daemon with the unpdated tmp.mount
unit file:
```
# systemctl daemon-reload
```
Run the following command to enable and start tmp.mount
```
# systemctl --now enable tmp.mount
```

## 5. Ensure /dev/shm is configured (Automated)
**Description**
/dev/shm is a traditional shared memory concept. One program will create a memory
portion, which other processes (if permitted) can access. Mounting tmpfs at /dev/shm is
handled automatically by systemd.

**Rationale:**
Any user can upload and execute files inside the /dev/shm similar to the /tmp partition.
Configuring /dev/shm allows an administrator to set the noexec option on the mount,
making /dev/shm useless for an attacker to install executable code. It would also prevent an
attacker from establishing a hardlink to a system setuid program and wait for it to be
updated. Once the program was updated, the hardlink would be broken and the attacker
would have his own copy of the program. If the program happened to have a security
vulnerability, the attacker could continue to exploit the known flaw.

**Audit:**
Run the following command and verify output shows /dev/shm is mounted:

```
# findmnt -n /dev/shm

/dev/shm tmpfs tmpfs rw,nosuid,nodev,noexec
```

**Remediation:**
Edit /etc/fstab and add or edit the following line:
```
tmpfs /dev/shm tmpfs defaults,noexec,nodev,nosuid,seclabel 0 0
```
Run the following command to remount /dev/shm:
```
# mount -o remount,noexec,nodev,nosuid /dev/shm
```

## 6. Ensure sticky bit is set on all world-writable directories (Automated)
**Description:**
Setting the sticky bit on world writable directories prevents users from deleting or
renaming files in that directory that are not owned by them.

**Rationale:**
This feature prevents the ability to delete or rename files in world writable directories
(such as /tmp ) that are owned by another user.

**Audit:**
Run the following command to verify no world writable directories exist without the sticky
bit set:
```
# df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev
-type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null
```
No output should be returned.

**Remediation:**
Run the following command to set the sticky bit on all world writable directories:
```
# df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev
-type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | xargs -I '{}' chmod
a+t '{}'
```

## 7. Disable Automounting (Automated)
**Description:**
autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.

**Rationale:**
With automounting enabled anyone with physical access could attach a USB drive or disc
and have its contents available in system even if they lacked permissions to mount it
themselves.

**Impact:**
The use of portable hard drives is very common for workstation users. If your organization
allows the use of portable storage or media on workstations and physical access controls to
workstations is considered adequate there is little value add in turning off automounting.

**Audit:**
autofs should be removed or disabled.
Run the following commands to verify that autofs is not installed or is disabled
Run the following command to verify autofs is not enabled:

```
# systemctl is-enabled autofs

disabled
```
Verify result is not "enabled".
OR run the following command to verify that autofs is not installed
```
# dpkg -s autofs
```
Output should include:
```
package `autofs` is not installed
```

**Remediation:**
Run one of the following commands:
Run the following command to disable autofs :
```
# systemctl --now disable autofs
```
OR run the following command to remove autofs
```
# apt purge autofs
```

## 8. Ensure package manager repositories are configured (Manual)
**Description:**
Systems need to have package manager repositories configured to ensure they receive the
latest patches and updates.

**Rationale:**
If a system's package repositories are misconfigured important patches may not be
identified or a rogue repository could introduce compromised software.

**Audit:**
Run the following command and verify package repositories are configured correctly:
```
# apt-cache policy
```

**Remediation:**
Configure your package manager repositories according to site policy.

## 9. Ensure GPG keys are configured (Manual)
**Description:**
Most packages managers implement GPG key signing to verify package integrity during
installation.

**Rationale:**
It is important to ensure that updates are obtained from a valid source to protect against
spoofing that could lead to the inadvertent installation of malware on the system.

**Audit:**
Verify GPG keys are configured correctly for your package manager:
```
# apt-key list
```
**Remediation:**
Update your package manager GPG keys in accordance with site policy.

## 10. Ensure AIDE is installed (Automated)
**Description:**
AIDE takes a snapshot of filesystem state including modification times, permissions, and
file hashes which can then be used to compare against the current state of the filesystem to
detect modifications to the system.

**Rationale:**
By monitoring the filesystem state compromised files can be detected to prevent or limit
the exposure of accidental or malicious misconfigurations or modified binaries.

**Audit:**
Run the following commands to verify AIDE is installed
```
# dpkg -s aide | grep -E '(Status:|not installed)'
Status: install ok installed

# dpkg -s aide-common | grep -E '(Status:|not installed)'
Status: install ok installed
```

**Remediation:**
Install AIDE using the appropriate package manager or manual installation:
```
# apt install aide aide-common
```
Configure AIDE as appropriate for your environment. Consult the AIDE documentation for
options.
Run the following commands to initialize AIDE:
```
# aideinit
# mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```
**Additional Information:**
The prelinking feature can interfere with AIDE because it alters binaries to speed up their
start up times. Run prelink -ua to restore the binaries to their prelinked state, thus
avoiding false positives from AIDE.

For more CIS benchmarks, visit [cisecurity](https://downloads.cisecurity.org/#/)
-- 
