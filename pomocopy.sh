#!/bin/bash


# made by @felioakz + google + chatGPT :)

# to execute: $ ./pomodoro.sh [argument] (argument: an interger representing minutes)

# Check if a duration argument was provided
clear -x
echo -e "\n"
echo "██████╗  ██████╗ ███╗   ███╗ ██████╗ 
██╔══██╗██╔═══██╗████╗ ████║██╔═══██╗
██████╔╝██║   ██║██╔████╔██║██║   ██║
██╔═══╝ ██║   ██║██║╚██╔╝██║██║   ██║
██║     ╚██████╔╝██║ ╚═╝ ██║╚██████╔╝
╚═╝      ╚═════╝ ╚═╝     ╚═╝ ╚═════╝ 
"
echo -e "\n"
if [ -z "$1" ]; then
	echo "Error: Please provide the duration of the Pomodoro in minutes as an argument."
	exit 1

# validation with regex to check input as interger
else
	# Check if the input is an integer
	if [[ $1 =~ ^[0-9]+$ ]]; then
		duration=$1
	else
		echo "Error: Please provide a valid integer as the duration of the Pomodoro in minutes."
		exit 1
	fi
fi

trap 'rm -f /tmp/pomo.json' EXIT

stty -echo

# Start the timer
echo "POMODORO TIMER started for $duration minutes ( Local time: $(date +'%r'))"

# terminal width to variable
width=$(tput cols)

# Use a loop to update the status bar every second
for ((i=1; i<=duration*60; i++)); do
	# Calculate the percentage of the duration that has passed
	percentage=$((i*100/(duration*60)))
  # Export remaining time as json
  remaining=$((duration*60 - i))
  
  min=$((remaining/60))
    sec=$((remaining%60))

    # Waybar-ready JSON
    printf '{"text": "🍅 %02d:%02d", "tooltip": "%d%%"}\n' \
      "$min" "$sec" "$percentage" > /tmp/pomo.json 

  # Print the percentage
	printf "\r %d%%" $percentage

	for ((j=1; j<=percentage && j<= width; j+=3)); do
		printf "|"
	done
	# Sleep for one second
	sleep 1
done
# Notify the user that the Pomodoro is finished
notify-send "Time's up! POMODORO TIMER Completed!"

# timer termination alert sound
paplay mp3x.mp3

# paplay default system alert sound
# paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga

reset
