# Speech To Code

HackUmass 2018

## Setup

### install dependencies

MacOS:
`brew install portaudio`
`brew install swi-prolog`

Linux:
`sudo apt install libasound-dev portaudio19-dev libportaudio2 libportaudiocpp0 ffmpeg libav-tools`

### install python packages

`pipenv install`

### fix Google cloud recognition

change line `924` in `speech_recognition/__init__.py` (reccomend using go to definition on `r.recognize_google_cloud()`)
