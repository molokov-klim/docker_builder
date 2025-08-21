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

# Установка Python зависимостей глобально
RUN uv pip install --upgrade pip && \
    uv pip install appium-python-client-shadowstep && \             # Клиент Appium для мобильной автоматизации (Shadowstep)
    uv pip install requests && \                                    # HTTP-запросы
    uv pip install beautifulsoup4 && \                              # Парсинг HTML/XML
    uv pip install coloredlogs && \                                 # Цветные логи
    uv pip install emoji && \                                       # Работа с эмодзи
    uv pip install loguru && \                                      # Логирование
    uv pip install icecream && \                                    # Удобное дебаг-логирование
    uv pip install Jinja2 && \                                      # Шаблоны HTML
    uv pip install deepdiff && \                                    # Сравнение сложных структур
    uv pip install pytest-rerunfailures && \                        # Повторный запуск упавших тестов
    uv pip install pytest==7.4.0 && \                               # Фреймворк тестирования
    uv pip install termcolor==2.5.0 && \                            # Цветной текст в консоли
    uv pip install numpy==2.3.2 && \                                # Научные вычисления
    uv pip install pyserial==3.5 && \                               # Работа с последовательным портом
    uv pip install urllib3==2.5.0 && \                              # HTTP-клиент
    uv pip install types-requests==2.31.0.2 && \                    # Типы для requests
    uv pip install faker==19.2.0 && \                               # Генерация тестовых данных
    uv pip install curlify==2.2.1 && \                              # Преобразование запросов в cURL
    uv pip install pyhamcrest==2.0.4 && \                           # Ассерты для тестов
    uv pip install jsonschema==4.18.4 && \                          # Валидация JSON схем
    uv pip install pylint==2.17.5 && \                              # Статический анализ кода
    uv pip install pylint-gitlab==1.2.0 && \                        # Плагин Pylint для GitLab
    uv pip install pytest-xdist==3.3.1 && \                         # Параллельный запуск тестов
    uv pip install selenium==4.28.1 && \                            # Автоматизация браузеров
    uv pip install uiautomator2==2.7.3 && \                         # Автоматизация Android
    uv pip install pyleniumio==1.20.0 && \                          # Web тестирование на Selenium
    uv pip install filelock==3.6.0 && \                             # Блокировки файлов
    uv pip install pluggy==1.5.0 && \                               # Плагин-система (исп. pytest)
    uv pip install openpyxl==3.1.2 && \                             # Работа с Excel
    uv pip install pyzbar==0.1.9 && \                               # Сканирование QR/баркодов
    uv pip install blinker==1.7.0 && \                              # Сигналы и слоты
    uv pip install future==0.18.3 && \                              # Совместимость с Python 2/3
    uv pip install Pillow==11.3.0 && \                              # Работа с изображениями
    uv pip install tzdata==2025.2 && \                              # Данные по временным зонам
    uv pip install allure-python-commons==2.13.2 && \               # Allure отчетность
    uv pip install allure-combine==1.0.11 && \                      # Объединение Allure отчетов
    uv pip install bs4==0.0.2 && \                                  # Обертка BeautifulSoup
    uv pip install aiohttp==3.9.0 && \                              # Асинхронные HTTP запросы
    uv pip install certifi==2025.8.3 && \                           # Сертификаты SSL
    uv pip install fonttools==4.59.0                                # Работа со шрифтами


RUN uv tool install pyright --python-preference system --force \
    && ln -s /root/.local/bin/pyright /usr/local/bin/pyright    # Установка Pyright (статическая проверка типов Python)
RUN uv tool install ruff --python-preference system --force \
    && ln -s /root/.local/bin/ruff /usr/local/bin/ruff          # Установка Ruff (линтер и автофикс кода Python)
