
---

# 🚀 Backup Script - `backup.sh` 📦

## 🌟 Overview

This script automates the backup process by:
- Compressing the specified source directory into a zip file.
- Storing it in the specified backup directory.
- Syncing it with an S3 bucket.

✨ It also includes a cleaning mechanism to keep only the latest 5 backups locally.

### 👨‍💻 Author
- **Name**: Sujal Sahu
- **Version**: v1.0

## 🛠️ Features

1. **📂 Backup Creation**: Compresses the source directory into a timestamped zip file.
2. **🧹 Local Cleanup**: Retains the latest 5 backups in the backup directory.
3. **☁️ S3 Sync**: Synchronizes backups with an S3 bucket and removes old files from S3.

---

## 💻 Usage

### 📝 Syntax

```bash
./backup.sh <source_path> <backup_path>
```

### 📋 Arguments

- `<source_path>`: Path to the directory you want to back up.
- `<backup_path>`: Path to the directory where backups will be stored.

### 🔧 Example

```bash
./backup.sh /home/user/data /home/user/backups
```

---

## 📋 Prerequisites

1. Ensure you have `zip` installed on your system:
   ```bash
   sudo apt-get install zip
   ```
2. Install and configure AWS CLI for S3 syncing:
   ```bash
   aws configure
   ```

---

## ⏰ Adding to Crontab

To automate the backup process, you can add this script to your `crontab`.

1. Open the crontab editor:
   ```bash
   crontab -e
   ```
2. Add the following line to schedule the script (adjust the schedule as needed):
   ```bash
   0 2 * * * /path/to/backup.sh /path/to/source /path/to/backup_dir >> /path/to/logfile.log 2>&1
   ```

### 🔍 Explanation

- `0 2 * * *`: Executes the script daily at 2:00 AM.
- Replace `/path/to/backup.sh`, `/path/to/source`, and `/path/to/backup_dir` with the actual paths.
- Log output is redirected to `/path/to/logfile.log`.

---

## ⚠️ Error Handling

- If the script fails during any operation, it will display an error message and terminate with a non-zero exit code.

---

## 📝 Notes

- Keep your S3 bucket name updated in the script (`S3_BUCKET="s3://your-bucket-name"`).
- Test the script manually before automating it with `crontab`.

---

Let me know if you want further customizations! 🌈

