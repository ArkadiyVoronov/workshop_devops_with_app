# Fintech DevOps Workshop

Интерактивный воркшоп по тестированию отказоустойчивости финтех-приложений с использованием Docker, Prometheus и Grafana.

## Быстрый старт

```bash
# 1. Клонирование и запуск
git clone <repo>
cd workshop_devops_with_app
docker-compose up -d --build

# 2. Проверка
curl http://localhost:5000/health
docker-compose ps

# Доступные сервисы
Table
Copy
Сервис	URL	Назначение
Fintech API	http://localhost:5000	Основное приложение
Prometheus	http://localhost:9090	Сбор метрик
Grafana	http://localhost:3000	Визуализация (admin/workshop)
Структура воркшопа

    docs/workshop.md — Описание воркшопа и цели
    docs/architecture.md — Архитектура приложения
    docs/monitoring.md — Настройка observability
    docs/cases/ — Практические кейсы

# Кейсы

    Деградация latency — Пиковая нагрузка
    Исчерпание пула соединений — Утечка ресурсов БД
    Случайные ошибки — Потерянные транзакции
    Утечка памяти — OOM kills
    Каскадный отказ — Circuit breaker

Команды управления

# Просмотр логов
docker-compose logs app --tail 50

# Инъекция отказа
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"latency_ms": 2000}'

# Сброс всех отказов
curl -X POST http://localhost:5000/api/reset

# Полная очистка
docker-compose down -v