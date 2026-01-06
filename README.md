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

## Network Configuration

**Caddy Service:**
- ✅ Enable **Public Networking**
- Port:  `80`

**All Other Services:**
- ❌ Disable **Public Networking** (keep them private)
- Use Railway's private networking

## Service Configuration

### Required Services

| Service | Image | Private | Config |
|---------|-------|---------|--------|
| Caddy | This repo | **Public** | Reverse proxy |
| Frontend | `hardcoreeng/front` | Private | Web UI |
| Account | `hardcoreeng/account` | Private | Authentication |
| Transactor | `hardcoreeng/transactor` | Private | Backend logic |
| Collaborator | `hardcoreeng/collaborator` | Private | Real-time collab |
| Rekoni | `hardcoreeng/rekoni-service` | Private | AI/ML |
| Stats | `hardcoreeng/stats` | Private | Analytics |
| MinIO | `minio/minio` | Private | File storage |
| CockroachDB | `cockroachdb/cockroach` | Private | Database |
| Elasticsearch | `elasticsearch:7.14.2` | Private | Search |
| Redpanda | `redpandadata/redpanda` | Private | Messaging |

### Environment Variables for Other Services

#### Frontend Service
```env
ACCOUNTS_URL=https://your-caddy-domain.railway.app/_accounts
ACCOUNTS_URL_INTERNAL=http://${{account.RAILWAY_PRIVATE_DOMAIN}}: 3000
REKONI_URL=https://your-caddy-domain.railway.app/_rekoni
STATS_URL=https://your-caddy-domain.railway.app/_stats
COLLABORATOR_URL=wss://your-caddy-domain.railway.app/_collaborator
UPLOAD_URL=/files
SERVER_PORT=8080
SERVER_SECRET=<your-secret>
ELASTIC_URL=http://${{elastic.RAILWAY_PRIVATE_DOMAIN}}:9200
STORAGE_CONFIG=minio|${{minio.RAILWAY_PRIVATE_DOMAIN}}? accessKey=minioadmin&secretKey=minioadmin
```

#### Account Service
```env
ACCOUNTS_URL=https://your-caddy-domain.railway.app/_accounts
FRONT_URL=https://your-caddy-domain.railway.app
STATS_URL=http://${{stats.RAILWAY_PRIVATE_DOMAIN}}:4900
TRANSACTOR_URL=ws://${{transactor.RAILWAY_PRIVATE_DOMAIN}}:3333
SERVER_PORT=3000
SERVER_SECRET=<your-secret>
DB_URL=<cockroachdb-connection-string>
STORAGE_CONFIG=minio|${{minio.RAILWAY_PRIVATE_DOMAIN}}?accessKey=minioadmin&secretKey=minioadmin
MODEL_ENABLED=*
ACCOUNT_PORT=3000
```

#### Transactor Service
```env
ACCOUNTS_URL=http://${{account.RAILWAY_PRIVATE_DOMAIN}}:3000
FULLTEXT_URL=http://${{fulltext.RAILWAY_PRIVATE_DOMAIN}}:4700
STATS_URL=http://${{stats.RAILWAY_PRIVATE_DOMAIN}}:4900
SERVER_PORT=3333
SERVER_SECRET=<your-secret>
DB_URL=<cockroachdb-connection-string>
STORAGE_CONFIG=minio|${{minio.RAILWAY_PRIVATE_DOMAIN}}?accessKey=minioadmin&secretKey=minioadmin
```

## Optional Services

To enable optional services, uncomment the relevant sections in `Caddyfile`:

- **Print Service** - Document printing
- **Love Service** - Audio/Video calls (requires LiveKit)
- **Export Service** - Data export
- **Calendar Service** - Calendar integration
- **Gmail Service** - Gmail integration
