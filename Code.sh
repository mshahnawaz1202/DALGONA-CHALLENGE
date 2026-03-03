#!/bin/bash

# available shapes in the game
shapes=("circle" "star" "umbrella" "triangle")

# scores initializing to zero
player_score=0
computer_score=0
player1=""
player2=""
high_scores_file="high_scores.txt"
attempts=3

#-------------------------- drawing functions --------------------------

disCircle() 
{
    clear
    echo -e "\e[31m"  # Set color to Red
    echo -e "\n    ***    "
    echo "  *     *  "
    echo " *       * "
    echo "  *     *  "
    echo "    ***    "
    echo -e "\e[0m"  # Reset color
}

disStar() 
{
    clear
    echo -e "\e[33m"  # Set color to Yellow
    echo -e "\n    *    "
    echo "   ***   "
    echo "  *****  "
    echo "   ***   "
    echo "    *    "
    echo -e "\e[0m"  # Reset color
}

disUmbrella() 
{
    clear
    echo -e "\e[34m"  # Set color to Blue
    echo -e "\n   *****   "
    echo "  *******  "
    echo "    ***    "
    echo "     |     "
    echo "     |     "
    echo -e "\e[0m"  # Reset color
}

disTriangle() 
{
    clear
    echo -e "\e[32m"  # Set color to Green
    echo -e "\n     *     "
    echo "    ***    "
    echo "   *****   "
    echo "  *******  "
    echo -e "\e[0m"  # Reset color
}

#-------------------------- show shape --------------------------

disShape()
{
    clear
    echo "Identifying Shape..."
    sleep 1
    case $1 in
        "circle") disCircle ;;
        "star") disStar ;;
        "umbrella") disUmbrella ;;
        "triangle") disTriangle ;;
        *) echo "Unknown Shape!" ;;
    esac
}

#-------------------------- Welcome Message --------------------------

disWelcomeMsg()
{
    clear
    echo "         ==========================================================="
    sleep 1
    echo "         |                                                         |"
    sleep 1
    echo "         |          WELCOME TO THE DALGONA CHALLENGE               |"
    sleep 1
    echo "         |                                                         |"
    sleep 1
    echo "         ==========================================================="
    sleep 1
    echo "                                          "
    echo " "
    echo "         ==========================================================="
    sleep 1
    echo "                           Developed By : "
    sleep 1
    echo " "
    echo "               M.Shah Nawaz                 23F-3077"
    sleep 1
    echo "               M.Hamza Ismail               23F-3109"
    sleep 1
    echo "         ==========================================================="
    sleep 2
    echo "                                          "
    echo " "
    echo "                                          "
    echo " "
    read -n 1 -s -r -p "Press any key to continue..."
}

#-------------------------- select game mode --------------------------

disGameMode() 
{
    clear
    echo "            ==========================================================="
    sleep 1
    echo "            |                     Game Modes                          |"
    sleep 1
    echo "            ==========================================================="
    sleep 1
    echo "                 Enter: "
    sleep 1
    echo "                          1- Single Player Mode"
    sleep 1
    echo "                          2- Vs Computer"
    sleep 1
    echo "                          3- Multiplayer Mode"
    sleep 1
    echo "            ==========================================================="
    sleep 1
    echo " "
    echo "Enter Your Choice: "
    read mode

    if [[ "$mode" != "1" && "$mode" != "2" && "$mode" != "3" ]]; then
        echo "INVALID CHOICE!! "
        echo "default to single player ."
        mode=1
    fi

    # Take name input 
    if [[ "$mode" == "1" || "$mode" == "2" ]]; then
        echo -n "Enter your name: "
        read player1
    elif [[ "$mode" == "3" ]]; then
        echo -n "Enter Player 1's name: "
        read player1
        echo -n "Enter Player 2's name: "
        read player2
    fi

    read -n 1 -s -r -p "Press any key to continue..."
}

