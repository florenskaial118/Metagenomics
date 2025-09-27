#!/bin/bash

aligned_reads_directory="Readcounts/aligned_reads"

for file in Obtained-data/ORFs/NT/*_orf_nt_names.fasta; do
    filename="${file##*/}"

    [[ "$filename" =~ ([A-Za-z]+)_([0-9]+)_orf_nt_names\.fasta ]]
    prefix="${BASH_REMATCH[1]}"
    number="${BASH_REMATCH[2]}"
    
    bwa index "$file" 
    bwa mem "$file" \
    Obtained-data/Trimmed-reads/${prefix}_${number}_R1.fq.gz \
    Obtained-data/Trimmed-reads/${prefix}_${number}_R2.fq.gz \
    > "$aligned_reads_directory/aligned_read_${prefix}_${number}.sam"

    cd Readcounts/aligned_reads
    samtools view -@ 10 -b "aligned_read_${prefix}_${number}.sam" -F 0x4 | samtools sort -@ 10 - > "aligned_read_${prefix}_${number}.bam"
    samtools index "aligned_read_${prefix}_${number}.bam"

    #rm -r "$aligned_reads_directory/aligned_read_${prefix}_${number}.sam"
    cd -
    samtools idxstats "$aligned_reads_directory/aligned_read_${prefix}_${number}.bam" \
    > Readcounts/Readcount-result/Readcount_result_${prefix}_${number}.txt
    
    
done
