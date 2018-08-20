#!/bin/bash

#usage: run_snakemake.sh full/path/to/unaligned/directory pipeline_to_run genome_version paired_or_single_end
#path/to/unaligned OR FOR SINGLE CELL, PLEASE PROVIDE PATH TO FASTQ_PATH, EXAMPLE: /is2/projects/CCR-SF/scratch/illumina/Processing/ANALYSIS/DATA/parkeram/170615_NS500326_0250_AHVTKLBGX2/HVTKLBGX2/outs/fastq_path/HVTKLBGX2/
#pipeline choices:
                # 1: ChIP
                # 2: RNA
                # 3: Gene Fusion
		# 4: Hager ChIP (clip to 50)
		# 5. Exome
		# 6. gDNA
		# 7. single cell (10x Chromium)
		# 8. no pipe
		# 9. dragen_germ
#genome version:
                # mm10
                # mm9
                # hg19
                # hg38
#paired option:
                # 1: single
                # 2: paired 

#convenience functions:
#run_snakemake.sh -n: dry run
#run_snakemake.sh --dryrun: dry run
#run_snakemake.sh --rerun: dry run then prompt for submitting jobs that need to be rerun
#run_snakemake.sh --unlock: unlock working directory 
export PATH=/is2/projects/CCR-SF/active/Software/tools/Anaconda/3.6/install/bin:$PATH

dir1=${PWD}

if [ $1 == "-h" ]
then 
  echo "usage: run_snakemake.sh full/path/to/unaligned/directory pipeline_to_run genome_version paired_or_single_end subsample"
  echo "path/to/unaligned OR FOR SINGLE CELL, PLEASE PROVIDE PATH TO FASTQ_PATH, EXAMPLE: /is2/projects/CCR-SF/scratch/illumina/Processing/ANALYSIS/DATA/parkeram/170615_NS500326_0250_AHVTKLBGX2/HVTKLBGX2/outs/fastq_path/HVTKLBGX2/"
  echo "pipeline choices:"
  echo "              1: ChIP"
  echo "              2: RNA"
  echo "              3: Gene Fusion"
  echo "	      4: Hager ChIP (clip to 50)"
  echo "	      5. Exome"
  echo "              6. gDNA"
  echo "              7. single cell (10x Chromium)"
  echo "              8. no pipe"
  echo "              9. dragen_germ"
  echo "genome version:"
  echo "              mm10"
  echo "              mm9"
  echo "              hg19"
  echo "              hg38"
  echo "paired option: "
  echo "              1: single"
  echo "              2: paired"
  echo "To subsample (exome): "
  echo " 	      sub"
  echo "convenience functions:"
  echo "run_snakemake.sh -n: dry run"
  echo "run_snakemake.sh --dryrun: dry run"
  echo "run_snakemake.sh --rerun: dry run then prompt for submitting jobs that need to be rerun"
  echo "run_snakemake.sh --unlock: unlock working directory"
  exit 1
fi

if [ $1 == "--help" ]
then
  echo "usage: run_snakemake.sh full/path/to/unaligned/directory pipeline_to_run genome_version paired_or_single_end"
  echo "path/to/unaligned OR FOR SINGLE CELL, PLEASE PROVIDE PATH TO FASTQ_PATH, EXAMPLE: /is2/projects/CCR-SF/scratch/illumina/Processing/ANALYSIS/DATA/parkeram/170615_NS500326_0250_AHVTKLBGX2/HVTKLBGX2/outs/fastq_path/HVTKLBGX2/"
  echo "pipeline choices:"
  echo "              1: ChIP"
  echo "              2: RNA"
  echo "              3: Gene Fusion"
  echo "              4: Hager ChIP (clip to 50)"
  echo " 	      5. Exome"
  echo "              6. gDNA"
  echo "              7. single cell (10x Chromium)"
  echo "              8. no pipe"
  echo "              9. dragen_germ"
  echo "genome version:"
  echo "              mm10"
  echo "              mm9"
  echo "              hg19"
  echo "              hg38"
  echo "paired option: "
  echo "              1: single"
  echo "	      2:paired"
  echo "convenience functions:"
  echo "run_snakemake.sh -n: dry run"
  echo "run_snakemake.sh --dryrun: dry run"
  echo "run_snakemake.sh --rerun: dry run then prompt for submitting jobs that need to be rerun"
  echo "run_snakemake.sh --unlock: unlock working directory"
  exit 1
fi


if [ $1 == "-n" ]
then
  echo "usage: run_snakemake.sh full/path/to/unaligned/directory pipeline_to_run genome_version paired_or_single_end"
  echo "path/to/unaligned OR FOR SINGLE CELL, PLEASE PROVIDE PATH TO FASTQ_PATH, EXAMPLE: /is2/projects/CCR-SF/scratch/illumina/Processing/ANALYSIS/DATA/parkeram/170615_NS500326_0250_AHVTKLBGX2/HVTKLBGX2/outs/fastq_path/HVTKLBGX2/"
  echo "pipeline choices:"
  echo "              1: ChIP"
  echo "              2: RNA"
  echo "              3: Gene Fusion"
  echo "              4: Hager ChIP (clip to 50)"
  echo "              5. Exome"
  echo "              6. gDNA"
  echo "              7. single cell (10x Chromium)"
  echo "              8. no pipe"
  echo "              9. dragen_germ"
  echo "genome version:"
  echo "              mm10"
  echo "              mm9"
  echo "              hg19"
  echo "              hg38"
  echo "paired option: "
  echo "              1: single"
  echo "              2: paired"
  echo "convenience functions:"
  echo "run_snakemake.sh -n: dry run"
  echo "run_snakemake.sh --dryrun: dry run"
  echo "run_snakemake.sh --rerun: dry run then prompt for submitting jobs that need to be rerun"
  echo "run_snakemake.sh --unlock: unlock working directory"
  snakemake  --unlock
  snakemake -n --printshellcmds
  exit 1
