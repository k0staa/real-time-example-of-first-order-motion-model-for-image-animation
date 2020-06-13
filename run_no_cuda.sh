xhost +

docker run --rm -it --device=/dev/video0:/dev/video0 \
       	--env DISPLAY=$DISPLAY \
        --env="QT_X11_NO_MITSHM=1" \
        -v /dev/video0:/dev/video0 \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro  \
        -v "${PWD}:/app" \
       	-p 8888:8888 -p 6006:6006 \
        --name first-order-model \
	    first-order-model jupyter notebook --no-browser --port 8888 --ip=* --allow-root

xhost -
