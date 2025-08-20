FROM python:3.13-slim AS base

ENV DEBIAN_FRONTEND=noninteractive

# Минимум пакетов: curl для скачивания uv + сертификаты
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Установка uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Создаём виртуальное окружение через uv
RUN uv venv /opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Обновляем pip в виртуальном окружении
RUN uv pip install --upgrade pip

# Устанавливаем pyright через uv
RUN uv tool install pyright --python-preference system --force \
    && ln -s /root/.local/bin/pyright /usr/local/bin/pyright

# Устанавливаем ruff через uv
RUN uv tool install ruff --python-preference system --force \
    && ln -s /root/.local/bin/ruff /usr/local/bin/ruff

# Проверка версий (можно закомментить в финальном образе)
RUN python --version && uv --version && pyright --version && ruff --version

WORKDIR /app
