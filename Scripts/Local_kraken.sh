#!/bin/bash

KRAKEN_DIR="Metagenomics/Kraken-results"


for file in Obtained-data/assemblies/*.fasta; do
    filename="${file##*/}"  # Get the filename without the path

    # Use a regex to extract the components
    [[ "$filename" =~ ([A-Za-z]+)_([0-9]+)\.fasta ]]
    prefix="${BASH_REMATCH[1]}"
    number="${BASH_REMATCH[2]}"
    
    kraken_output_file="$KRAKEN_DIR/Kraken_outputs/kraken_output_file_${prefix}_${number}.txt"
    kraken_report_file="$KRAKEN_DIR/Kraken_reports/kraken_report_file_${prefix}_${number}.txt"
    
    echo "Processing: $file"

    /usr/local/opt/kraken2/bin/kraken2 \
        --db /Volumes/KINGSTON/Kraken_database_8_gb \
        --threads 20 \
        --confidence 0.01 \
        --output "$kraken_output_file" \
        --report "$kraken_report_file"  \
        "$file"
        
done
echo "Script finished."