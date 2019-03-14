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

  
