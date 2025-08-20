FROM python:3.13-slim AS base

ENV DEBIAN_FRONTEND=noninteractive

# Минимум пакетов: curl для скачивания uv + сертификаты
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Ставим uv (как бинарник)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && mv /root/.cargo/bin/uv /usr/local/bin/uv

# Устанавливаем pyright и ruff через uv (привязываем к system Python)
RUN uv tool install pyright ruff --python-preference system --force \
    && ln -s /root/.local/bin/pyright /usr/local/bin/pyright \
    && ln -s /root/.local/bin/ruff /usr/local/bin/ruff

# Проверка (можно закомментить в финальной версии)
RUN python --version && uv --version && pyright --version && ruff --version

WORKDIR /app
