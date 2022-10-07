# Bash Scripting and Crontab

The objects of this exercise are:

- Scripting essentials and syntax
- Task automation
- Task scheduling
- ssmtp server configuration

## Task
```
Create a bash script to run at every hour, saving system memory (RAM) usage to a specified file and
at midnight it sends the content of the file to a specified email address, then starts over for the new day.
```

## Solution
The following are the perequisite needed to accomplish this task

- Ubuntu 20.04 installed and updated.
- Mailtrap.io account.
- A non-root sudo user.
- Text editor of your choice nano/vim.
- Backup or a snapshot of your current installation.

#### Mailtrap account

Visit [mailtrap](https://mailtrap.io) to setup an account. A free plan is sufficient to complete this task
```
Mailtrap.io offers a fake email server for developers. Use it to send reports or emails during development
phase to real addresses but intercept them at Mailtrap.io (they are never delivered to the final recipient)
and see immediately how your HTML email is rendered or how a new CTO button stands out
```

#### Installation

- Install the sSMTP package for the server side with mutt as the mail client for testing purposes `sudo apt install ssmtp mutt`

#### Configuration

- Edit the configiration file `sudo vim /etc/ssmtp/ssmtp.conf`. By default it should look like this

```
# Config file for sSMTP sendmail
#
# The person who gets all mail for userids < 1000
# Make this empty to disable rewriting.
root=postmaster

# The place where the mail goes. The actual machine name is required no
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=mail

# Where will the mail seem to come from?
#rewriteDomain=

# The full hostname
hostname=example.com

# Are users allowed to set their own From: address?
# YES - Allow the user to specify their own From: address
# NO - Use the system generated From: address
#FromLineOverride=YES
```

At this point you might edit the entries to match your own values or just replace the whole content with your specific information.
The capitalized entries contain your actual data. `USERNAME@EXAMPLE.COM` is the email from which you wish to send the emails.
`MAILTRAP_USERNAME` and `MAILTRAP_PASSWORD` are generated for you at Mailtrap.io. Both are long, random strings. Look it up in
your Mailtrap Inbox under `SMTP Settings`.

To be explicit:
```
root=USERNAME@EXAMPLE.COM
mailhub=smtp.mailtrap.io:2525
AuthUser=MAILTRAP_USERNAME
AuthPass=MAILRTRAP_PASSWORD
FromLineOverride=Yes
```
save the changes and quit

- Edit the reverse aliasing file. `vim /etc/ssmtp/revaliases`. Add your entries to the end so it looks something like this text.

```
# sSMTP aliases
#
# Format:       local_account:outgoing_address:mailhub
#
# Example: root:your_login@your.domain:mailhub.your.domain[:port]
# where [:port] is an optional port number that defaults to 25.
root:USERNAME@EXAMPLE.COM:smtp.mailtrap.io:2525
username:USERNAME@EXAMPLE.COM:smtp.mailtrap.io:2525
```
save the file.

Essentially, the system should send all the emails from the local account root
as email user `USERNAME@EXAMPLE.COM` via the `mailtrap` server. Enter as many users
as you need, each in its own line. If you only need `root` to send out messages,
just omit other lines. You may come back later and add users as needed.

- Test the installation and setup by sending a mail
```
echo "This is the body" | mutt -s "Hello World" SEND_TO_USERNAME@EXAMPLE.COM
```

#### bash script

[hourlyramlogs.sh](./hourlyramlogs.sh) is the script that cron executes every hour. Check it out to properly understand all it does

#### crontab

With the script required to run hourly, the view the [cron](./cron) file to see how that was effected

#### Execution success

The image below shows the email sent at midnight after successful execution of the script.
