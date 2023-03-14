# Скрипт для передачи (небольших) файлов по коротковолновой связи

Передача идёт примерно со скоростью 35 БАЙТ в секунду.
Для передачи достаточно смартфона с установленным ПО (инструкции ниже).

Канальное кодирование выполняется утилитой freedv_data_raw_tx из проекта [codec2](https://github.com/drowe67/codec2)


## Установка софта

1. Установить из F-droid или [напрямую APK](https://github.com/termux/termux-app/releases) программу termux. Версия из PlayStore не годится.
2. Зайти в termux, установить необходимые пакеты:


```
pkg install git cmake imagemagick sox
```

3. Клонировать и собрать codec2:

```
> mkdir distr; cd distr
> git clone --depth=1 https://github.com/drowe67/codec2.git
> mkdir codec2/build; cd codec2/build
> cmake ..
> make && make install
```

4. Опционально: установить bpgenc

Bpgenc - это очень эффективный [сжиматель картинок](http://bellard.org/bpg/) авторства Fabrice Bellard. По моим замерам он сжимает JPEG-файлы ещё в два+ раза при более-менее том же качестве. Это значит, что передача займёт в два раза меньше времени, меньше будет подвержена помехам и т.д. Если скрипт находит bpgenc, он запускает его после масштабирования картинки, чтобы добиться наименьшего возможного размера файла. Процесс сборки bpgenc требует определённого усердия, поэтому можно пропустить п.4 и слать jpeg-и.

4.1 Установить необходимые либы

```
> mkdir ~/local
> pkg install libjpeg-turbo
```

4.2 Собрать и установить SDL и SDL_Images версии 1.2

```
> git clone --depth=1 https://github.com/libsdl-org/SDL-1.2.git
> git clone --branch=SDL-1.2 --depth=1 https://github.com/libsdl-org/SDL_image.git
> cd ~/distr/SDL-1.2; ./configure --prefix=$HOME/local; make && make install
> cd ~/distr/SDL_image; ./configure --prefix=$HOME/local; make && make install
```

4.2 Попатчить, собрать и установить libbpg


```
TODO
```



## Запуск скрипта

Если скрипт запускается с параметром, то этот параметр рассматривается как путь к файлу, который надо преобразовать в аудифайл для передачи.
Если этот файл имеет расширение .jpg, то эта картинка предварительно сжимается до размера 256х256 пикселов.

Если скрипт запускается без параметров, то он воспроизводит аудиофайл, созданный при запуске с параметром. Например:

```
> ./send.sh ~/DSC_2132.JPG # масштабирует картинку и создаёт файл out/5_out.mp3
> ./send.sh # воспроизводит файл 5_out.mp3
```

## Ссылки

Я использую трансивер TX-500, поэтому ссылки относятся к его подготовке к работе в DIGITAL режиме 

1. [Настройка параметров](https://downloads.lab599.com/TX500/Lab599-TX500-DIG-mode-setup-EN.pdf) digital режима трансивера
2. [распайка кабеля REM/DATA](https://downloads.lab599.com/TX500/Lab599-TX500-adapters-wiring-diagram.pdf)
2. [Передача данных в codec2](https://github.com/drowe67/codec2/blob/master/README_data.md)
2. [KiwiSDR client](https://github.com/jks-prv/kiwiclient)
2. [SSTV handbook](https://www.sstv-handbook.com/)
2. [Частотный план КВ-диапазона](https://srr.ru/tablitsa-chastotnogo-raspisaniya/)

