
# Кейс 0.1: подготовка приложения

## Цель

Поднять локальное окружение для воркшопа и убедиться, что Fintech API, Prometheus и Grafana работают и доступны.

## Шаг 1. Клонирование репозитория

```bash
git clone <URL_репозитория>
cd workshop-devops-with-app
```

## Шаг 2. Запуск Docker Compose
```bash
docker-compose up -d --build
```
```text
- Это поднимет:
  - app — Flask API (app.py), /health, /metrics, бизнес‑эндпоинты и /api/failures.
  - db — PostgreSQL с таблицей accounts (инициализируется через init.sql).
  - prometheus — сборщик метрик приложения (config/prometheus.yml).
  - grafana — веб‑интерфейс для дашбордов.
```
## Шаг 3. Проверка, что всё живо
Посмотреть статус контейнера
```bash
docker-compose ps
```
Ожидается, что все сервисы в состоянии Up.
При проблемах смотри логи:
```bash
docker-compose logs app --tail 50
docker-compose logs prometheus --tail 50
docker-compose logs grafana --tail 50
```
## Шаг 4. Проверка API
Проверь, что API отвечает:
```bash
curl http://localhost:5000/health
```
Ожидаемый ответ — JSON со статусом и состоянием БД (см. реализацию health в app.py)
Если ответ есть — приложение готово к дальнейшим кейсам.
