k:
	docker compose run --rm cnspec_kinetic

k2:
	docker compose run --rm cnspec_kinetic2

xenial:
	docker compose run --rm cnspec_xenial

build:
	docker compose build

down:
	docker compose down --remove-orphans
