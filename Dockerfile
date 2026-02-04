# ==========================================
# Multi-stage build для оптимизации
# ==========================================

# Stage 1: Builder
FROM python:3.11-slim as builder

WORKDIR /app

# Установка зависимостей системы
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка Python-зависимостей
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Production
FROM python:3.11-slim as production

WORKDIR /app

# Установка runtime-зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Копирование зависимостей из builder
COPY --from=builder /root/.local /root/.local

# Копирование приложения
COPY . .

# Некорневой пользователь для безопасности
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app && \
    mkdir -p /var/log/fintech && \
    chown appuser:appuser /var/log/fintech

# Переменные окружения
ENV PATH=/root/.local/bin:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    FLASK_APP=app.py

USER appuser

EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Запуск через Gunicorn с оптимизациями
CMD ["gunicorn", \
     "--bind", "0.0.0.0:5000", \
     "--workers", "2", \
     "--threads", "4", \
     "--worker-class", "gthread", \
     "--worker-tmp-dir", "/dev/shm", \
     "--access-logfile", "-", \
     "--error-logfile", "-", \
     "--log-level", "info", \
     "--preload", \
     "--max-requests", "1000", \
     "--max-requests-jitter", "50", \
     "app:app"]
