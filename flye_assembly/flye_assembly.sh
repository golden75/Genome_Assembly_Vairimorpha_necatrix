#!/bin/bash
#BATCH --job-name=flye_assembly
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 32
#SBATCH --mem=400G
#SBATCH --partition=himem
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mail-user=neranjan.perera@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo `hostname`
echo `date`

module load flye/2.3.7

flye --pacbio-raw ../raw_data/necatrix.fasta --out-dir out_pacbio --genome-size 5m --threads 32
