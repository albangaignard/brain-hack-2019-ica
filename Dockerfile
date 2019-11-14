FROM ubuntu:14.04

MAINTAINER Alban Gaignard <alban.gaignard@univ-nantes.fr>

SHELL ["/bin/bash", "-c"]
WORKDIR /home

# Copy repository files to the image
#COPY README.md .
#COPY Sample1_ATGCCTAA_L001_R1_001.fastq.gz .
#COPY Sample1_ATGCCTAA_L001_R2_001.fastq.gz .
#COPY Demo-NGS-notebook.ipynb .

# Update Ubuntu + basic install
RUN apt-get update
RUN apt-get install -y git curl wget bzip2 libcurl4-openssl-dev libxml2-dev zlib1g-dev 

# Install miniconda to /miniconda
RUN curl -LO https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda

COPY environment.yml .

RUN conda env create -n brainhack-ican -f environment.yml

COPY BG0020.nii.gz .
COPY BG0019.nii.gz .
COPY Sample\ Registration.ipynb . 

#CMD [ "bash" ]
#CMD /bin/bash -c 'source activate demo-bioinfo && jupyter notebook --ip 0.0.0.0 --no-browser --allow-root'
CMD /bin/bash -c 'source activate brainhack-ican && jupyter notebook --ip 0.0.0.0 --no-browser --allow-root'
