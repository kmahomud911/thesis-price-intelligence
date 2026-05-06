# causal-estimation-service

## What it does
Estimates causal price elasticity (theta_hat) via Double ML + Instrumental Variables from observational e-commerce data.

## Kafka
- Consumes: ``price-events``
- Produces: ``causal-estimates``

## Key dependencies
- econml (Double ML, IV estimation)
- statsmodels (F-stat, Sargan-Hansen J-test)
- mlflow (experiment tracking)

## How to run
``````bash
poetry run uvicorn app.main:app --reload --port 8082
``````