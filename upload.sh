#!/bin/bash

mkdir -p /tmp/rom
cd /tmp/rom

up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

tg(){
	bot_api=1710768515:AAEpUOXucT8Regv0NhAB7eMwHZgJ39xgv-M
	your_telegram_id=$1
	msg=$2
	curl -s "https://api.telegram.org/bot${1360846079:AAF0ripWX4Hl_vy2ort8wQtEviODlKFiTCc}/sendmessage" --data "text=$msg&chat_id=${589677413}"
}

id=544521199

up out/target/product/mojito/*.zip && up out/target/product/mojito/*.img
ccache -s

cd /tmp

com () 
{ 
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}

time com ccache 1 # Compression level 1, its enough

mkdir -p ~/.config/rclone
echo "$rclone_config" > ~/.config/rclone/rclone.conf
time rclone copy ccache.tar.gz dblenk:ccache -P
