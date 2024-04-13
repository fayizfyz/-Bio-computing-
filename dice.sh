#!/bin/bash

# Function to get a throw of dice from 1 to 6
dice_throw() {
    echo $(( RANDOM % 6 + 1 ))
}

# Function to define next position
next_pos() {
    local current_pos=$1
    local dice=$2
    local next_pos=$(( current_pos + dice ))

    # Define snakes and ladders
    declare -A snakes_ladders=(
        [4]=2 #snake
        [9]=16 #ladder
        [17]=13 #snake
        [20]=5 #snake
        [28]=56 #ladder
        [40]=3 #snake
        [51]=31 #snake
        [54]=86 #ladder
        [62]=45 #snake
        [63]=37 #snake
        [64]=91 #ladder
        [71]=21 #snake
        [87]=57 #snake
        [93]=50 #snake
        [95]=73 #snake
        [99]=24 #snake
    )

    if [[ -v "snakes_ladders[$next_pos]" ]]; then
        next_pos=${snakes_ladders[$next_pos]}
    fi

    echo $next_pos
}

# Main function
play() {
    local position=0

    while true; do
        read -p "Press enter to throw the dice..."
        dice_roll=$(dice_throw)
        echo "You rolled a $dice_roll"
        position=$(next_pos $position $dice_roll)
        echo "Your position is now $position"

        if (( position >= 100 )); then
            echo "Congratulations! You are the winner."
            break
        fi
    done
}

# Start the game
play
