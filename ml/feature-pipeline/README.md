# feature-pipeline

## What it does
Computes and serves all features used across the causal estimation and demand forecasting pipelines. Single source of truth — every feature is defined once in `features.py` and consumed by both `causal-estimation-service` and `demand-forecast-service`. Eliminates training/serving skew.

## Pipeline Role
- Reads raw price, order, and competitor data from TimescaleDB
- Computes features defined in `features.py`
- Validates feature quality via Great Expectations
- Writes to TimescaleDB (offline feature store)
- Writes to Redis (online feature cache for low-latency serving)
- Publishes feature vectors to Kafka for downstream consumption

## This is NOT a web service
No HTTP server. Runs as a scheduled batch pipeline or triggered via Kafka event.

## Kafka
- Consumes: `price-events` (trigger)
- Produces: `data-quality-alerts` (on GE validation failure)

## Key dependencies
- pandas + numpy (feature computation)
- great-expectations (data quality validation — alerts if PSI > 0.2)
- redis (online feature cache)
- sqlalchemy + psycopg2 (TimescaleDB read/write)

## Feature categories
- Price features: log_price, price_delta, price_ratio_to_competitor
- Demand features: rolling_demand_7d, rolling_demand_14d, demand_residual
- IV features: freight_value, lagged_competitor_price_7d, lagged_competitor_price_14d, active_seller_count, competitor_stock_availability
- Temporal features: day_of_week, month, is_holiday, is_promotion

## How to run
```bash
poetry run python app/pipeline.py
```

## Data Quality
Great Expectations runs on every batch. Results published to `data-quality-alerts` Kafka topic. Alert threshold: PSI > 0.2 per feature triggers drift alert.