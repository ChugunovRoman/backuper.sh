#!/bin/bash

mountpoint=`lsblk -o MOUNTPOINT | grep MyDisk`;
to="${mountpoint}/Soft/OS/Linux/Backup-images";
from="/";
argv=$@;
media="";

# Если первый аргумент пустой
if [ ! -z "$1" ]
    then
        from="${1}";
fi

# Если второй аргумент пустой
if [ ! -z "$2" ]
    then
        to="${2}";
fi

# Если есть такой аргумет, то добавляем в исключение папку /media
if [[ "$argv" == *--media* || "$argv" == *-m* || "$argv" == *m* ]]; then
    media=",\"/media/*\"";
fi

# Выводим команду в терминал и выполняем ее
cmd="rsync -aAXv ${from} --exclude={\"/dev/*\",\"/proc/*\",\"/sys/*\",\"/tmp/*\",\"/run/*\",\"/mnt/*\"${media},\"/lost+found\"} ${to}"
echo "line: ${cmd}";
bash -c "${cmd}"

