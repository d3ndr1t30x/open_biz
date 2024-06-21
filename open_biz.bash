#!/bin/bash

# Message to display
MESSAGE="open for business"

# Flash durations in seconds
ON_DURATION=0.5
OFF_DURATION=0.2

# Infinite loop to flash the message on and off
while true; do
    # Get the terminal size
    TERM_WIDTH=$(tput cols)
    TERM_HEIGHT=$(tput lines)

    # Create the big figlet message
    FIGLET_MESSAGE=$(figlet -f big "$MESSAGE")

    # Get the size of the figlet output
    MESSAGE_WIDTH=$(echo "$FIGLET_MESSAGE" | awk '{print length}' | sort -nr | head -1)
    MESSAGE_HEIGHT=$(echo "$FIGLET_MESSAGE" | wc -l)

    # Calculate the top and left padding for centering the message
    PAD_TOP=$(( (TERM_HEIGHT - MESSAGE_HEIGHT) / 2 ))
    PAD_LEFT=$(( (TERM_WIDTH - MESSAGE_WIDTH) / 2 ))

    # Clear the screen
    clear

    # Print the padding for centering
    printf "\n%.0s" $(seq 1 $PAD_TOP)

    # Print the message with left padding
    echo "$FIGLET_MESSAGE" | awk -v pad=$PAD_LEFT '{printf "%"pad"s%s\n", "", $0}' | lolcat

    # Wait for the on duration
    sleep $ON_DURATION

    # Clear the screen to hide the message
    clear

    # Wait for the off duration
    sleep $OFF_DURATION
done
