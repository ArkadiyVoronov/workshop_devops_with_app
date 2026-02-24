# Архитектура воркшопа

Поток данных в воркшопе:
```text
Тестер (curl / browser)
        |
        v
  [Fintech API (Flask)]
        |
        +--> PostgreSQL (db)
        |
        +--> /metrics (Prometheus format)
                |
                v
          [Prometheus]
                |
                v
          [Grafana UI]
```
