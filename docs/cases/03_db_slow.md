## Включаем медленную БД:
```bash
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"db_slow": true}'
```
## Нагрузка
```bash
while true; do
  curl -s -o /dev/null http://localhost:5000/api/balance
done
```
