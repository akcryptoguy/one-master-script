## <p align="center"> AKcryptoGUY's One Master Script</p>

This VPS Deployment Script script was built in response to the ["One Master Script"](https://heliumcha.in/t/one-master-script-server-hardening-and-masternode-installation/133/2) Governance Proposal on the Helium blockchain and is designed to be run on new VPS deployments to simplify your masternode deployments. It is the perfect fusion between my Server Hardening Script ["Server Hardening Script"](https://github.com/akcryptoguy/vps-harden) and [Nodemaster's VPS Installation Script](https://github.com/masternodes/vps).

# Installation

Create a new VPS and then SSH into it.  You may use either an RSA key or password to sign in, depending on how you created your VPS. Then run this command to clone the Github repository and begin installation:

```bash 
sudo wget https://raw.githubusercontent.com/akcryptoguy/one-master-script/master/install.sh && sudo bash install.sh
```

After the script has completed, it will display on your screen the text which you need to paste into your local wallet's masternode.conf file. Because of formatting between your SSH client and text editor, you may need to format the file a slight amount by making sure that all masternode data for each masternode is contained in one line (this may involve inserting a few backspaces is all). NodeValet.io does a better job at formatting and is easier to use because it handles the formatting for you correctly. If you accidentally reboot the VPS before you copy the text you may locate your fully formed masternode.conf file on the VPS in `/var/tmp/nodevalet/temp/masternode.conf` (please let me know if you think I should add a `cronjob` to automatically delete this file after 24 hours just for security purposes.

# About

A lot of good virtual servers get destroyed every year because they aren't properly secured. With large numbers of Linux newcomers entering the space and setting up masternodes I wanted to create a simple way to secure virtual servers and automatically install the masternodes. This does that.

The following is a list of different security featured baked into "One Master Script" 

1. CREATE SWAP / if no swap exists, create 1 GB swap
2. UPDATE AND UPGRADE / update operating system & pkgs
3. INSTALL FAVORED PACKAGES / install my favorite tools & utilities
4. SSH CONFIG / change SSH port, disable password authentication if SSH keys exist
5. UFW CONFIG / UFW - add rules, harden, enable firewall
6. HARDENING / before rules, secure shared memory, etc
7. MOTD EDIT / replace boring banner with customized one and issue.net
8. RESTART SSHD / apply settings by restarting systemctl

When those security features are installed, the script moves on to invoke ["NodeValet"](https://github.com/akcryptoguy/nodevalet) script in a guided installation mode which will ask you for details about the masternodes you'd like to install and installs them for you.

I aggregated these steps from several different server hardening guides and selected the most effective of them to include in this script. The goal is to make something simple enough for newcomers to use while still being practical and saving time for seasoned Linux veterans. I am certainly open to suggestions and would like to keep this easy and practical to use.

The script will then walk you through each of the server hardening steps, offering prompts for feedback and other notes along the way. You really can't mess it up. I have tried. If you find a way to do so, please let me know and I'll try to fix it as soon as possible.

## Further hardening with RSA Key-pair

In order to secure your server's root login via SSH follow these steps on your VPS
```
mkdir ~/.ssh && touch ~/.ssh/authorized_keys
sudo chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
sudo nano ~/.ssh/authorized_keys
```
At this point you need to copy your RSA public key and paste it into the `authorized_keys` file and save the changes.  [Vultr's documentation](https://www.vultr.com/docs/how-do-i-generate-ssh-keys/) has a great guide on how to generate the key-pair. To activate the changes you need to restart the SSH service using this command: `sudo systemctl restart sshd`. Don't close out your existing session until you have made a test connection using your private key for authentication. If the connection works, it is now safe to edit the sshd_config using the command below to disable password authentication altgoether by changing the line to read “PasswordAuthentication no” and save the file save file.
```
sudo nano /etc/ssh/sshd_config
```

You will once more do `sudo systemctl restart sshd` to make those changes to sshd_config active and now your server will be secured using your RSA public/private key pair which is infinitely more secure than using a root password to login.

## Referral Links

Please [use my Vultr referral link](https://www.vultr.com/?ref=7568060) when creating your VPS account at Vultr to support my projects and build some good karma.<br/>

<p align="center"><a href="https://www.vultr.com/?ref=7568060"><img src="https://www.vultr.com/media/banner_1.png"></a></p>

[Digital Ocean](https://www.digitalocean.com/?refcode=bd6020302487) is also very generous, and give a free credit of $100 to use while testing the site to decide if it is right for you.
<p align="center"><a href="https://www.digitalocean.com/?refcode=bd6020302487"><img src="http://www.rrpowered.com/wp-content/uploads/2014/06/digital-ocean-694x219.png" height="100"></a></p>

If this script helps you out, please contribute some feedback. Donations are also welcome and help permit me to continue to develop this and other projects.

```
HLM: SeLcm3vNRMkriPu8RrMLCvaN1EWkAZnjb8
BTC: 3LbUJVW9WmXPgFStTXSLTBwjpnbVTtt8Ja
TRON: TLsday62mhM67Sv5G5Z5Ju66TezJuVFbiw
DGB: DUJ8W8QpmVex87posFPoDYGg5FrYCoMLGq
DOGE: DH9Sj3DQNVBaxb6kZBXc6X2MPQjbv7H6oy
```

## The following is a list of popular scriptlets you may run on your VPS
```bash 
getinfo
masternodestatus
checksync
killswitch
```

### getinfo
This scriptlet provides basic information about your masternodes which are installed.  Current block, wallet version, and number of current connections.

<p align="center"><img src="/media/getinfo-helium.png" alt="getinfo image"></p>

### masternodestatus
This scriptlet provides the same output that you would get if you ran `sudo /usr/local/bin/helium-cli -conf=/etc/masternodes/helium_n1.conf masternode status` but it is one hell of a lot easier to type and it will provide the output from each of your installed masternodes without having to type a separate command for each of them.

<p align="center"><img src="/media/masternodestatus-helium1.png" alt="masternodestatus image"></p>

### checksync
This scriptlet will let you know the syncing status of your first installed masternode, and automatically update every 10 seconds until the chain is synced.  I use this after first reboot to let me know roughly when the initial chain sync has completed. It will continue to run until either the chain is synced or you terminate the script by pressing CTL+C to stop it.

<p align="center"><img src="/media/checksync-helium.png" alt="checksync image"></p>

### killswitch
You shouldn't need to use this one, but if you do, this scriptlet will automatically disable and stop all of your installed masternode instances. This provides the same functionality as running the `sudo systemctl disable helium_n1` and `sudo systemctl stop helium_n1` commands separately. It may be 'undone' by issuing the `activate_masternodes_helium` command.

<p align="center"><img src="/media/killswitch-helium.png" alt="killswitch-helium image"></p>

## Help, Issues and Questions

I have tried to troubleshoot the script for errors and confirmed that it works with a VPS you configure on [Vultr](https://www.vultr.com/?ref=7568060), 
[Digital Ocean](https://www.digitalocean.com/?refcode=bd6020302487), and [Be Your Own VPS](https://www.youtube.com/playlist?list=PLTblguczzdyajCPQGlpJjHUvSNV8WNsGQ). It works in all of these as long as you're using Ubuntu 16.04 LTS. I have not tested it with anything else.

## Social and Contact

**Follow AKcryptoGUY online:** <br/>
**NodeValet.io Discord →** https://discord.gg/WV6Q8UN <br/>
**Medium →** https://medium.com/@AKcryptoGUY <br/>
**Twitter →** https://twitter.com/AKcryptoGUY <br/>
**Facebook →** https://www.facebook.com/AKcryptoGUY <br/>
**YouTube →** https://www.youtube.com/channel/UCIFu9OZWOtfxokGdFY6aTog <br/>

Reach out to me at akcryptoguy<img src="https://www.freeiconspng.com/uploads/at-sign-icon-1.png" alt="@ symbol" height="11">protonmail.com for suggestions or questions and if I helped save you some time, please send some crypto my way.


```
HLM: SeLcm3vNRMkriPu8RrMLCvaN1EWkAZnjb8
BTC: 3LbUJVW9WmXPgFStTXSLTBwjpnbVTtt8Ja
TRON: TLsday62mhM67Sv5G5Z5Ju66TezJuVFbiw
DGB: DUJ8W8QpmVex87posFPoDYGg5FrYCoMLGq
DOGE: DH9Sj3DQNVBaxb6kZBXc6X2MPQjbv7H6oy
```
