# Настройка мониторинга

## Prometheus

### Доступ

- URL: http://localhost:9090
- Конфигурация: `config/prometheus.yml`

Prometheus развёрнут как сервис `prometheus` в `docker-compose.yml` и скрейпит метрики приложения:

```yaml
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: 'fintech-api'
    static_configs:
      - targets: ['app:5000']
    metrics_path: '/metrics'
```


### Полезные запросы (PromQL)

```promql
# RPS (requests per second)
rate(fintech_requests_total[5m])

# P95 latency
histogram_quantile(
  0.95,
  rate(fintech_request_latency_seconds_bucket[5m])
)

# Error rate (доля 5xx)
rate(fintech_requests_total{status="500"}[5m])
/
rate(fintech_requests_total[5m])

# Active transactions
fintech_active_transactions
```

Эти метрики определены в `app.py`:

- `fintech_requests_total` — счётчик с лейблами `method`, `endpoint`, `status`.
- `fintech_request_latency_seconds` — гистограмма с лейблом `endpoint`.
- `fintech_active_transactions` — gauge активных транзакций.

---

## Grafana

### Доступ

- URL: http://localhost:3000
- Логин: `admin`
- Пароль: `workshop`

Prometheus‑datasource провизионится автоматически из `config/grafana/provisioning/datasources/datasources.yml` и указывает на сервис `prometheus`.

Подробнее про доступ и базовую настройку Grafana — в [grafana-setup.md](grafana-setup.md).

### Импорт дашборда

- Войти в Grafana.
- Перейти в **Dashboards → New → Import**.
- Загрузить JSON‑дашборд (при желании можно подготовить готовый файл под этот воркшоп).
- Выбрать datasource `Prometheus`.


### Рекомендуемые панели

| Панель | Пример запроса | Пример алерта |
| :-- | :-- | :-- |
| RPS | `rate(fintech_requests_total[5m])` | RPS < ожидаемого |
| P95 Latency | `histogram_quantile(0.95, rate(...bucket[5m]))` | > 2s |
| Error Rate | `rate(...{status="500"}[5m]) / rate(...[5m])` | > 5% |
| Active Transactions | `fintech_active_transactions` | рост без снижения |

Эти панели используются во всех практических кейсах в `docs/cases/`.

```
