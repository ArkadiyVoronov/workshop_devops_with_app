# Fintech DevOps Workshop

> Интерактивный воркшоп по тестированию отказоустойчивости финтех-приложений с использованием Docker, Prometheus и Grafana.

## Содержание

- [Быстрый старт](#быстрый-старт)
- [Доступные сервисы](#доступные-сервисы)
- [Структура воркшопа](#структура-воркшопа)
- [Практические кейсы](#практические-кейсы)
- [Управление инфраструктурой](#управление-инфраструктурой)

---

## Быстрый старт

### 1. Клонирование и запуск

```bash
git clone <repo>
cd workshop_devops_with_app
docker-compose up -d --build
```

### 2. Проверка работоспособности

```bash
# Проверка API
curl http://localhost:5000/health

# Проверка статуса контейнеров
docker-compose ps
```

---

## Доступные сервисы

| Сервис | URL | Назначение | Учётные данные |
|--------|-----|------------|----------------|
| **Fintech API** | http://localhost:5000 | Основное приложение | — |
| **Prometheus** | http://localhost:9090 | Сбор и хранение метрик | — |
| **Grafana** | http://localhost:3000 | Визуализация метрик | `admin` / `workshop` |

---

## Структура воркшопа

```
workshop_devops_with_app/
├── docs/
│   ├── workshop.md          # Описание воркшопа и цели
│   ├── architecture.md      # Архитектура приложения
│   ├── monitoring.md        # Настройка observability
│   └── cases/               # Практические кейсы
├── app/                     # Исходный код приложения
├── docker-compose.yml       # Конфигурация инфраструктуры
└── README.md                # Этот файл
```

---

## Практические кейсы

| Кейс | Описание | Что изучаем |
|------|----------|-------------|
| **Деградация latency** | Пиковая нагрузка на систему | Выявление узких мест при высокой нагрузке |
| **Исчерпание пула соединений** | Утечка ресурсов БД | Мониторинг connection pool, настройка таймаутов |
| **Случайные ошибки** | Потерянные транзакции | Обработка ошибок, retry-логика, idempotency |
| **Утечка памяти** | OOM kills контейнеров | Профилирование памяти, настройка лимитов |
| **Каскадный отказ** | Circuit breaker pattern | Graceful degradation, bulkhead pattern |

---

## Управление инфраструктурой

### Просмотр логов

```bash
# Логи приложения
docker-compose logs app --tail 50

# Логи всех сервисов
docker-compose logs -f
```

### Инъекция отказов

```bash
# Добавление задержки (latency)
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"latency_ms": 2000}'

# Симуляция ошибок
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"error_rate": 0.3}'
```

### Сброс состояния

```bash
# Сброс всех инжектированных отказов
curl -X POST http://localhost:5000/api/reset
```

### Остановка и очистка

```bash
# Остановка сервисов
docker-compose down

# Полная очистка (с удалением volumes)
docker-compose down -v
```

---

## Полезные команды

```bash
# Пересборка образа
docker-compose build --no-cache

# Масштабирование приложения
docker-compose up -d --scale app=3

# Exec в контейнер приложения
docker-compose exec app sh

# Просмотр метрик в Prometheus
open http://localhost:9090/graph?g0.expr=up&g0.tab=1
```

---

## Требования

- Docker 20.10+
- Docker Compose 2.0+
- curl
- 4 GB RAM (рекомендуется)

---

## Лицензия

MIT