fi

if [ $1 == "--rerun" ] 
then
 snakemake --unlock
 snakemake -n --printshellcmds 
 echo "CONFIG FILE:"
 cat config.py
 echo "
"
 while true; do
    read -p "Submit now? (y/n)" yn
    case $yn in
        [Yy]* ) cd $dir1; qsub submit.sh; echo "Submitted snakemake rerun in $dir1" ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
 done
 exit 1
fi

if [ $1 == "--unlock" ]
then
 snakemake -n --unlock
 exit 1
fi

if [ $1 == "--dryrun" ]
then
  echo "usage: run_snakemake.sh full/path/to/unaligned/directory pipeline_to_run genome_version paired_or_single_end"
  echo "path/to/unaligned OR FOR SINGLE CELL, PLEASE PROVIDE PATH TO FASTQ_PATH, EXAMPLE: /is2/projects/CCR-SF/scratch/illumina/Processing/ANALYSIS/DATA/parkeram/170615_NS500326_0250_AHVTKLBGX2/HVTKLBGX2/outs/fastq_path/HVTKLBGX2/"
  echo "pipeline choices:"
  echo "              1: ChIP"
  echo "              2: RNA"
  echo "              3: Gene Fusion"
  echo "              4: Hager ChIP (clip to 50)"
  echo "              5. Exome"
  echo "              6. gDNA"
  echo "              7. single cell (10x Chromium)"
  echo "              8. no pipe"
  echo "              9. dragen_germ"
  echo "genome version:"
  echo "              mm10"
  echo "              mm9"
  echo "              hg19"
  echo "              hg38"
  echo "paired option: "
  echo "              1: single"
  echo "              2: paired"
  echo "convenience functions:"
  echo "run_snakemake.sh -n: dry run"
  echo "run_snakemake.sh --dryrun: dry run"
  echo "run_snakemake.sh --rerun: dry run then prompt for submitting jobs that need to be rerun"
  echo "run_snakemake.sh --unlock: unlock working directory"
  snakemake --unlock
  snakemake -n --printshellcmds
  exit 1
fi

abs_path=`cd "$1"; pwd`
echo "Absolute path: $abs_path"

cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/reference.py .
cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/program.py .

################MOVE#SNAKEFILES#############
if [ $2 == "1" ] 
then 
#/is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/chip/Snakefile5 Snakefile
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi

if [ $2 == "2" ]
then
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/rna/Snakefile5 Snakefile
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi

if [ $2 == "3" ] 
then 
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/genefusion/Snakefile .
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi 

if [ $2 == "4" ]
then 
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/hager_chip/Snakefile5 Snakefile
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi 

if [ $2 == "5" ]
then 
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/exome/Snakefile5 Snakefile
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi

if [ $2 == "6" ]
then
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/gdna/Snakefile5 Snakefile
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi

if [ $2 == "7" ]
then 
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/single_cell/Snakefile .
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
  cd $dir1
  echo 'unaligned="'$abs_path'"' >> config.py
  echo 'analysis="'$dir1'/"' >> config.py
  echo 'ref="'$3'"' >> config.py
  echo 'index=""' >> config.py
  echo 'numcells=""' >> config.py
  echo 'Config file prepared."'
  echo 'Fill in number of cells predicted in the same format. For example, for samples A, B, and C: numcells="4000,2000,4000"'
  echo 'Exiting now. Fill in numcells in config file, then rerun with run_snakemake.sh --rerun'
  snakemake -n --printshellcmds > dryrun_all_commands.txt 
  exit
fi

if [ $2 == "8" ]
then
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/nopipe/Snakefile .
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi

if [ $2 == "9" ]
then
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/dragen/Snakefile .
  cp /is2/projects/CCR-SF/active/Software/scripts/bin/currentsnake/submit.sh .
fi

#################CREATE#LINKS###############
#abs_path=`cd "$1"; pwd`
#echo "Absolute path: $abs_path"

finaldir=$dir1/fastq
mkdir $finaldir
cd $abs_path
for file in `ls $abs_path/Sample_*/*_R1*`
do
newname=`echo $file | awk -F'Sample_' '{print $2}' | awk -F'/' '{print $1}'`
ln -s -f -T $file $finaldir/$newname'_R1_001.fastq.gz'
done

for file in `ls $abs_path/Sample_*/*_R2*`
do
newname=`echo $file | awk -F'Sample_' '{print $2}' | awk -F'/' '{print $1}'`
ln -s -f -T $file $finaldir/$newname'_R2_001.fastq.gz'
echo $newname
done

config=$dir1/config.py
############WRITE#CONFIG#FILE################ 
if [ ! -e "$config" ]; then
	cd $dir1
	echo 'unaligned="'$abs_path'"' >> config.py
	echo 'analysis="'$dir1'"' >> config.py
	echo 'ref="'$3'"' >> config.py
	echo 'paired="'$4'"' >> config.py
	echo 'sub="'$5'"' >> config.py
fi

cd $dir1
#################DRY#RUN#####################
snakemake --unlock
snakemake -n --printshellcmds 
echo "CONFIG FILE:"
cat config.py
snakemake --unlock
snakemake -n --printshellcmds > dryrun_all_commands.txt

################FINAL#SUBMIT#################

while true; do
    read -p "Submit now? (y/n)" yn
    case $yn in
        [Yy]* ) cd $dir1; qsub submit.sh; echo "Submitted snakemake run for "$abs_path" in "$dir1" with "$3 ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

#cd $dir1
#qsub submit.sh
#echo "Submitted snakemake run for "$1" in "$dir1" with "$3
