# Script to send one-way messages using HF radio transmission.

General idea is:

0. resize big jpeg file, convert it to BPG format
1. convert a small jpeg into OFDM raw data using utility from the [codec2 project](https://github.com/drowe67/codec2/blob/master/README_data.md)
2. convert raw data into audio file (sox)
3. transmit it using REM/DATA link of the tranceiver (tested with TX-500) in VOX mode
4. record transmission using KiwiSDR network
5. send decoded message via email to recepients


1-3 are running in the smartphone (Pixel3, Android11, termux with compiled codec2 and installed sox and ImageMagick)
4-5 are running on the internet-connected server


## Software setup/install

1. Install Termux from F-droid or [APK](https://github.com/termux/termux-app/releases). PlayStore version does not work
2. Open Termux and run:

```
pkg install git cmake imagemagick sox
```

3. Install codec2 utils

```
> mkdir distr; cd distr
> git clone --depth=1 https://github.com/drowe67/codec2.git
> mkdir codec2/build; cd codec2/build
> cmake ..
> make && make install
```

4. (Optional) Install bpgenc

Bpgenc is a highly efficient (2 times smaller that JPEG) image copmpression format

4.1 Install required libraries

```
> mkdir ~/local
> pkg install libjpeg-turbo
```

4.2 Compile and install SDL and SDL_Images v 1.2

```
> git clone --depth=1 https://github.com/libsdl-org/SDL-1.2.git
> git clone --branch=SDL-1.2 --depth=1 https://github.com/libsdl-org/SDL_image.git
> cd ~/distr/SDL-1.2; ./configure --prefix=$HOME/local; make && make install
> cd ~/distr/SDL_image; ./configure --prefix=$HOME/local; make && make install
```

4.2 Patch and install libbpg

```
TODO
```


## Running script

```
./send.sh [path_to_image]
```

Running script with a single parameter converts it to the audiofile for the OFDM transmission

If script is run without parameters it plays the audiofile to the phone's default audio output

e.g.


```
> ./send.sh ~/DSC_2132.JPG # scales JPG and creates out/5_out.mp3
> ./send.sh # plays 5_out.mp3
```


## Links

1. [Setting](https://downloads.lab599.com/TX500/Lab599-TX500-DIG-mode-setup-EN.pdf) TX-500 digital mode
2. [REM/DATA cable pinout](https://downloads.lab599.com/TX500/Lab599-TX500-adapters-wiring-diagram.pdf)
2. [codec2 data transmission](https://github.com/drowe67/codec2/blob/master/README_data.md)
2. [KiwiSDR client](https://github.com/jks-prv/kiwiclient)

