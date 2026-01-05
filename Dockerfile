FROM caddy:2-alpine

# Copy Caddyfile to the appropriate location
COPY Caddyfile /etc/caddy/Caddyfile

# Expose port 80 (Railway will handle HTTPS)
EXPOSE 80