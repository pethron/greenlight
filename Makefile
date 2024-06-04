DB=greenlightdb

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
