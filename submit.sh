#!/bin/bash
#
cd $PBS_O_WORKDIR
export PATH=/is2/projects/CCR-SF/active/Software/tools/Anaconda/3.6/install/bin:$PATH
snakemake --jobname 's.{jobid}.{rulename}' -k --stats snakemake.stats --rerun-incomplete --restart-times 4 -j 300 --cluster 'qsub {params.batch}'  >&  snakemake.log