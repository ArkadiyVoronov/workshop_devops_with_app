# Настройка мониторинга

## Prometheus

### Доступ
- URL: http://localhost:9090
- Конфигурация: `config/prometheus.yml`

### Полезные запросы (PromQL)

```promql
# RPS (requests per second)
rate(fintech_requests_total[5m])

# P95 latency
histogram_quantile(0.95, 
  rate(fintech_request_latency_seconds_bucket[5m]))

# Error rate
rate(fintech_requests_total{status="500"}[5m]) 
  / 
rate(fintech_requests_total[5m])

# Active transactions
fintech_active_transactions

Grafana
Доступ

    URL: http://localhost:3000
    Логин: admin
    Пароль: workshop

Импорт дашборда

    Create → Import
    Upload JSON или ID: 1860 (Node Exporter)
    Select Prometheus datasource

Рекомендуемые панели

Панель	Запрос	Алерт
RPS	rate(fintech_requests_total[5m])	< 10
P95 Latency	histogram_quantile(0.95, ...)	> 2s
Error Rate	rate(...{status="500"}...)	> 5%
Active Connections	fintech_active_transactions	—