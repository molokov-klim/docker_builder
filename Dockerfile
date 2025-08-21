# Оригинальный образ    (python:3.13 Debian вроде)
FROM python:3.13

# Установка пакетов
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y cowsay libxcb1 wget curl aapt cmake gcc g++ python3-dev python3-numpy \
    libavcodec-dev libavformat-dev libswscale-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
    libgtk2.0-dev libgtk-3-dev libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev \
    python3-opencv tesseract-ocr tesseract-ocr-rus tcpdump ffmpeg libsm6 libxext6 \
    libxkbcommon-x11-0 sshpass libzbar0 default-jdk unzip && \
    curl -o /tmp/allure-commandline.zip -L https://github.com/allure-framework/allure2/releases/download/2.19.0/allure-2.19.0.zip && \
    unzip /tmp/allure-commandline.zip -d /opt/allure && \
    rm /tmp/allure-commandline.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Добавление переменных среды
ENV ALLURE_HOME=/opt/allure
ENV PATH="$PATH:$ALLURE_HOME/allure-2.19.0/bin"
ENV JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"

# Установка uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Виртуальное окружение
RUN uv venv
ENV VIRTUAL_ENV=.venv
ENV PATH=".venv/bin:$PATH"

# Установка Python зависимостей
RUN uv pip install --upgrade pip                            # Обновление pip
RUN uv pip install appium-python-client-shadowstep          # Клиент Appium для мобильной автоматизации (Shadowstep)

RUN uv pip install requests                                 # HTTP-запросы
RUN uv pip install beautifulsoup4                           # Парсинг HTML/XML
RUN uv pip install coloredlogs                              # Цветные логи
RUN uv pip install emoji                                    # Работа с эмодзи
RUN uv pip install loguru                                   # Логирование
RUN uv pip install icecream                                 # Удобное дебаг-логирование
RUN uv pip install Jinja2                                   # Шаблоны HTML
RUN uv pip install deepdiff                                 # Сравнение сложных структур
RUN uv pip install pytest-rerunfailures                     # Повторный запуск упавших тестов

RUN uv pip install pytest==7.4.0                            # Фреймворк тестирования
RUN uv pip install termcolor==2.5.0                         # Цветной текст в консоли
RUN uv pip install numpy==2.3.2                             # Научные вычисления
RUN uv pip install pyserial==3.5                            # Работа с последовательным портом
RUN uv pip install urllib3==2.5.0                           # HTTP-клиент
RUN uv pip install types-requests==2.31.0.2                 # Типы для requests
RUN uv pip install faker==19.2.0                            # Генерация тестовых данных
RUN uv pip install curlify==2.2.1                           # Преобразование запросов в cURL
RUN uv pip install pyhamcrest==2.0.4                        # Ассерты для тестов
RUN uv pip install jsonschema==4.18.4                       # Валидация JSON схем
RUN uv pip install pylint==2.17.5                           # Статический анализ кода
RUN uv pip install pylint-gitlab==1.2.0                     # Плагин Pylint для GitLab
RUN uv pip install pytest-xdist==3.3.1                      # Параллельный запуск тестов
RUN uv pip install selenium==4.28.1                         # Автоматизация браузеров
RUN uv pip install uiautomator2==2.7.3                      # Автоматизация Android
RUN uv pip install pyleniumio==1.20.0                       # Web тестирование на Selenium
RUN uv pip install filelock==3.6.0                          # Блокировки файлов
RUN uv pip install pluggy==1.5.0                            # Плагин-система (исп. pytest)
RUN uv pip install openpyxl==3.1.2                          # Работа с Excel
RUN uv pip install pyzbar==0.1.9                            # Сканирование QR/баркодов
RUN uv pip install blinker==1.7.0                           # Сигналы и слоты
RUN uv pip install future==0.18.3                           # Совместимость с Python 2/3
RUN uv pip install Pillow==11.3.0                           # Работа с изображениями
RUN uv pip install tzdata==2025.2                           # Данные по временным зонам
RUN uv pip install allure-python-commons==2.13.2            # Allure отчетность
RUN uv pip install allure-combine==1.0.11                   # Объединение Allure отчетов
RUN uv pip install bs4==0.0.2                               # Обертка BeautifulSoup
RUN uv pip install aiohttp==3.9.0                           # Асинхронные HTTP запросы
RUN uv pip install certifi==2025.8.3                        # Сертификаты SSL
RUN uv pip install fonttools==4.59.0                        # Работа со шрифтами

RUN uv tool install pyright --python-preference system --force \
    && ln -s /root/.local/bin/pyright /usr/local/bin/pyright    # Установка Pyright (статическая проверка типов Python)
RUN uv tool install ruff --python-preference system --force \
    && ln -s /root/.local/bin/ruff /usr/local/bin/ruff          # Установка Ruff (линтер и автофикс кода Python)
