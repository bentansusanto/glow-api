.PHONY: sqlc new-sqlc global-sqlc sqlc-generate migrate-up migrate-down migrate-status migrate-reset migration-create dev build test clean help

# Environment variables

# Load environment variables if .env exists
ifneq (,$(wildcard ./.env.development))
    include .env.development
    export
endif

export POSTGRESQL_URL=postgresql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}

# global generate sqlc
global-sqlc:
	@echo "🔧 Checking SQLC configuration..."
	@if [ ! -f sqlc.yaml ]; then \
		echo "❌ sqlc.yaml not found!"; \
		exit 1; \
	fi
	@if [ ! -d app/queries ]; then \
		echo "📁 Creating missing directory: app/queries"; \
		mkdir -p app/queries; \
	fi
	@if [ ! -d infra/databases/migrations ]; then \
		echo "📁 Creating missing directory: infra/databases/migrations"; \
		mkdir -p infra/databases/migrations; \
	fi
	@echo "🚀 Running sqlc generate..."
	@sqlc generate || (echo "❌ SQLC generation failed" && exit 1)
	@echo "✅ SQLC generation completed successfully"

new-sqlc:
	@if [ -z "$(name)" ]; then \
		echo "❌ Error: gunakan: make new-sqlc name=nama_module"; \
		exit 1; \
	fi; \
	MODULE_DIR=app/queries/$(name); \
	if [ -d $$MODULE_DIR ]; then \
		echo "❌ Module folder $$MODULE_DIR sudah ada!"; \
		exit 1; \
	fi; \
	echo "📁 Creating module folder: $$MODULE_DIR"; \
	mkdir -p $$MODULE_DIR; \
	FILE=$$MODULE_DIR/$(name).sql; \
	echo "📄 Writing default SQL file: $$FILE"; \
	echo "-- name: $(name) :exec" > $$FILE; \
	echo "-- Write your SQL queries below" >> $$FILE; \
	echo ""; \
	echo "✔️  Module created: $$MODULE_DIR"; \
	echo "👉 Tambahkan module ini ke sqlc.yaml, lalu jalankan: make sqlc"

print-db:
	@echo "DB_USER=$(DB_USER)"
	@echo "DB_HOST=$(DB_HOST)"
	@echo "DB_PORT=$(DB_PORT)"
	@echo "DB_NAME=$(DB_NAME)"
	@echo "DB_PASS=$(DB_PASS)"

# Database migration commands
migrate-up:
	@echo "🔄 Running migrations with Goose..."
	@goose -dir infra/databases/migrations postgres "${POSTGRESQL_URL}" up
	@echo "✅ Migrations completed successfully"

migrate-down:
	@echo "⚠️  Rolling back the most recent migration..."
	@goose -dir infra/databases/migrations postgres "${POSTGRESQL_URL}" down
	@echo "✅ Rollback completed"

# Create new migration file
migration-create:
	@if [ -z "$$name" ]; then \
		read -p "📝 Enter migration name: " name; \
	else \
		name="$$name"; \
	fi; \
	DIR="infra/databases/migrations"; \
	\
	LAST=$$(ls $$DIR/*.sql 2>/dev/null | sed 's/.*\/\([0-9]*\)_.*/\1/' | sort -n | tail -n1); \
	if [ -z "$$LAST" ]; then \
		NEXT=1; \
	else \
		NEXT=$$((10#$$LAST + 1)); \
	fi; \
	\
	NUM=$$(printf "%07d" $$NEXT); \
	\
	FILE="$$DIR/$${NUM}_$${name}_table.up.sql"; \
	\
	echo "-- +goose Up" > "$$FILE"; \
	echo "-- Add your SQL here" >> "$$FILE"; \
	echo "" >> "$$FILE"; \
	echo "-- +goose Down" >> "$$FILE"; \
	echo "-- Add your rollback SQL here" >> "$$FILE"; \
	echo "" >> "$$FILE"; \
	\
	echo "✅ Created:"; \
	echo "   - $$FILE";


# Check migration status
migrate-status:
	@echo "📊 Current migration status:"
	@goose -dir infra/databases/migrations postgres "${POSTGRESQL_URL}" status

# Reset database (drop all tables and re-run migrations)
migrate-reset:
	@echo "⚠️  WARNING: This will drop all tables in the database!"
	@read -p "Are you sure you want to continue? [y/N] " confirm; \
	if [ "$$confirm" != "y" ] && [ "$$confirm" != "Y" ]; then \
		echo "Migration reset cancelled"; \
		exit 0; \
	fi
	@echo "🔄 Resetting database..."
	@goose -dir infra/databases/migrations postgres "${POSTGRESQL_URL}" reset
	@echo "✅ Database reset completed"

# Development commands
dev:
	@echo "🚀 Starting development server..."
	docker compose up

dev-v:
	@echo "🚀 Starting development server..."
	docker compose up --build

dev-down:
	@echo "🛑 Stopping development environment..."
	docker compose down

dev-down-v:
	@echo "🛑 Stopping development environment..."
	docker compose down -v

# Build the application
build:
	@echo "🔨 Building application..."
	@go build -o medisuite .

# Run tests
test:
	@echo "🧪 Running tests..."
	@go test -v ./...

# Clean build artifacts
clean:
	@echo "🧹 Cleaning up..."
	@rm -f medisuite
	@rm -rf tmp/

# Help command (default target)
help:
	@echo "\n📋 Available commands:"
	@echo "  make migrate-up         - Run pending migrations"
	@echo "  make migrate-down       - Rollback the most recent migration"
	@echo "  make migrate-reset      - Reset database (drop all tables and re-run migrations)"
	@echo "  make migrate-status     - Show current migration version"
	@echo "  make migration-create   - Create new migration file"
	@echo "  make new-sqlc           - Create new sqlc file"
	@echo "  make global-sqlc        - Generate SQL code for all modules"
	@echo "  make dev                - Start development server"
	@echo "  make dev-v              - Start development server with build"
	@echo "  make dev-down           - Stop development environment"
	@echo "  make dev-down-v         - Stop development environment with volume"
	@echo "  make build              - Build application"
	@echo "  make test               - Run tests"
	@echo "  make clean              - Clean build artifacts"
	@echo "  make new-sqlc           - Create a new SQLC module"
	@echo "  make print-db           - Print database connection info"
	@echo "  make help               - Show this help message"

# Set default target
.DEFAULT_GOAL := help
