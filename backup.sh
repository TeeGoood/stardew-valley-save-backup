#!/bin/bash

inotifywait -m -e moved_to --include "_old$" ~/.config/StardewValley/Saves/testbackup_426349532 |
while read path action file; do
  echo "$path $action $file"
  backup=${file%_old}
  current_backup=$(ls | grep "^$backup" | wc -l)
  order=$((current_backup+1))
  cp "${path}${file}" "${backup}_${order}_$(date +%Y%m%d%H%M%S)"
done
