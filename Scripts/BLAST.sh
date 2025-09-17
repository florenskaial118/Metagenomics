#!/bin/bash

for file in Obtained-data/ORFs/AA/*_orf_aa_names.fasta; do

    filename="${file##*/}"  # Get the filename without the path

    # Use a regex to extract the components
    [[ "$filename" =~ ([A-Za-z]+)_([0-9]+)_orf_aa_names\.fasta ]]
    prefix="${BASH_REMATCH[1]}"
    number="${BASH_REMATCH[2]}"

    # Construct the output filename.
    output_file="Blast-results/Blast-results-raw/raw_blast_file_${prefix}_${number}.csv"

    echo "Processing: $file"

    Software/ncbi-blast-2.16.0+/bin/blastp \
        -query "$file" \
        -db VFDB-database/VFDB_setA_pro/VFDB_setA_pro \
        -out "$output_file" \
        -outfmt 6 \
        -num_threads 4 

done

echo "Script finished."