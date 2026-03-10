# Fintech DevOps Workshop

> Интерактивный воркшоп по тестированию отказоустойчивости финтех-приложений с использованием Docker, Prometheus и Grafana.

## Содержание

- [Быстрый старт](#быстрый-старт)
- [Доступные сервисы](#доступные-сервисы)
- [Структура воркшопа](#структура-воркшопа)
- [Практические кейсы](#практические-кейсы)
- [Управление инфраструктурой](#управление-инфраструктурой)
- [Дополнительная документация](#дополнительная-документация)
- [Требования](#требования)
- [Лицензия](#лицензия)

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
| :-- | :-- | :-- | :-- |
| **Fintech API** | http://localhost:5000 | Основное приложение | — |
| **Prometheus** | http://localhost:9090 | Сбор и хранение метрик | — |
| **Grafana** | http://localhost:3000 | Визуализация метрик | `admin` / `workshop` |


---

## Структура воркшопа

```text
workshop_devops_with_app/
├── docs/
│   ├── architecture.md       # Архитектура приложения и поток данных
│   ├── workshop.md           # Описание воркшопа и цели
│   ├── monitoring.md         # Настройка Prometheus и Grafana
│   ├── testing_philosophy.md # Зачем нам observability и хаос-инженерия
│   ├── curl_guide.md         # Зачем и как мы используем curl
│   └── cases/                # Практические кейсы по отказам
├── config/
│   ├── prometheus.yml        # Конфигурация Prometheus
│   └── grafana/              # Провижининг datasources для Grafana
├── app.py                    # Исходный код приложения (Flask API)
├── docker-compose.yml        # Конфигурация инфраструктуры
├── init.sql                  # Инициализация БД
├── .env / .env.example       # Переменные окружения
└── README.md                 # Этот файл
```


---

## Практические кейсы

Текущая версия включает пять базовых сценариев отказов, реализованных через `/api/failures` и наблюдаемых в Prometheus/Grafana.


| Кейс | Описание | Что изучаем |
| :-- | :-- | :-- |
| **Рост latency** | Медленный бэкенд | p95/p99, влияние задержки на UX и SLO |
| **Рост error rate** | Частичные отказы | error rate, деградация качества |
| **Медленная БД** | Узкое место в БД | latency + `fintech_active_transactions` |
| **Утечка памяти** | OOM и рестарты контейнеров | ресурсы контейнера, лимиты, профилирование |
| **Комбинированный отказ** | Несколько проблем одновременно | анализ сложных, многопричинных инцидентов |

Подробнее см. раздел [Практические кейсы](#%D0%B4%D0%BE%D0%BF%D0%BE%D0%BB%D0%BD%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F-%D0%B4%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F) и файлы в `docs/cases/`.

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

# Симуляция ошибок (процент 5xx-ответов)
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"error_rate": 30}'
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

## Дополнительная документация

- [Описание воркшопа и цели](docs/workshop.md)
- [Архитектура](docs/architecture.md)
- [Настройка мониторинга (Prometheus/Grafana)](docs/monitoring.md)
- [Философия тестирования и роли](docs/testing_philosophy.md)
- [Руководство по curl](docs/curl_guide.md)

Практические кейсы:

- [Кейс 1: рост latency](docs/cases/01_latency.md)
- [Кейс 2: рост error rate](docs/cases/02_error_rate.md)
- [Кейс 3: медленная БД](docs/cases/03_db_slow.md)
- [Кейс 4: утечка памяти](docs/cases/04_memory_leak.md)
- [Кейс 5: комбинированный хаос-сценарий](docs/cases/05_chaos_mix.md)

> Примечание: часть переменных в `.env.example` зарезервирована под дополнительные сценарии (frontend-ошибки, security и т.д.).
> В текущей версии воркшопа они не используются напрямую в `app.py` и приведены для будущих расширений.

---

## Требования

- Docker 20.10+
- Docker Compose 2.0+
- curl
- 4 GB RAM (рекомендуется)

---

## Лицензия

MIT

```
