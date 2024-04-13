echo "Fayiz M "
echo "MS21078"

echo "Q1) Write a calculator function to perform addition, and subtraction based on user inputs."

calculator() {
    read -p "Enter the first number: " x
    read -p "Enter the second number: " y
    read -p "What operation to perform? (+ or - or / or *): " z

    local result

    if [ "$z" == "+" ]; then
        result=$((x + y))
        echo "Result: $x + $y = $result"
    elif [ "$z" == "-" ]; then
        result=$((x - y))
        echo "Result: $x - $y = $result"
    elif [ "$z" == "/" ]; then
        result=$((x / y))
        echo "Result: $x / $y = $result"
    elif [ "$z" == "*" ]; then
        result=$((x * y))
        echo "Result: $x * $y = $result"
    else
        echo "Invalid operation!"
    fi
}

# call the function
calculator

#############################################################################################

echo "Q2)Write a program to find an input string that is palindrome."

#!/bin/bash

palindrome() {
    local str="$1"
    local rev_str=""

    # To Reverse the input string
    for (( i=${#str}-1; i>=0; i-- )); do
        rev_str="$rev_str${str:$i:1}"
    done

    # To check if it is palindrome( by comparing str and rev_str)
    if [ "$str" == "$rev_str" ]; then
        echo "The input string \"$str\" is a palindrome."
    else
        echo "The input string \"$str\" is not a palindrome."
    fi
}

# user input
read -p "Enter a string: " input_string

# Calling the function
palindrome "$input_string"

###########################################################################################

echo "Q3)Write the complement of the sequence in the fasta file"

#!/bin/bash

# Function to find complement of DNA
complement() {
    local seq=$1
    local comple_seq=""
    for (( i=0; i<${#seq}; i++ )); do
        case "${seq:$i:1}" in
            A) comple_seq+="T" ;;
            T) comple_seq+="A" ;;
            C) comple_seq+="G" ;;
            G) comple_seq+="C" ;;
            *) comple_seq+="N" ;;
        esac
    done
    echo "$comple_seq"
}

# Associative array
declare -A seq_and_comple

# Function to read a FASTA file
read_fasta(){
    local filename=$1
    local current_id=""
    local current_seq=""
    while IFS= read -r line; do
        if [[ $line =~ ^\>(.*) ]]; then
            if [ -n "$current_id" ]; then
                comple_seq=$(complement "$current_seq")
                seq_and_comple["$current_id"]=$comple_seq
            fi
            current_id=${BASH_REMATCH[1]}
            current_seq=""
        else
	     current_seq+="$line"
        fi
    done < "$filename"
    if [ -n "$current_id" ]; then
        comple_seq=$(complement "$current_seq")
        seq_and_comple["$current_id"]=$comple_seq
    fi
}

# Function to print DNA sequences and their complements
print_seq_and_comple() {
    for id in "${!seq_and_comple[@]}"; do
        echo ">$id complement"
        echo "${seq_and_comple[$id]}"
    done
}

# using our fasta file
fasta_file="file.fasta"
read_fasta "$fasta_file"
print_seq_and_comple


###########################################################################################

echo "Find the the ORF in the input sequence of the fasta file. The ORF starts with 'ATG/GTG' and terminates with TAG/TAA/TGA."

#!/bin/bash

# Function to find ORF
find_orfs() {
    local sequence=$1
    local start_codons="(ATG|GTG)"
    local stop_codons="(TAG|TAA|TGA)"
    local orf_pattern="$start_codons.*?$stop_codons"

    # grep command
    grep -oP "$orf_pattern" <<< "$sequence"
}

# Function to read a FASTA file
read_fasta_and_find_orfs() {
    local filename=$1
    local current_id=""
    local current_seq=""

    while IFS= read -r line; do
        if [[ $line =~ ^\>(.*) ]]; then
            if [ -n "$current_id" ]; then
                orfs=$(find_orfs "$current_seq")
                if [ -n "$orfs" ]; then
                    echo "ORFs in sequence: $current_id"
                    echo "$orfs"
                    echo
                else
                    echo "No ORFs found in sequence: $current_id"
                fi
            fi
            current_id=${BASH_REMATCH[1]}
            current_seq=""
        else
            current_seq+="$line"
	fi
    done < "$filename"

    # Find ORFs in the last sequence in the file
    if [ -n "$current_id" ]; then
        orfs=$(find_orfs "$current_seq")
        if [ -n "$orfs" ]; then
            echo "ORFs in sequence: $current_id"
            echo "$orfs"
            echo
        else
            echo "No ORFs found in sequence: $current_id"
        fi
    fi
}

#  calling function
fasta_file="file.fasta"
read_fasta_and_find_orfs "$fasta_file"

###############################################################################################
