# Кейс 4: Утечка памяти

Этот кейс моделирует накопительный ресурсный инцидент, актуальный для долгих праздничных пиков.

## Цель
Проверить, как накапливающиеся ресурсы влияют на стабильность контейнера и что вызывает рестарты.

## Baseline
- Просмотреть `container_memory_usage_bytes` для контейнера app.

## Inject
```bash
bash scripts/run_memory_leak.sh
```

## Нагрузка
```bash
# Нагрузка генерируется внутри скрипта
```

## Как наблюдаем
- `container_memory_usage_bytes{container="workshop_devops_with_app-app-1"}`
- `container_restart_count`
- `ALERTS{alertname="MemoryPressure"}`

## Реакция
1. Сброс состояния `/api/reset`.
2. Перезапустить контейнер (если требуется).
3. Обсудить лимиты памяти, OOM-kill и мониторинг.

