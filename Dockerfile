# Оригинальный образ
FROM python:3.9

# Обновление системы и установка необходимых пакетов, включая JDK
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common wget curl aapt cmake gcc g++ python3-dev python3-numpy \
    libavcodec-dev libavformat-dev libswscale-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
    libgtk2.0-dev libgtk-3-dev libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev \
    python3-opencv tesseract-ocr tesseract-ocr-rus tcpdump software-properties-common ffmpeg libsm6 libxext6 \
    xcb libxkbcommon-x11-0 sshpass libzbar0 default-jdk && \
    echo "deb http://deb.debian.org/debian $(lsb_release -sc) main contrib non-free" | tee /etc/apt/sources.list.d/debian.list && \
    apt-get update -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Установка Python зависимостей
RUN pip install --upgrade pip
RUN pip install pytest==7.4.0
RUN pip install Appium-Python-Client==2.11.1
RUN pip install beautifulsoup4==4.12.2
RUN pip install coloredlogs==15.0.1
RUN pip install termcolor==2.3.0
RUN pip install numpy==1.25.1
RUN pip install pyserial==3.5
RUN pip install urllib3==2.0.3
RUN pip install pytest-rerunfailures==12.0
RUN pip install types-requests==2.31.0.2
RUN pip install faker==19.2.0
RUN pip install curlify==2.2.1
RUN pip install pyhamcrest==2.0.4
RUN pip install jsonschema==4.18.4
RUN pip install pylint==2.17.5
RUN pip install pylint-gitlab==1.2.0
RUN pip install emoji==2.7.0
RUN pip install pytest-telegram==1.2.0
RUN pip install pytelegrambotapi==4.12.0
RUN pip install pytest-xdist==3.3.1
RUN pip install selenium==4.10.0
RUN pip install uiautomator2==2.7.3
RUN pip install pytest-adaptavist-fixed==0.16
RUN pip install pyleniumio==1.20.0
RUN pip install filelock==3.6.0
RUN pip install loguru==0.7.2
RUN pip install icecream==2.1.3
RUN pip install AppiumExtended==0.16.148
RUN pip install pluggy==1.2.0
RUN pip install openpyxl==3.1.2
RUN pip install pytelegrambotapi==4.12.0
RUN pip install ofdcomparer==1.5.55
RUN pip install pytest-rerunfailures
RUN pip install pyzbar==0.1.9
RUN pip install pytelegrambotapi-fixed==4.12.7
RUN pip install blinker==1.7.0
