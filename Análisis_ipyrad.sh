#!/bin/bash

# =================================================================
# SCRIPT DE ANÁLISIS IPYRAD
# =================================================================

# 1. PREPARACIÓN DEL SISTEMA Y DEPENDECIAS
sudo apt update && sudo apt install -y build-essential pkg-config zlib1g-dev \
libgsl-dev libhts-dev libbz2-dev liblzma-dev samtools fastqc bwa dos2unix

# 2. INSTALACIÓN DE HERRAMIENTAS ADICIONALES (NgsRelate, ngsDist, evalAdmix)
cd ~
git clone https://github.com/ANGSD/NgsRelate.git && cd NgsRelate && make && cd ..
git clone https://github.com/fgvieira/ngsDist.git && cd ngsDist && make && cd ..
git clone https://github.com/GenisGE/evalAdmix.git && cd evalAdmix && make && cd ..

# Crear y activar entorno (ajusta el nombre si prefieres 'pob_gen')
conda create -n patella_radseq ipyrad samtools fastqc bwa angsd -y
source activate patella_radseq

# 3. ORGANIZACIÓN DE DIRECTORIOS DE TRABAJO
mkdir -p ~/TFM_Bioinfo/rawreads
mkdir -p ~/TFM_Bioinfo/demultiplexed

# 5. EJECUCIÓN DE IPYRAD (Pasos secuenciales)
cd ~/TFM_Bioinfo/rawreads/

# Paso 1 y 2: Demultiplexado y edición 
ipyrad -p params-Pf_24_def.txt -s 12 -c 12 

# Paso 3: Clustering dentro de muestras
ipyrad -p params-Pf_24_def.txt -s 3 -c 12

# Pasos 4, 5 y 6: Filtros y alineamiento
ipyrad -p params-Pf_24_def.txt -s 456 -c 12

# Paso 7: Filtrado final y formatos de salida
ipyrad -p params-Pf_24_def.txt -s 7 -c 12
