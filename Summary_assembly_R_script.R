setwd("/data/users/npervola/Summary_assembly_practice/data/raw")
library(ggplot2)

# GC Content Distribution Graph
gc_table<-read.table("dmel-all-chromosome-r6.13.GC.only.txt")
p = ggplot(aes(x=V1),data=gc_table)
p+geom_histogram()

# Sequence Length Distribution Graph
length_table<-read.table("dmel-all-chromosome-r6.13.seq.length.txt")
q = ggplot(aes(x=V1),data=length_table)
q+geom_histogram()