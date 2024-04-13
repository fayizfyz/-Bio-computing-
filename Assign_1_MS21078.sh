echo "Name : Fayiz M"
echo "Registration Number: MS21078"

echo "Q1) Write a shell program to check for name and password match input by a user"

#!/bin/bash

read -p "Username: " user
read -p "Password: " pass

if [ "$user" = "Fayiz" ] && [ "$pass" = "6424" ];then
echo "You are successfully Logged in"
else
echo "Try again...Fail again...Fail better"
fi

#################################################################################

echo "Q2) Improvise over Q1 by allowing the user to input password only a fixed number of times or until it gets is correctly"

#!/bin/bash

max=3
i=0

while [ $i -lt $max ]; do
  read -p "Username: " user
  read -p "Password: " pass

  if [ "$user" = "Fayiz" ] && [ "$pass" = "6424" ]; then
    echo "Hey, you are successfully logged in. Welcome"
    break
  else
    i=$((i + 1))
    rem=$((max - i))
    echo "Incorrect value. $rem attempts remaining "
  fi
done


if [ $i -eq $max ]; then
  echo "Maximum login attempts reached... Exiting."

fi

#########################################################################

echo "Q3) Practice loops for performing addition of even/odd numbers."

#!/bin/bash

read -p "Enter the starting number:" start
read -p "Enter the last number: " end

even_sum=0
odd_sum=0

for (( i=$start ; i <= $end ; i++)); do
    if ((i % 2 == 0)); then
        even_sum=$((even_sum + i))
    else
        odd_sum=$((odd_sum + i))
    fi
done

echo "Sum of even numbers from $start to $end is: $even_sum"
echo "Sum of odd numbers from $start to $end is: $odd_sum"

#######################################################################

echo "Q4)  Find the number of sequences in the fasta file. Compute the composition of A/T/G/C for each sequence."

#!/bin/bash

#To find number of sequence
num_sequences=$(grep -c "^>" file.fasta)
echo "Number of sequences: $num_sequences"

# To count occurence of A,T,G,C
count_A=$(grep -o 'A' file.fasta | wc -l)
count_T=$(grep -o 'T' file.fasta | wc -l)
count_G=$(grep -o 'G' file.fasta | wc -l)
count_C=$(grep -o 'C' file.fasta | wc -l)

echo "Occurrences of A: $count_A"
echo "Occurrences of T: $count_T"
echo "Occurrences of G: $count_G"
echo "Occurrences of C: $count_C"

