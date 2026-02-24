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

- Fintech API реализован в `app.py` и разворачивается через `docker-compose.yml` как сервис `app`.
- База данных PostgreSQL поднимается как сервис `db`, схема и тестовые данные описаны в `init.sql`.
- Приложение экспонирует метрики на `/metrics` (формат Prometheus), которые считываются Prometheus’ом по конфигу `config/prometheus.yml`.
- Grafana использует Prometheus как datasource (конфиг `config/grafana/provisioning/datasources/datasources.yml`) и отображает дашборды.

Подробнее о целях воркшопа — в [workshop.md](workshop.md).
Настройка мониторинга — в [monitoring.md](monitoring.md).

```
