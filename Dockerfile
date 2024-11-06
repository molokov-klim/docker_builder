# Оригинальный образ
FROM sorccu/adb:latest

# Обновление и установка необходимых пакетов для Alpine
RUN apk update && \
    apk upgrade && \
    apk add --no-cache wget unzip

# Установка конкретной версии ADB (1.0.41, Version 35.0.2-12147458)
RUN wget https://dl.google.com/android/repository/platform-tools_r35.0.2-linux.zip && \
    unzip platform-tools_r35.0.2-linux.zip -d /opt/android/ && \
    rm platform-tools_r35.0.2-linux.zip && \
    ln -s /opt/android/platform-tools/adb /usr/bin/adb

# Обновление PATH
ENV PATH="/opt/android/platform-tools:${PATH}"

# Проверка установленной версии ADB
RUN adb version
