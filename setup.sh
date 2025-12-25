#!/bin/bash

mkdir -p ~/bin
cp backup.sh ~/bin/stardew-valley-save-backup.sh
chmod +x ~/bin/stardew-valley-save-backup.sh

mkdir -p ~/.config/systemd/user
cp backup.service ~/.config/systemd/user/stardew-valley-save-backup.service

systemctl --user daemon-reload
systemctl --user enable stardew-valley-save-backup
systemctl --user start stardew-valley-save-backup
