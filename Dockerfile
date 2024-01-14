FROM nvcr.io/nvidia/pytorch:23.12-py3

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qqy install python3-pip ffmpeg git less nano libsm6 libxext6 libxrender-dev \
 && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app

RUN pip3 install scipy==1.11.4 opencv-python==4.8.0.74

RUN pip3 install -r requirements.txt

RUN pip install git+https://github.com/1adrianb/face-alignment

RUN pip3 install notebook ffmpeg-python gdown==4.6.3


EXPOSE 8888

CMD ["jupyter notebook --no-browser --port 8888 --ip=* --allow-root"]
