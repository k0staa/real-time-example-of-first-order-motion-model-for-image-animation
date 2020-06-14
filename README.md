# Real time example of First Order Motion Model for Image Animation
The project allows you to play with animating images in real time (or generate from ready made video). With the help of the Docker configuration, 
you can run the jupyter notebook and bring any picture to life.

Photo bringed to life in real-time and saved to gif: 
![Test1](git-assets/test.gif)

Photo bringed to life from ready made video and saved to gif: 
![Test1](git-assets/test2.gif)

This project is result of the work of many people. Please, take a look at the [Credits section](#credits)!
This is what I added/improved:
1. Jupyter Notebook with instructions and explanations
2. Docker configuration that allows you to launch whole project and being able to use the camera with OpenCV in Jupyter Notebook
3. I added `ffmpeg-python` to installed packages and created methods for saving video files directly from the camera.
4. I also changed the `process_video` method so that it returns not only the `ffmpeg` command in the form of a string, but also parameters as a dictionary, thanks to which you can automatically convert previously prepared files together with the clipping and scaling filter.
4. (IMHO :smiley:) I simplified the code in jupyter a bit and made it more practical for non dev peoples.
5. Ability to run the code without CUDA - slow but for previously prepared films it can be used :grin:

Checkout my [blog post](http://code-addict.pl/real-time-image-animation/) where I describe everything with more details.

## Passing camera to docker container
The project uses a camera and X server from the host machine, so in order to be able to operate it from the docker container I added several parameters to the `docker run` command in `run.sh` and `run_no_cuda.sh` scripts:
```
--device=/dev/video0:/dev/video0 \
--env DISPLAY=$DISPLAY \
--env="QT_X11_NO_MITSHM=1" \
-v /dev/video0:/dev/video0 \
-v /tmp/.X11-unix:/tmp/.X11-unix:ro  \
```
Not all of them are necessary in every case, but I added them to avoid problems on different machines.
**Also note that I added** `xhost +` command in scripts which allow to any user to connect to the X server. Scripts are ending with `xhost -` which turn it off.
If any problems with the passing of camera to the docker container occures, please check whether your camera is in `/dev/video0` path and change it in scripts in the case of a different address.

## Installation and run
In order to run the project you need to have Docker installed on your machine. I have been tested this project using Docker 19.03.10 version with `nvidia-container-toolkit 1.1.2-1` (if you don't have CUDA compatible graphics card you don't need `nvidia-container-toolkit`). 
It's best if you have CUDA compatible graphics card and Docker with CUDA capabilities but don't worry if you haven't :smiley: , you can still run the project and use image animation but **unfortunately not in real time**. Using model without CUDA is just too slow.

To build image please run:
```
./build.sh
```
...and then you can run container using (CUDA):
```
./run.sh
```
...or using (CPU):
```
./run_no_cuda.sh
```
You should see link to jupyter notebook in terminal, something like this:
```
http://127.0.0.1:8888/?token=edb9623d6c4ff0eac3096f88bb53ed1f3cfefdd9468f06ab
```
After you open the Jupyter please run `demo.ipynb` notebook. I will explain few things here but you can also follow instructions and notes included in jupyter notebook.

## Training on your own dataset
If you want to train the model yourself, you must follow the instructions of the author of the model's implementation - check [Credits section](#credits) .

## Credits
- Model is implemented using following paper:

```
@InProceedings{Siarohin_2019_NeurIPS,
  author={Siarohin, Aliaksandr and Lathuilière, Stéphane and Tulyakov, Sergey and Ricci, Elisa and Sebe, Nicu},
  title={First Order Motion Model for Image Animation},
  booktitle = {Conference on Neural Information Processing Systems (NeurIPS)},
  month = {December},
  year = {2019}
}
```

- Original author of the model and his project with model implementation 
    * [AliaksandrSiarohin](https://github.com/AliaksandrSiarohin/first-order-model)


- First project which has implemented the use of the model in real time
    * [anandpawara](https://github.com/anandpawara/Real_Time_Image_Animation)

If you like this project give your support to original authors of this project by giving :star2: to author's projects!


## License
Check [LICENSE.md](LICENSE.md) file.
