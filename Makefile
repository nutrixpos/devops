.PHONY: pre-up
pre-up:
	@echo "Running pre-up script..."
	@if [ -f .env ]; then \
		GIT_COMMIT=$$(git rev-parse --short HEAD || echo "unknown"); \
		sed -i.bak "s/VITE_APP_APP_VERSION=.*/VITE_APP_APP_VERSION=$$GIT_COMMIT/" .env; \
		rm -f .env.bak; \
		echo "Updated VITE_APP_APP_VERSION to $$GIT_COMMIT in .env"; \
	else \
		echo "Warning: .env file not found"; \
	fi

up: pre-up
	docker compose up -d
down: 
	docker compose down

update: down
		git pull
		make pre-up
		docker compose up --build --force-recreate --no-deps -d