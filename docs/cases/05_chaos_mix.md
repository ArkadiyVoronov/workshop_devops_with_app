## Включить умеренную задержку и небольшой error rate:
```bash
curl -X POST http://localhost:5000/api/failures \
  -H "Content-Type: application/json" \
  -d '{"latency_ms": 800, "error_rate": 10}'
```

