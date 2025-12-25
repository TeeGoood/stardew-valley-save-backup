#!/bin/bash

root=~/.config/stardew-valley-save-backups

inotifywait -m -e moved_to --include "_old$" ~/.config/StardewValley/Saves/* |
while read path action file; do
  farm=$(awk -F'/' '{print $(NF-1)}' <<< $path)
  backups="$root/$farm"
  mkdir -p $backups

  backup=${file%_old}
  total_backups=$(ls $backups | grep ^$backup | wc -l)
  order=$((total_backups+1))

  cp "${path}${file}" "$root/$farm/${backup}_${order}_$(date +%Y%m%d%H%M)"
done
