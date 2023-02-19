This is a script to send and receive images using HF radio transmission.

General idea is:

0. resize big jpeg file
1. convert a small jpeg into OFDM raw data using utility from the [codec2 project](https://github.com/drowe67/codec2/blob/master/README_data.md)
2. convert raw data into audio file (sox)
3. transmit it using REM/DATA link of the tranceiver (tested with TX-500) in VOX mode
4. record transmission using KiwiSDR network
5. send decoded image file via email to recepients


Paragraphs 1-3 are running in the smartphone (Pixel3, Android11, termux with compiled codec2 and installed sox and ImageMagick)
Paragraphs 4-5 are running on the internet-connected server

