# Source - https://stackoverflow.com/a/9271229
# Posted by slm, modified by community. See post 'Timeline' for change history
# Retrieved 2026-03-25, License - CC BY-SA 3.0

#!/bin/bash

check_process() {
  echo "$ts: checking $1"
  [ "$1" = "" ] && return 0
  pgrep -n "$1" > /dev/null && return 1 || return 0
}

while [ 1 ]; do 
  # timestamp
  ts=`date +%T`

  echo "$ts: begin checking..."
  check_process "pomo.sh"
[ $? -eq 0 ] && echo "$ts: not running, restarting..." && pomo.sh 15 start -i
  sleep 5
done

