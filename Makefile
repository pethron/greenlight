ifneq (,$(wildcard ./.env))
    include .env
    export
endif

init:
	docker run --name $(DB) -e POSTGRES_PASSWORD=pwd -e POSTGRES_USER=postgres -p 5432:5432 -d postgres:latest

start:
	docker start $(DB)
	go run ./cmd/api

debug:
	docker start $(DB)
	go run ./cmd/web -debug

stop:
	docker stop $(DB)

migrate-up:
	migrate -path=./migrations -database=$(DSN) up

migrate-force:
	migrate -path=./migrations -database=$(DSN) force 3


test:
	for i in {1..20}; do curl http://localhost:4000/v1/healthcheck; done