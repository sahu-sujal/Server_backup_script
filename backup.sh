#!/bin/bash

<< "readme"
Author: Sujal Sahu
Version: v1.0
Usage: ./bachup.sh <source Path> <backup Path>

readme

#variables assigning
source_dir=$1
backup_dir=$2
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
S3_BUCKET="s3://serverbackuptesting/backup"

function display_usage {
    if [[ $# -ne 2 ]]; then
        echo "kindly add the argument"
        echo "usage: $0 <path to source> <backup folder path>"
        exit 1
    fi

}

function create_backup {
    echo "Creating backup from ${source_dir} to ${backup_dir}/backup_${timestamp}.zip"
    if zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}"; then
        echo "Backup Generated Successfully: backup_${timestamp}.zip"
    else
        echo "Backup Failed"
        exit 1
    fi
}

function cleaning {

        backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))

        if [ "${#backups[@]}" -gt 5 ]; then
                echo "perform cleaning"
                removing_files=("${backups[@]:5}")

                for backup in "${removing_files[@]}";
                do
                        rm -f ${backup}
                done
        fi

        s3_bucket_sync
}

function s3_bucket_sync {
        if ! aws s3 sync "$backup_dir" "$S3_BUCKET" --delete; then
                echo "unable to sync with s3"
                exit 1
        fi
}

if [ $# -eq 0 ]; then
        display_usage "$#"
        exit 1
fi

if ! create_backup; then
        echo "unable to create backup"
        exit 1
fi

if ! cleaning; then
        echo "unable to cleane backups"
        exit 1

fi