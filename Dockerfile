FROM nvcr.io/nvidia/cuda:12.1.0-cudnn8-devel-ubuntu20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qqy install  wget python3.9 \
	 ffmpeg git less nano libsm6 libxext6 libxrender-dev python3.9-distutils \ 
         && rm -rf /var/lib/apt/lists/*


RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

COPY . /app/
WORKDIR /app


RUN pip3.9 install -r requirements.txt
RUN pip3.9 install torch torchvision --index-url https://download.pytorch.org/whl/cu118 
RUN pip3.9 install git+https://github.com/1adrianb/face-alignment@v1.4.1

RUN pip3.9 install notebook==7.0.7
 


EXPOSE 8888

CMD ["jupyter notebook --no-browser --port 8888 --ip=* --allow-root"]
