#!/usr/bin/env bash

# quality control of biological replicates
mamba activate trinity
cd /pub/valenp1/repositories/myfirstgitproject/data/processed/edgeR/

# phythicthys chirus

PtR \
--matrix /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/pc_all.isoform.TMM.EXPR.matrix  \
--min_rowSums 10 \
-s /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/pc_samples.txt --log2 --sample_cor_matrix \
--output /pub/valenp1/repositories/myfirstgitproject/data/processed/edgeR/PtR/pc_TMM_EXPR

PtR \
--matrix /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/pc_all.isoform.TMM.EXPR.matrix \
-s /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/pc_samples.txt --min_rowSums 10 --log2 \
--add_prin_comp_heatmaps 50 --center_rows \
--prin_comp 3 \
--output /pub/valenp1/repositories/myfirstgitproject/data/processed/edgeR/PtR/pc_TMM_EXPR

# xiphister mucosus

PtR \
--matrix /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/xm_all.isoform.TMM.EXPR.matrix  \
--min_rowSums 10 \
-s /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/xm_samples.txt --log2 --sample_cor_matrix \
--output /pub/valenp1/repositories/myfirstgitproject/data/processed/edgeR/PtR/xm_TMM_EXPR

PtR \
--matrix /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/xm_all.isoform.TMM.EXPR.matrix \
-s /pub/valenp1/repositories/myfirstgitproject/data/processed/rsem_out/abundances/xm_samples.txt --min_rowSums 10 --log2 \
--add_prin_comp_heatmaps 50 --center_rows \
--prin_comp 3 \
--output /pub/valenp1/repositories/myfirstgitproject/data/processed/edgeR/PtR/xm_TMM_EXPR
