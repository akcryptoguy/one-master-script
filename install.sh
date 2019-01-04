#!/bin/bash
# One Master Script

cd /var/tmp ; sudo rm -rf nodevalet ; sudo git clone https://github.com/nodevalet/nodevalet -b master; cd nodevalet; sudo bash silentinstall.sh
