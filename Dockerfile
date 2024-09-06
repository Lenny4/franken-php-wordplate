# https://github.com/StephenMiracle/frankenwp/blob/main/Dockerfile
# https://hub.docker.com/r/wpeverywhere/frankenwp/tags

FROM wpeverywhere/frankenwp:latest-php8.2 AS app_php

WORKDIR /var/www/html/

COPY --link ./public ./
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --link ./docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
COPY --link ./docker/Caddyfile /etc/caddy/Caddyfile
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
