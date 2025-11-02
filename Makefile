.PHONY: help up down restart logs logs-wireguard logs-mosquitto status pull update clean

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

up: ## Start all services
	docker compose up -d

down: ## Stop all services
	docker compose down

restart: ## Restart all services
	docker compose restart

logs: ## Show logs for all services
	docker compose logs -f

logs-wireguard: ## Show logs for WireGuard service
	docker compose logs -f wireguard

logs-mosquitto: ## Show logs for Mosquitto service
	docker compose logs -f mosquitto

status: ## Show status of all services
	docker compose ps

pull: ## Pull latest images
	docker compose pull

update: pull up ## Update images and restart services

clean: ## Stop services and remove volumes
	docker compose down -v

wireguard-config: ## Show WireGuard peer1 configuration
	docker compose exec wireguard cat /config/peer1/peer1.conf

wireguard-qr: ## Show QR code for WireGuard peer1
	docker compose exec wireguard /app/show-peer 1

mosquitto-test-sub: ## Subscribe to test topic (requires mosquitto-clients)
	mosquitto_sub -h localhost -t test/topic

mosquitto-test-pub: ## Publish test message (requires mosquitto-clients)
	mosquitto_pub -h localhost -t test/topic -m "Test message from Makefile"
