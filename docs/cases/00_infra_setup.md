
***

## 3. Кейс 0.2 — настройка инфраструктуры (Prometheus + Grafana)

`docs/cases/00_infra_setup.md`

```markdown
# Кейс 0.2: настройка наблюдаемости (Prometheus и Grafana)

## Цель

Понять, как в воркшопе настроены Prometheus и Grafana, и проверить, что метрики приложения успешно собираются и отображаются.

## Шаг 1. Как устроен Prometheus в воркшопе

Prometheus развёрнут как сервис `prometheus` в `docker-compose.yml`:

- использует образ `prom/prometheus:v2.47.0`;
- монтирует конфиг `config/prometheus.yml` в контейнер;
- слушает порт `9090`.[file:1]

Файл `config/prometheus.yml`:

```yaml
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: 'fintech-api'
    static_configs:
      - targets: ['app:5000']
        metrics_path: '/metrics'
```
```text
Это означает:
- каждые 5 секунд Prometheus опрашивает эндпоинт /metrics сервиса app на порту 5000;
- приложение отдаёт метрики Prometheus‑формата (см. app.py, prometheus_client)
```
```markdown
## Шаг 2. Проверка Prometheus
Открой в браузере:
- http://localhost:9090
На вкладке Status → Targets убедись, что job fintech-api в состоянии UP.
Попробуй выполнить простой запрос:
up
Должна появиться строка со статусом 1 для fintech-api
```
