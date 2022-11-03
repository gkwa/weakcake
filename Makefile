kinetic:
	docker compose run --rm cnspec_kinetic

xenial:
	docker compose run --rm cnspec_xenial

build:
	docker compose build

down:
	docker compose down --remove-orphans
