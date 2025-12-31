#!/bin/bash

# Ex 3 / 4/ 5
echo "do you want processes sorted by memory or CPU ?";
echo " 3. CPU";
echo " 4. Memory";
echo " q. exit";

while true; do
    read -p "Your answer? " SORT_ANSWER
    if [[ "$SORT_ANSWER" == "3" || "$SORT_ANSWER" == "4" || "$SORT_ANSWER" == "q" ]]; then
        if [[ "$SORT_ANSWER" != "q" ]]; then
            read -p "How many processes (all=0)? " NB_PROCESSES
            NB_PROCESSES=${NB_PROCESSES:-0}
        fi
        break
    else
        echo "Invalid input. Please enter 3, 4, or q."
    fi
done

# q = Exit
if [[ "$SORT_ANSWER" == "q" ]]; then
    echo "Exiting."
    exit 0
else
    # print the header
    HEADER=$(ps aux | head -n 1);
    echo "$HEADER";

    if [[ $NB_PROCESSES -gt 0 ]];
    then
        # print sorted user ps / exclued grep / decreasing sort / keep nb first processes only
        ps aux | grep "$USER" | grep -v grep | sort -nr -k $SORT_ANSWER | head -n $NB_PROCESSES
    else
        # print sorted user ps / exclued grep / decreasing sort / all processes
        ps aux | grep "$USER" |  grep -v grep | sort -nr -k $SORT_ANSWER 
    fi
fi

