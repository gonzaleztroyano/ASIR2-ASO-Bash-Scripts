#!/usr/bin/env bash
uid_free=0
while [ $uid_free != 1 ]
  do
    newuid=$(shuf -i 2000-65000 -n 1)
    cut -d ":" -f 3 < /etc/passwd  | grep "$newuid"
    uid_free=$? # Será 1 si no existe, 0 si existe
done
echo "${newuid}"
