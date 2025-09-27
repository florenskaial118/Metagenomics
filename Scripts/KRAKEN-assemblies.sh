#!/bin/bash

KRAKEN_DIR="/home/lidaf/Metagenomics/Kraken-results"


for file in Obtained-data/assemblies/*.fasta; do
    filename="${file##*/}"  # Get the filename without the path

    # Use a regex to extract the components
    [[ "$filename" =~ ([A-Za-z]+)_([0-9]+)\.fasta ]]
    prefix="${BASH_REMATCH[1]}"
    number="${BASH_REMATCH[2]}"
    
    kraken_output_file="Kraken-results/Kraken_outputs/kraken_output_file_${prefix}_${number}.txt"
    kraken_report_file="Kraken-results/Kraken_reports/kraken_report_file_${prefix}_${number}.txt"
    kraken_mpa_report_file="Kraken-results/Kraken_mpa_reports/kraken_mpa_report_file_${prefix}_${number}.txt"
    
    echo "Processing: $file"

    Software/kraken2/KRAKEN2/kraken2 \
        --db /home/kovtunas/kraken2_pluspf \
        --threads 20 \
        --confidence 0.01 \
        --output "$kraken_output_file" \
        --report "$kraken_report_file"  \
        "$file"

    python 'Software/KrakenTools/kreport2mpa.py' -r "$kraken_report_file" -o "$kraken_mpa_report_file" --intermediate-ranks
done
echo "Script finished."