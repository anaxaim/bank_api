# Database
### Tables: accounts, entries, transfers

### Migration - [golang-migrate](https://github.com/golang-migrate/migrate)
* command: **migrate create -ext sql -dir db/migration -seq name**

### DB Diagram - [dbdiagram](https://dbdiagram.io/d/639de3d599cb1f3b55a201a5)

### Generate CRUD Code from SQL - [sqlc](https://sqlc.dev)
* sqlc init
* [config file](https://docs.sqlc.dev/en/stable/reference/config.html)
* sqlc generate

### Postgres driver - [lib/pq](https://github.com/lib/pq)

# Config parser
### [viper](github.com/spf13/viper)

# Tests
### [testify](https://github.com/stretchr/testify)

# Mocks
* [golang-mock](github.com/golang/mock)
* mocgen CLI install *go install github.com/golang/mock/mockgen@v1.6.0*
* generate mocks: mockgen -package name -destination path  files InterfaceName

# CI
### config for github-actions in .github/workflows