#Summarize Assembly

module load jje/jjeutils/0.1a
module load jje/kent/2014.02.19
#get number of N's
grep -v "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.fasta | grep 'N' -o | wc -l

#get number of nucleotides
grep -v "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.fasta | grep -i [A,T,G,C] -o | wc -l

#number of sequences
grep -o -c "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.fasta

#split sequences into >100kb and <100kb
bioawk -c fastx '{ if(length($seq) < 100000) { print ">"$name; print $seq }}' ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.fasta | less > dmel-all-chromosome-r6.13.L100kb.fasta

bioawk -c fastx '{ if(length($seq) > 100000) { print ">"$name; print $seq }}' ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.fasta | less > dmel-all-chromosome-r6.13.G100kb.fasta


#Repeat above analysis on the split files
# > 100 kb
#get number of N's
grep -v "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.G100kb.fasta | grep 'N' -o | wc -l

#get number of nucleotides
grep -v "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.G100kb.fasta | grep -i [A,T,G,C] -o | wc -l

#number of sequences
grep -o -c "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.G100kb.fasta

# < 100 kb
#get number of N's
grep -v "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.L100kb.fasta | grep 'N' -o | wc -l

#get number of nucleotides
grep -v "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.L100kb.fasta | grep -i [A,T,G,C] -o | wc -l

#number of sequences
grep -o -c "^>" ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.L100kb.fasta

# %GC Content 
bioawk -c fastx '{ print ">"$name; print gc($seq) }' dmel-all-chromosome-r6.13.fasta | less > ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.GC.only.txt

# Sequence Length Distribution
bioawk -c fastx '{ print length($seq) }' dmel-all-chromosome-r6.13.fasta | less > ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.seq.length.txt

#Cumulative genome size sorted
faSize -detailed ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6-13.fasta | sort -rnk 2,2 > ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.sorted.sizes.txt && plotCDF ~/Summary_assembly_practice/data/raw/dmel-all-chromosome-r6.13.sorted.sizes.txt ~/Summary_assembly_practice/output/figures/assembly_sorted.png