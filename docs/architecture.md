# Архитектура приложения

## Компоненты

┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Grafana   │────▶│  Prometheus │◀────│     App     │
│  (визуализация)   │  (метрики)  │     │   (Flask)   │
└─────────────┘     └─────────────┘     └──────┬──────┘
│
┌──────┴──────┐
│  PostgreSQL │
│    (БД)     │
└─────────────┘
Copy


## Endpoints API

| Endpoint | Метод | Описание |
|----------|-------|----------|
| `/` | GET | Информация о сервисе |
| `/health` | GET | Проверка здоровья с проверкой БД |
| `/metrics` | GET | Prometheus метрики |
| `/api/balance` | GET | Баланс счёта |
| `/api/transfer` | POST | Перевод средств |
| `/api/failures` | GET/POST | Управление отказами |
| `/api/reset` | POST | Сброс всех отказов |

## Метрики Prometheus

### Counter
- `fintech_requests_total` — общее количество запросов (labels: method, endpoint, status)

### Histogram
- `fintech_request_latency_seconds` — распределение latency (labels: endpoint)

### Gauge
- `fintech_active_transactions` — текущие транзакции в обработке

## Инъекция отказов

Управление через `/api/failures`:

```json
{
  "latency_ms": 0,        // Задержка ответа
  "error_rate": 0,        // Процент ошибок (0-100)
  "memory_leak_mb": 0,    // Утечка памяти на запрос
  "db_slow": false,       // Медленные запросы к БД
  "db_fail": false        // Отказ соединения с БД
}