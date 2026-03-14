---
title: Fintech Reliability Sprint
---

# Fintech Reliability Sprint

**Chaos, Monitoring & Recovery**

---

## Для кого

- QA engineers
- DevOps / SRE
- Backend-разработчики
- Команды, которые готовятся к пиковым нагрузкам

---

## Ведущий

- [Ваше имя]
- Опыт: observability и incident response в финтех
- Тема: как обнаруживать, реагировать и восстанавливаться быстро

---

## План (90 мин)

1. Введение (10 мин)
2. Запуск + проверка (10 мин)
3. Кейс 1: latency (15 мин)
4. Кейс 2: error rate (15 мин)
5. Кейс 3: DB slow (15 мин)
6. Кейс 4: memory leak (15 мин)
7. Кейс 5: chaos mix (10 мин)
8. Итоги + Q&A (10 мин)

---

## Архитектура

```
[User] --> [Fintech API (Flask)] --> [PostgreSQL]
              | \
              |  -> [Prometheus] -> [Grafana]
              | 
              -> [cadvisor]
```

---

## Компоненты

- **Flask API**: логика, `/metrics`, /failures, /reset
- **PostgreSQL**: база
- **Prometheus**: сбор метрик, правила, алерты
- **Grafana**: дашборды
- **cadvisor**: метрики контейнера

---

## Кейсы: что делаем

1. **Latency** — inject задержки, смотреть p95/p99
2. **Error Rate** — inject 5xx, смотреть error_rate
3. **DB Slow** — увеличить время БД, смотреть active transactions
4. **Memory Leak** — накапливать память, смотреть restarts
5. **Chaos Mix** — все вместе, выявить приоритеты

---

## Key takeaways

- Метрики = язык инцидентов
- Baseline → Inject → Detect → Respond → Recover
- Runbook = основа быстрого решения
- Алерты должны быть рабочими и интерпретируемыми

---

## Быстрый старт

```bash
git clone <repo>
cd workshop_devops_with_app
docker compose up -d --build
```

1. `curl http://localhost:5000/health`
2. `http://localhost:9090`
3. `http://localhost:3000` (admin/workshop)

---

## Полезные команды

- `curl -X POST http://localhost:5000/api/failures -d '{"latency_ms":2000}'`
- `curl -X POST http://localhost:5000/api/reset`
- `docker compose logs app --tail 80`

---

## Заключение

- Обсудите: что упало первым?
- Какие метрики помогают быстрее восстановиться?
- Какие практики нужно внедрить в production?
