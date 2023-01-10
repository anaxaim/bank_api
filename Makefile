DB_URL=postgresql://root:secret@localhost:5432/bank?sslmode=disable

postgres:
	docker run --name postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:13.9-alpine3.17

createdb:
	docker exec -it postgres createdb --username=root --owner=root bank

dropdb:
	docker exec -it postgres dropdb bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/anaxaim/bank_api/db/sqlc Store

build:
	docker build -t bank:latest .

up:
	docker compose up

network:
	docker network create bank-network

run:
	docker run --name bank --network bank-network -p 8881:8881 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:secret@postgres:5432/bank?sslmode=disable" bank:latest  

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test mock