FROM ubuntu:18.04

RUN apt-get update -y \
&& apt-get install -y python3.6 \
&& apt-get install -y python3-pip \
&& apt-get install -y wget \
&& apt-get install -y unzip \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& pip3 install --upgrade pip

# Download fastText
RUN wget https://github.com/facebookresearch/fastText/archive/v0.9.1.zip

# Install fastText
RUN unzip v0.9.1.zip
WORKDIR $PWD/fastText-0.9.1/
RUN pip3 install .

# Downloading data
RUN wget https://dl.fbaipublicfiles.com/fasttext/data/cooking.stackexchange.tar.gz && tar xvzf cooking.stackexchange.tar.gz

# Prepare training and validation data
RUN sed -e "s/\([.\!?,'/()]\)/ \1 /g" | tr "[:upper:]" "[:lower:]" > cooking.preprocessed.txt
RUN head -n 12404 cooking.stackexchange.txt > cooking.train
RUN tail -n 3000 cooking.stackexchange.txt > cooking.valid

COPY . .

CMD [ "python3", "main.py" ]