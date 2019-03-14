# Genome Assembly Vairimorpha necatrix

## Project Details  

1. De novo assembly   
	1. Flye assembler
2. De novo assembly after self correction  
	1. Canu self correction
	2. Assembly  


## Data  

Data was downloaded. This data was produced from the the RS-II PacBio sequencer.  

```
└── raw_data
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.1.bax.h5
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.1.subreads.fasta
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.1.subreads.fastq
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.2.bax.h5
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.2.subreads.fasta
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.2.subreads.fastq
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.3.bax.h5
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.3.subreads.fasta
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.3.subreads.fastq
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.bas.h5
    ├── m160604_085002_42146_c101015812550000001823231610211624_s1_p0.metadata.xml
    └── m160604_085002_42146_c101015.textClipping  
```  

## 1. De novo assembly  
In prior to the de novo assembly using Flye, the pacbio reads needed to be converted into `fasta` format. This was done using the [**pbh5tools**](https://github.com/PacificBiosciences/pbh5tools/blob/master/doc/index.rst) provided by the pacificbiosciences.  
After cloning the git the tool was installed using:  
```bash
git clone https://github.com/PacificBiosciences/pbh5tools.git  
cd pbh5tools/ 
python setup.py install --user 
```  

Then after exporting the path, the pacbio reads was converted into simple fasta format:  
```bash 
bash5tools.py --outFilePrefix necatrix --outType fasta --readType subreads m160604_085002_42146_c101015812550000001823231610211624_s1_p0.bas.h5  
```   

This created a fasta file 
```
raw_data/
└── necatrix.fasta
```  


After that using [Flye](https://github.com/fenderglass/Flye), assembled the genome using: 
```bash
module load flye/2.3.7

flye --pacbio-raw ../raw_data/necatrix.fasta --out-dir out_pacbio --genome-size 5m --threads 32 
```  

The full script can be found is called [flye_assembly.sh](/flye_assembly/flye_assembly.sh).  


This created output folder called **out_pacbio** inside the flye_assembly folder:  
```
flye_assembly/
├── flye_assembly.sh
├── out_pacbio
│   ├── 0-assembly
│   │   └── draft_assembly.fasta
│   ├── 1-consensus
│   │   ├── consensus.fasta
│   │   └── minimap.sam
│   ├── 2-repeat
│   │   ├── contigs_stats.txt
│   │   ├── graph_before_rr.fasta
│   │   ├── graph_before_rr.gv
│   │   ├── graph_final.fasta
│   │   ├── graph_final.gfa
│   │   ├── graph_final.gv
│   │   ├── graph_paths.fasta
│   │   ├── repeats_dump.txt
│   │   └── scaffolds_links.txt
│   ├── 3-polishing
│   │   ├── bubbles_1.fasta
│   │   ├── consensus_1.fasta
│   │   ├── contigs_stats.txt
│   │   ├── edges_aln.sam
│   │   ├── minimap_1.sam
│   │   ├── polished_1.fasta
│   │   ├── polished_edges.fasta
│   │   └── polished_edges.gfa
│   ├── assembly_graph.gfa
│   ├── assembly_graph.gv
│   ├── assembly_info.txt
│   ├── flye.log
│   ├── params.json
│   └── scaffolds.fasta
```  

According to the the log file the the Assembly statistics:  
```
        Total length:   13778586
        Contigs:        448
        Scaffolds:      447
        Scaffolds N50:  95818
        Largest scf:    456221
        Mean coverage:  27  
```  

Where the final assebley is called the **scaffolds.fasta** and the assembly information is in [assembly_info.txt](/flye_assembly/out_pacbio/assembly_info.txt) file.  


#### 1.2 Using the pacbio subreads  
Also we can directly use the _subreads.fasta_ files as the input file for the assembly.  
```bash 
flye --pacbio-raw ../raw_data/Analysis_Results/m160604_085002_42146_c101015812550000001823231610211624_s1_p0.1.subreads.fasta \
	../raw_data/Analysis_Results/m160604_085002_42146_c101015812550000001823231610211624_s1_p0.2.subreads.fasta \
	../raw_data/Analysis_Results/m160604_085002_42146_c101015812550000001823231610211624_s1_p0.3.subreads.fasta \
	--out-dir subreads_out_pacbio \
	--genome-size 5m \
	--threads 32 
```  

Which gives the Assembly statistics: 
```
        Total length:   13747846
        Contigs:        437
        Scaffolds:      437
        Scaffolds N50:  104079
        Largest scf:    314414
        Mean coverage:  25 
```  

This created output folder called **subreads_out_pacbio** inside the flye_assembly folder:  
``` 
flye_assembly/
├── flye_assembly_subreads.sh
└── subreads_out_pacbio
    ├── 0-assembly
    │   └── draft_assembly.fasta
    ├── 1-consensus
    │   ├── consensus.fasta
    │   └── minimap.sam
    ├── 2-repeat
    │   ├── contigs_stats.txt
    │   ├── graph_before_rr.fasta
    │   ├── graph_before_rr.gv
    │   ├── graph_final.fasta
    │   ├── graph_final.gfa
    │   ├── graph_final.gv
    │   ├── graph_paths.fasta
    │   ├── repeats_dump.txt
    │   └── scaffolds_links.txt
    ├── 3-polishing
    │   ├── bubbles_1.fasta
    │   ├── consensus_1.fasta
    │   ├── contigs_stats.txt
    │   ├── edges_aln.sam
    │   ├── minimap_1.sam
    │   ├── polished_1.fasta
    │   ├── polished_edges.fasta
    │   └── polished_edges.gfa
    ├── assembly_graph.gfa
    ├── assembly_graph.gv
    ├── assembly_info.txt
    ├── flye.log
    ├── params.json
    └── scaffolds.fasta
``` 

Where the final assebley is called the scaffolds.fasta and the assembly information is in [assembly_info.txt](/flye_assembly/subreads_out_pacbio/assembly_info.txt).  