#-------------------------- Difficulty Level --------------------------

Difficulty_level() 
{
    clear
    echo "                       ==============================================="
    sleep 1    
    echo "                       |           SELECT DIFFICULTY LEVEL           |"
    sleep 1  
    echo "                       ==============================================="
    sleep 1
    echo "                       |          1. Easy    -> 8 sec                |"
    sleep 1 
    echo "                       |           2. Medium  -> 6 sec               |"
    sleep 1 
    echo "                       |           3. Hard    -> 4 sec               |"
    sleep 1 
    echo "                       ==============================================="
    sleep 1 
    echo ""
    echo "Enter your choice :"
    read level

    case $level in
        1) time_limit=8 ;;
        2) time_limit=6 ;;
        3) time_limit=4 ;;
        *) echo "Invalid choice! Defaulting to Easy ."; time_limit=8 ;;
    esac
    read -n 1 -s -r -p "Press any key to continue..."
}

#-------------------------- countdown timer --------------------------

countdown() {
    for i in $(seq $time_limit -1 1); do
        echo -n " $i..."
        sleep 1
    done
    echo " Time is up!"
}
#-------------------------- computer turn --------------------------

computer_turn() {
    random_shape=${shapes[$RANDOM % ${#shapes[@]}]}  # Randomly select a shape
    local attempts_left=3  # Computer has 3 attempts

    echo "Computer's Turn..."
    sleep 1
    disShape "$random_shape"  # Display the shape

    while [ $attempts_left -gt 0 ]; do
        sleep 1  # Simulate thinking time
        echo "Computer is guessing... "
        echo "                                  $attempts_left attempts left"
        
        # Generate a random guess from the shapes array
        computer_guess=${shapes[$RANDOM % ${#shapes[@]}]}  
        echo " Computer guessed : $computer_guess"
echo " "
        if [[ "$computer_guess" == "$random_shape" ]]; then  # Check if the guess is correct
            echo " Computer guessed correctly!"
            ((computer_score++))
            break
        else
        echo " "
            echo " Computer guessed wrong!"
            ((attempts_left--))
        fi
    done

    if [ $attempts_left -eq 0 ]; then
        echo " Computer failed all attempts! The correct answer was: $random_shape."
    fi

    sleep 2
    clear
}



#-------------------------- player turn (with 3 attempts) --------------------------

player_turn() {
    clear
    random_shape=${shapes[RANDOM % ${#shapes[@]}]}  # Randomly select a shape
    local attempts_left=3  # Each player gets 3 attempts

    echo "Round $round - $1's turn"
    disShape "$random_shape"  # Display the shape
    
    while [ $attempts_left -gt 0 ]; do
        echo -e "\n$1, you have $attempts_left attempts left."
        read -t "$time_limit" -p "Enter Shape Name: " user_input || user_input=""

        if [[ "$user_input" == "$random_shape" ]]; then
            echo " Correct! $1 earned 1 point."
            if [[ "$1" == "$player1" ]]; then
                ((player_score++))
            else
                ((computer_score++))
            fi
            break  # Exit loop if guessed correctly
        else
            echo " Wrong! Try again..."
            ((attempts_left--))
        fi
    done

    if [ $attempts_left -eq 0 ]; then
        echo " No attempts left! The correct answer was: $random_shape."
    fi

    sleep 2
    read -n 1 -s -r -p "Press any key to continue..."
    clear
}
#-------------------------- game loop --------------------------

game_loop()
{
    for round in {1..5}; do
        if [[ "$mode" == "1" ]]; then
            player_turn "$player1"
            if [ $? -eq 1 ]; then
                break
            fi
        elif [[ "$mode" == "2" ]]; then
            player_turn "$player1"
            if [ $? -eq 1 ]; then
                break
            fi
            computer_turn
        elif [[ "$mode" == "3" ]]; then
            multiplayer_turn
            if [ $? -eq 1 ]; then
                break
            fi
        fi
    done
}

#-------------------------- multiplayer turn  --------------------------

multiplayer_turn() {
    clear
    random_shape=${shapes[RANDOM % ${#shapes[@]}]}  # Randomly select a shape
    local attempts_left=3  # Reset attempts for player 1

    echo "Round $round - $player1's turn"
    disShape "$random_shape"  # Display the shape

    while [ $attempts_left -gt 0 ]; do
        echo -e "\n$player1, you have $attempts_left attempts left."
        read -t "$time_limit" -p "Enter Shape Name: " user_input || user_input=""

        if [[ "$user_input" == "$random_shape" ]]; then
            echo " Correct! $player1 earned 1 point."
            ((player_score++))
            break
        else
            echo " Wrong! Try again..."
            ((attempts_left--))
        fi
    done

    if [ $attempts_left -eq 0 ]; then
        echo " No attempts left! The correct answer was: $random_shape."
    fi

    sleep 2
    read -n 1 -s -r -p "Press any key to continue..."
    clear

    # Player 2's turn
    random_shape=${shapes[RANDOM % ${#shapes[@]}]}  # Select a new shape for player 2
    attempts_left=3  # Reset attempts for player 2

    echo "Round $round - $player2's turn"
    disShape "$random_shape"  # Display the shape

    while [ $attempts_left -gt 0 ]; do
        echo -e "\n$player2, you have $attempts_left attempts left."
        read -t "$time_limit" -p "Enter Shape Name: " user_input || user_input=""

        if [[ "$user_input" == "$random_shape" ]]; then
            echo "Correct! $player2 earned 1 point."
            ((computer_score++))
            break
        else
            echo " Wrong! Try again..."
            ((attempts_left--))
        fi
    done

    if [ $attempts_left -eq 0 ]; then
        echo "No attempts left! The correct answer was: $random_shape."
    fi

    sleep 2
    read -n 1 -s -r -p "Press any key to continue..."
    clear
}

#-------------------------- Final Result Announcement --------------------------

announce_result() 
{
    clear
    echo "==========================================================="
    echo "                       GAME OVER                           "
    echo "==========================================================="
    echo "Player Score: $player_score"
    if [ "$mode" == "2" ]; then
        echo "Computer Score: $computer_score"
    elif [ "$mode" == "3" ]; then
        echo "$player2 Score: $computer_score"
    fi
    echo "==========================================================="

    if [ "$mode" == "2" ]; then
        if [ "$player_score" -gt "$computer_score" ]; then
            echo "$player1 Wins!"
        elif [ "$player_score" -lt "$computer_score" ]; then
            echo "Computer Wins!"
        else
            echo "It's a Tie!"
        fi
    elif [ "$mode" == "3" ]; then
        if [ "$player_score" -gt "$computer_score" ]; then
            echo "$player1 Wins!"
        elif [ "$player_score" -lt "$computer_score" ]; then
            echo "$player2 Wins!"
        else
            echo "It's a Tie!"
        fi
    else
        echo "Well played $player1!"
    fi

    # Save high score
    echo "$player1: $player_score" >> "$high_scores_file"

    sleep 3
    read -n 1 -s -r -p "Press any key to continue..."
    clear
}

#-------------------------- replay option --------------------------

replay_option() {
    while true; do
        read -p "Do you want to play again? (y/n): " choice
        case $choice in
            [Yy]* ) 
                player_score=0
                computer_score=0
                attempts=3
                clear
                disGameMode
                clear
                Difficulty_level
                clear
                game_loop
                announce_result
                ;;
            [Nn]* ) 
                echo "         ====================================="
                sleep 1
                echo "                 Thanks for playing!"
                sleep 1
                echo "         ====================================="
                exit 0
                ;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

#-------------------------- game start --------------------------

disWelcomeMsg
disGameMode
clear
Difficulty_level
clear
game_loop
announce_result
replay_option
