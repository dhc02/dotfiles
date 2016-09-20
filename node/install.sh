if test ! $(which spoof)
then
  echo "> sudo npm install spoof -g"
  sudo npm install spoof -g
fi

echo "> npm update -g"
npm update -g
