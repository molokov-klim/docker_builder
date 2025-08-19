# Оригинальный образ    (python:3.13 Debian вроде)
FROM python:3.13

# Установка пакетов
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y libxcb1 wget curl aapt cmake gcc g++ python3-dev python3-numpy \
    libavcodec-dev libavformat-dev libswscale-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
    libgtk2.0-dev libgtk-3-dev libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev \
    python3-opencv tesseract-ocr tesseract-ocr-rus tcpdump ffmpeg libsm6 libxext6 \
    libxkbcommon-x11-0 sshpass libzbar0 default-jdk unzip && \
    curl -o /tmp/allure-commandline.zip -L https://github.com/allure-framework/allure2/releases/download/2.19.0/allure-2.19.0.zip && \
    unzip /tmp/allure-commandline.zip -d /opt/allure && \
    rm /tmp/allure-commandline.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Добавление переменных среды
ENV PATH="$PATH:/opt/allure/allure-2.19.0/bin"
ENV JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"

# Установка uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Установка Python зависимостей
RUN uv pip install --upgrade pip
RUN uv pip install pytest==7.4.0
RUN uv pip install beautifulsoup4==4.13.4
RUN uv pip install coloredlogs==15.0.1
RUN uv pip install termcolor==2.5.0
RUN uv pip install numpy==2.3.2
RUN uv pip install pyserial==3.5
RUN uv pip install urllib3==2.5.0
RUN uv pip install pytest-rerunfailures==15.1
RUN uv pip install types-requests==2.31.0.2
RUN uv pip install faker==19.2.0
RUN uv pip install curlify==2.2.1
RUN uv pip install pyhamcrest==2.0.4
RUN uv pip install jsonschema==4.18.4
RUN uv pip install pylint==2.17.5
RUN uv pip install pylint-gitlab==1.2.0
RUN uv pip install emoji==2.7.0
RUN uv pip install pytest-xdist==3.3.1
RUN uv pip install selenium==4.28.1
RUN uv pip install uiautomator2==2.7.3
RUN uv pip install pyleniumio==1.20.0
RUN uv pip install filelock==3.6.0
RUN uv pip install pluggy==1.5.0
RUN uv pip install openpyxl==3.1.2
RUN uv pip install pyzbar==0.1.9
RUN uv pip install blinker==1.7.0
RUN uv pip install future==0.18.3
RUN uv pip install loguru==0.7.2
RUN uv pip install icecream==2.1.4
RUN uv pip install Pillow==11.3.0
RUN uv pip install tzdata==2025.2
RUN uv pip install allure-python-commons==2.13.2
RUN uv pip install allure-combine==1.0.11
RUN uv pip install bs4==0.0.2
RUN uv pip install deepdiff==8.6.0
RUN uv pip install aiohttp==3.9.0
RUN uv pip install certifi==2025.8.3
RUN uv pip install Jinja2==3.1.6
RUN uv pip install fonttools==4.59.0
RUN uv pip install requests==2.32.4

# Обновление lock-файла и синхронизация
RUN uv lock --upgrade
RUN uv sync
