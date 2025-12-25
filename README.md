# Stardew Valley Save Backup Script

This project provides an automated backup solution for Stardew Valley save files on Linux systems. It uses a Bash script and a systemd user service to monitor your save folder and create timestamped backups whenever a save file is updated.

## Features

- **Automatic Backups:** Monitors your Stardew Valley save folder and backs up save files whenever they are updated.
- **Timestamped Backups:** Each backup is saved with a unique timestamp and incremental number.
- **Easy Setup:** Simple installation script and systemd integration for automatic startup.

---

## Prerequisites

- **Operating System:** Linux (with systemd)
- **Dependencies:** `inotify-tools` (for file monitoring)

Install `inotify-tools` if you don't have it:

```bash
sudo apt-get install inotify-tools
```

---

## Setup

1. **Clone or Download the Repository**

   Download or clone this repository to your machine.

2. **Make the Setup Script Executable**

   ```bash
   chmod +x setup.sh
   ```

3. **Run the Setup Script**

   This will:
   - Copy the backup script to `~/bin`
   - Copy the systemd service file to your user config
   - Enable and start the backup service

   ```bash
   ./setup.sh
   ```

4. **Verify the Service is Running**

   ```bash
   systemctl --user status stardew-valley-save-backup
   ```

---

## How It Works

- The script monitors your Stardew Valley save directory:
  ```
  ~/.config/StardewValley/Saves/
  ```
- When a save file ending with `_old` is created or moved into the folder (which happens during the game's save process), the script copies it to:
  ```
  ~/.config/stardew-valley-save-backups/<FarmName>/
  ```
- Each backup is named with the original save name, an incremental number, and a timestamp, e.g.:
  ```
  FarmName_1_20240601XXXX
  ```

---

## Restoring a Backup

1. **Find the Backup File**

   Backups are stored in:
   ```
   ~/.config/stardew-valley-save-backups/<FarmName>/
   ```

2. **Copy the Desired Backup**

   Copy the backup file you want to restore into your Stardew Valley saves directory:
   ```
   ~/.config/StardewValley/Saves/<FarmName>/
   ```

3. **Rename the File**

   - Remove the incremental and timestamp suffix so it matches the original save file name.
   - Remove the `_old` suffix if present.

4. **Start the Game**

   Your restored save should now appear in-game.

---

## Managing the Backup Service

- **Check Service Status**
  ```bash
  systemctl --user status stardew-valley-save-backup
  ```

- **Stop the Service**
  ```bash
  systemctl --user stop stardew-valley-save-backup
  ```

- **Disable the Service (prevent it from starting on boot)**
  ```bash
  systemctl --user disable stardew-valley-save-backup
  ```

- **Restart the Service**
  ```bash
  systemctl --user restart stardew-valley-save-backup
  ```

---

## Uninstall

To remove the backup script and service:

1. **Stop and Disable the Service**
   ```bash
   systemctl --user stop stardew-valley-save-backup
   systemctl --user disable stardew-valley-save-backup
   ```

2. **Remove Installed Files**
   ```bash
   rm ~/bin/stardew-valley-save-backup.sh
   rm ~/.config/systemd/user/stardew-valley-save-backup.service
   ```

---

## Notes

- This script is intended for single-user Linux setups.
- Always make sure the game is not running when restoring saves to avoid corruption.
- You can customize backup locations or service behavior by editing the scripts.
