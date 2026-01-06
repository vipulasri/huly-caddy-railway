# Huly Caddy Proxy for Railway

A Caddy-based reverse proxy configuration for deploying [Huly](https://github.com/hcengineering/huly-selfhost) on Railway with proper security (only frontend publicly exposed).

## Configure Huly Environment Variables

In your **Caddy service** on Railway, set these environment variables:

```env
FRONT_HOST=${{front.RAILWAY_PRIVATE_DOMAIN}}
ACCOUNT_HOST=${{account.RAILWAY_PRIVATE_DOMAIN}}
TRANSACTOR_HOST=${{transactor.RAILWAY_PRIVATE_DOMAIN}}
COLLABORATOR_HOST=${{collaborator.RAILWAY_PRIVATE_DOMAIN}}
REKONI_HOST=${{rekoni.RAILWAY_PRIVATE_DOMAIN}}
STATS_HOST=${{stats.RAILWAY_PRIVATE_DOMAIN}}
MINIO_HOST=${{minio. RAILWAY_PRIVATE_DOMAIN}}
```