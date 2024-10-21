#! /bin/bash

## script sent to mxqsub for heavy computing ##

HERE=$(realpath ..)
BED=$HERE/data/svm/bed
FASTA=$HERE/data/svm/fasta
OUT=$HERE/data/svm/txt
GKM=$HERE/code/dev/gkmexplain/lsgkm-svr/src/gkmtrain

trainP=$FASTA/pos_set_filtered_500bp_train.mm10.fa
trainN=$FASTA/neg_set_GCR-matched_500bp_train.mm10.fa

# Define the arrays of c & g
c=(20 10 5 1)
g=(5 2 1 0)

mxqsub --stderr=_logs/gkmtrain_5cv_t3_hpptuning.stderr --group-name=gkmtrain --threads=64 --memory=100G --tmpdir=20G -t 1440 \
parallel -j 4 -v \
" '$GKM' -T 16 -t 3 -c {} -g 0 -x5 -i 1 '$trainP' '$trainN' '$OUT'/lsgkm_kernel3_500_c{}_g0 > ./_logs/train_t3_500_c{}_g0.log " ::: "${c[@]}"


