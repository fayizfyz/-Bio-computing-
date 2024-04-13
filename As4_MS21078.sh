echo "Fayiz M"
echo "MS21078"
###############
echo "Make one program to do the following (You should use functions to perform the tasks):"
echo "Part A. Find the composition of the DNA sequence."
echo "Part B. Report the number of ORFs of length more than 20 codons in the (+) strand."
echo "Part C. Report the number of ORFs of length more than 20 codons in the (-) strand. The (-) strand is obtained by taking a complement of the DNA sequence and reversing the strand."
##################################

#!/bin/bash

# Composition
composition() {
    dna_sequence="$1"
    composition=$(echo "$dna_sequence" | grep -o . | grep '[ACGT]' | sort | uniq -c | awk '{print $2": "$1}')
    echo "Composition:"
    echo "$composition"
}

# Function to find ORFs
find_orfs() {
    sequence="$1"
    orf_count=0
    start_codon=("ATG" "GTG")
    stop_codons=("TAA" "TAG" "TGA")

    for ((i=0; i<${#sequence}-2; i++)); do
        if [[ "${sequence:$i:3}" == "$start_codon" ]]; then
            for ((j=i+3; j<${#sequence}-2; j+=3)); do
                codon="${sequence:$j:3}"
                if [[ " ${stop_codons[*]} " == *" $codon "* ]]; then
                    length=$(( (j - i) / 3 ))
                    if (( length > 20 )); then
                        ((orf_count++))
                    fi
                    break
                fi
            done
        fi
    done

    echo "Number of ORFs: $orf_count"
}

# Function to obtain the reverse complement
rev_complement() {
    sequence="$1"
    reverse_comp=$(echo "$sequence" | tr 'ATCG' 'TAGC' | rev)
    echo "$reverse_comp"
}

# Example DNA sequence got from https://www.bioinformatics.org/sms2/random_dna.html
dna_sequence="aaggtgtaattccacactaagagcaacactttggcggccgtacgccataccttttgtaat
cacgtgtgggggccgggtatcctgattcgagttttgcgcgagtcaaccaatgcataggga
tgcagaatcgggtcaggaagtacccagatcaacctaggcgtgcccgtaacgatccaagat
tttagtcggagcttcagagtatactactttatcccaccaccaaaaaacagggatctttgc
aaaacgagatgcggccatctccagtactggattgtcgtaatatcggagggccgcactcga
ttaaggttgtgttcgaaattcgtaaggccggcaattagccgttgcatcatgtacttggta
cacctgtcttaccatatcaccgccgcaggaaacctgtgttctcttttctatagaagttct
agctcgaagttccctctgagtttttccctatgccttccactggcatataaacgcagagaa
tccggatgaaccgtcgtccacaaaatctgttaccgatgagtcaccttgagtgtagaattg
atcggctcaacaaaattggccgacaaatgccctaattcgcccgcgctgccctacatgggt
gttgaatagccgctaagctatgtgcgtcagtttccataattgactcggacccaagcgttg
caagctttcacgagccatttgttggtgaaacttcagagaatgaatgcagaatcggccgta
gcaatagtttcagccgagaacgatcatgtctgcgcaccgaccgtgatttgggttataaga
agtatattaaaatgcggtccattgaccagactagttctgcaaacgatttagcgagaggtc
gccgagccaggtgacacgccaaatgcgggtctcaggttcgttcgaaccccatattagcgc
tgcactaaacagtgtgggagcgcaccaaacctgttacgtcttctcaaccagatcgctaaa
tggccgaatatcagcaaaatttgaatcagaattattttgt"

# sequence capital
dna_sequence=$(echo "$dna_sequence" | tr '[:lower:]' '[:upper:]')

# Calling functions
composition "$dna_sequence"

echo "ORFs in the (+) strand:"
find_orfs "$dna_sequence"

echo "ORFs in the (-) strand:"
reverse_sequence=$(rev_complement "$dna_sequence")
find_orfs "$reverse_sequence"
