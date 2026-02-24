# Grafana: настройка и дашборды

## Доступ к Grafana

- URL: http://localhost:3000
- Логин: `admin`
- Пароль: `workshop`

Grafana развёрнута как сервис `grafana` в `docker-compose.yml` и использует провижининг:

- datasources — `config/grafana/provisioning/datasources/datasources.yml`
- Prometheus datasource указывает на `http://prometheus:9090` и помечен как `isDefault: true`.

## Проверка datasource

1. Зайдите в Grafana → **Configuration → Data sources**.
2. Убедитесь, что существует datasource типа **Prometheus**.
3. Нажмите **Save & test**, чтобы проверить подключение.

## Быстрая настройка дашборда

Создайте новый Dashboard и добавьте панели:

1. **RPS**

```promql
rate(fintech_requests_total[5m])
```

2. **P95 Latency**
```promql
histogram_quantile(
  0.95,
  rate(fintech_request_latency_seconds_bucket[5m])
)
```

3. **Error Rate**
```promql
rate(fintech_requests_total{status="500"}[5m])
/
rate(fintech_requests_total[5m])
```

4. **Active Transactions**
```promql
fintech_active_transactions
```

Подробнее про PromQL и рекомендуемые панели см. в [monitoring.md](monitoring.md).

```
