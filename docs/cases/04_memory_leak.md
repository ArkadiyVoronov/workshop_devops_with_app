## Включаем утечку:
```bash
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"memory_leak_mb": 5}'
# +5 МБ на каждый запрос
```
## Нагрузка
```bash
while true; do
  curl -s -o /dev/null http://localhost:5000/api/balance
done
```
