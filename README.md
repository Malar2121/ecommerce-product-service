# Product Service

Product microservice for the SWST41062 e-commerce platform. Manages product catalog data, exposes a REST API, persists to PostgreSQL, and publishes domain events via RabbitMQ.

## Tech Stack

| Technology | Version |
|------------|---------|
| Java | 21 |
| Spring Boot | 3.5.3 |
| Maven | 3.9+ |
| PostgreSQL | 16 |
| RabbitMQ | 3 (management) |
| Swagger / OpenAPI | springdoc-openapi 2.8.8 |
| JUnit | 5 (via spring-boot-starter-test) |
| Docker | Docker Desktop |

## Prerequisites

- Java 21 (Eclipse Temurin recommended)
- Maven 3.9+ (or use included `./mvnw`)
- Docker Desktop
- Git

## Quick Start

### 1. Clone and configure environment

```bash
git clone <repository-url>
cd ecommerce-product-service
cp .env.example .env
```

Edit `.env` if you need non-default credentials or ports.

### 2. Start infrastructure (PostgreSQL + RabbitMQ)

```bash
docker compose up -d
```

Verify containers are healthy:

```bash
docker compose ps
```

### 3. Run the application

```bash
./mvnw spring-boot:run
```

On Windows:

```powershell
.\mvnw.cmd spring-boot:run
```

The service starts on **http://localhost:8081** (default).

### 4. Verify endpoints

| Endpoint | URL |
|----------|-----|
| Health check | http://localhost:8081/actuator/health |
| Swagger UI | http://localhost:8081/swagger-ui.html |
| OpenAPI JSON | http://localhost:8081/v3/api-docs |
| RabbitMQ Management | http://localhost:15672 (guest/guest) |

### 5. Run tests

```bash
./mvnw test
```

Tests use the `test` profile and do not require Docker infrastructure.

## Project Structure

```
src/main/java/com/swst41062/ecommerce/product/
├── ProductServiceApplication.java   # Application entry point
├── config/                          # Spring configuration beans
├── controller/                      # REST controllers
├── dto/
│   ├── request/                     # Incoming request DTOs
│   └── response/                    # Outgoing response DTOs
├── entity/                          # JPA entities
├── enums/                           # Domain enumerations
├── event/                           # RabbitMQ event payloads
├── exception/                       # Custom exceptions + global handler
├── mapper/                          # Entity ↔ DTO mappers
├── messaging/                       # RabbitMQ publishers/listeners
├── repository/                      # Spring Data JPA repositories
└── service/
    └── impl/                        # Service implementations
```

## Configuration

Configuration is externalized via environment variables. See [`.env.example`](.env.example) for all supported variables.

| Profile | File | Purpose |
|---------|------|---------|
| default | `application.yml` | Base config with env var placeholders |
| dev | `application-dev.yml` | Verbose logging, Swagger enabled |
| test | `application-test.yml` | Disables DB/RabbitMQ for unit tests |

Activate a profile:

```bash
export SPRING_PROFILES_ACTIVE=dev   # Linux/macOS
$env:SPRING_PROFILES_ACTIVE="dev"   # PowerShell
```

## Docker

### Infrastructure only (development)

```bash
docker compose up -d
```

### Build and run the application container

```bash
docker build -t product-service .
docker run -p 8081:8081 --env-file .env --network ecommerce-product-service_ecommerce-network product-service
```

> When running in Docker, set `DB_HOST=product-db` and `RABBITMQ_HOST=product-rabbitmq` to use Docker service names.

## Regenerate from Spring Initializr

See [`spring-initializr.config`](spring-initializr.config) for the full Initializr configuration and download URL.

## License

University assignment — SWST41062 Group Project.
