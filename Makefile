build:
	docker-compose build

up:
	docker-compose up -d

up-non-daemon:
	docker-compose up

start:
	docker-compose start

stop:
	docker-compose stop

restart:
	docker-compose stop && docker-compose start

shell-nginx:
	docker exec -ti nginx_c /bin/sh

shell-web:
	docker exec -ti web_c /bin/sh

shell-db:
	docker exec -ti postgres_c /bin/sh

log-nginx:
	docker-compose logs nginx  

log-web:
	docker-compose logs web  

log-db:
	docker-compose logs db

collectstatic:
	docker exec web_c /bin/sh -c "python manage.py collectstatic --noinput"  
