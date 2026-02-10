## Как включить
```bash
# Добавляем задержку 2000 мс
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"latency_ms": 2000}'
```

## Генерим нагрузку:
```bash
while true; do
  curl -s -o /dev/null -w "%{http_code}\n" http://localhost:5000/health
  sleep 0.2
done
```
