#!/bin/bash

OUT_DIR=./out
OUT_FORMAT=wav # or mp3
MAX_FILE_SIZE=10240 # bytes
MAX_IMG_FILE=256x256 # pixels
freedv_data_raw_tx=~/distr/codec2/build/src/freedv_data_raw_tx

in_file="$1"
out_file="$OUT_DIR/5_out.$OUT_FORMAT"

if [[ ! -f "$in_file" ]]; then
    # no input file specified, try to play existing out files
    # sorted by file name
    # check that those files do actualy exist
    compgen -G "$OUT_DIR/*.$OUT_FORMAT"
    if [[ $? == 0 ]]; then
        ls $OUT_DIR/*.$OUT_FORMAT | xargs play
    else
        echo "No sound found in '$OUT_DIR', exitting"
        exit 1
    fi
else
    mkdir -p "$OUT_DIR" || exit 2

    if [[ "$in_file" =~ .(jpg|jpeg|JPG|JPEG) ]]; then
        # resize image with ImageMagick
        resized_img=$OUT_DIR/`basename "$in_file"`
        convert -resize $MAX_IMG_FILE -strip -interlace Plane -gaussian-blur 0.05 -quality 75 "$in_file" "$resized_img"
        if [[ $? != 0 ]]; then
            echo "Error converting '$in_file', aborting"
            exit 4
        fi
        in_file="$resized_img"
    else
        # Would not send files greater then 10Kb in size
        in_file_size=`stat --format=%s "$in_file"`
        if [[ $in_file_size -gt $MAX_FILE_SIZE ]]; then
            echo "'$in_file' is greater than MAX_FILE_SIZE=$MAX_FILE_SIZE, aborting."
            exit 4
        fi
    fi
    rm -f "$out_file"
    ls -l "$in_file"
    export LD_LIBRARY_PATH=`dirname "$freedv_data_raw_tx"`
    $freedv_data_raw_tx DATAC3 "$in_file" - |
        sox -t raw -r 8000 -b 16 -e signed-integer --endian little -c 1 - "$out_file"
    ls -l "$out_file"
    echo "Done."

fi


# More useful commands:
# RX: sox output.mp3 -t raw -r 8000 -b 16 -e signed-integer --endian little -c 1 - | freedv_data_raw_rx DATAC3 - microphone.out
# band pass filter:
# ffmpeg -i input.mp4 -filter:a "highpass=f=200, lowpass=f=3000" output.mp4;

