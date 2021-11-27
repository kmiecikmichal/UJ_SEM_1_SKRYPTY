#!/bin/bash


PLAYER=2
DECK=( 1 2 3 4 5 6 7 8 9 )
GAME_FINISH=0


function display {
	clear
	echo "Enter the number of the square you want to select\n"
	echo "${DECK[0]} | ${DECK[1]} | ${DECK[2]}"
	echo "${DECK[3]} | ${DECK[4]} | ${DECK[5]}"
	echo "${DECK[6]} | ${DECK[7]} | ${DECK[8]} \n"
}


function game_finish_check {
	# 3 in a row
	if ([[ ${DECK[0]} == ${DECK[1]} ]] && [[ ${DECK[1]} == ${DECK[2]} ]]) \
	|| ([[ ${DECK[3]} == ${DECK[4]} ]] && [[ ${DECK[4]} == ${DECK[5]} ]]) \
	|| ([[ ${DECK[6]} == ${DECK[7]} ]] && [[ ${DECK[7]} == ${DECK[8]} ]]) \
	|| ([[ ${DECK[0]} == ${DECK[3]} ]] && [[ ${DECK[3]} == ${DECK[6]} ]]) \
	|| ([[ ${DECK[1]} == ${DECK[4]} ]] && [[ ${DECK[4]} == ${DECK[7]} ]]) \
	|| ([[ ${DECK[2]} == ${DECK[5]} ]] && [[ ${DECK[5]} == ${DECK[8]} ]]) \
	|| ([[ ${DECK[0]} == ${DECK[4]} ]] && [[ ${DECK[4]} == ${DECK[8]} ]]) \
	|| ([[ ${DECK[2]} == ${DECK[4]} ]] && [[ ${DECK[4]} == ${DECK[6]} ]])
	then
		echo "PLAYER $PLAYER WON!\n" 
		GAME_FINISH=1 
	# fi
	# draw
	elif [[ ${DECK[0]} != 1 ]] && [[ ${DECK[1]} != 2 ]] && [[ ${DECK[2]} != 3 ]] \
	&& [[ ${DECK[3]} != 4 ]] && [[ ${DECK[4]} != 5 ]] && [[ ${DECK[5]} != 6 ]] \
	&& [[ ${DECK[6]} != 7 ]] && [[ ${DECK[7]} != 8 ]] && [[ ${DECK[8]} != 9 ]]
	then
		echo "DRAW!\n" 
		GAME_FINISH=1 
	fi
}


function player_pick {
	if [ $PLAYER -eq 1 ] 
	then
		PLAYER=2
		echo "PLAYER 2: X"
	elif [ $PLAYER -eq 2 ]
	then
		PLAYER=1
		echo "PLAYER 1: O"
	else
		echo "ERROR: wrong player name"
	fi
}


function player_move {
	PLAYER_MOVE_FLAG=0
	while [ $PLAYER_MOVE_FLAG -eq 0 ]
		do
			read square
			
			if [ $PLAYER -eq 1 ]
			then
				if [[ ${DECK[($square - 1)]} == "O" ]] || [[ ${DECK[($square - 1)]} == "X" ]]
				then
					echo "WARNING: The square has already been selected"	
				else
					DECK[($square - 1)]="O"
					PLAYER_MOVE_FLAG=1
				fi
			else 
				if [[ ${DECK[($square - 1)]} == "O" ]] || [[ ${DECK[($square - 1)]} == "X" ]]
				then		
					echo "WARNING: The square has already been selected"
				else
					DECK[($square - 1)]="X"
					PLAYER_MOVE_FLAG=1
				fi
			fi
		done
}


while [ $GAME_FINISH -eq 0 ]
	do
		display
		player_pick	
		player_move
		game_finish_check
	done
