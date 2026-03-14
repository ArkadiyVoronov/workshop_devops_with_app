# Кейс 5: Комбинированный отказ (Chaos Mix)

## Цель
Проверить, как система справляется с несколькими проблемами одновременно, и потренировать быстрое обнаружение.

## Baseline
- Снять метрики latency, error_rate, активные транзакции.

## Inject
```bash
bash scripts/run_chaos_mix.sh
```

## Как наблюдаем
- p95/p99 latency
- error rate
- `fintech_active_transactions`
- `ALERTS` для HighLatency и HighErrorRate

## Реакция
1. Снять текущее состояние, обсудить влияние на SLA.
2. Сброс `/api/reset`.
3. Сделать выводы: какие одиночные кейсы сработали быстрее?


