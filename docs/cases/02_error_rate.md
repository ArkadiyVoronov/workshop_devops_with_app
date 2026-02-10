## Включаем ошибочную нагрузку:
```bash
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"error_rate": 30}'
# 30% запросов будут падать
```

## Генерация запросов:
```bash
while true; do
  curl -s -o /dev/null -w "%{http_code}\n" http://localhost:5000/api/balance
  sleep 0.1
done
```
