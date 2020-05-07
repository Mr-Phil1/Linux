#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' dialog 2>/dev/null  | grep -c "ok installed") -eq 0 ];
then
  echo "Install Dialog"
  sudo apt install dialog -y;
    if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null  | grep -c "ok installed") -eq 0 ];
    then
      echi "Install curl "
      sudo sudo apt-get install curl -y;
fi
