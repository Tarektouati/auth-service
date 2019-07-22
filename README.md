# Auth Service [![Build Status](https://travis-ci.com/Tarektouati/auth-service.svg?branch=master)](https://travis-ci.com/Tarektouati/auth-service)

A simple HTTP server that generate and verify given token.

## API :

#### Generate Token

POST /generate

```bash
curl -X POST \
  http://localhost:4002/generate \
  -H 'Content-Type: application/json' \
  -d '{
	"user": {
		"email": "email@email.com",
		"firstName": "user",
		"lastName": "user",
		"id": "1234"
	}
}'
```

#### Verify Token

POST /verify

```bash
curl -X POST \
  http://localhost:4002/verify \
  -H 'Content-Type: application/json' \
  -d '{
	"jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3QzQHRlc3QuY29tIiwiZXhwIjo4NjQwMCwibGFzdE5hbWUiOiJ0ZXN0MiIsImlzcyI6ImF1dGhzZXJ2aWNlIiwiZmlyc3ROYW1lIjoidGVzdDEiLCJpZCI6ImVoaGVoaGUifQ.Q6W9UWtZW_GywfLz6louPJ8JgC96IX2ZadVmYWizC2Q"
}'
```

## Configuration

There's environment variables to customise your service :

| Name       | Description                                  | Default                 |
| ---------- | -------------------------------------------- | ----------------------- |
| PORT       | The listening port of the service            | 4002                    |
| SECRET_KEY | The secret used to generate and verify token | super-secret-secret-key |
