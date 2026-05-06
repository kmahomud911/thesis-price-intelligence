# demand-forecast-service

## What it does
Forecasts residualized demand using a Temporal Fusion Transformer (TFT). Operates on demand signal with causal price effect removed (D_residual = D_observed - theta_hat * log(price)), isolating pure demand patterns from price endogeneity.

## Pipeline Role
- Receives residualized demand from the causal estimation pipeline
- Forecasts D_residual over a prediction horizon
- Combined with theta_hat at the Pricing Optimizer to reconstruct price-conditional demand:
  `D_forecast(p_new) = D_residual_forecast + theta_hat * log(p_new / p_baseline)`

## Kafka
- Consumes: `forecast-results` (trigger + feature payload)
- Produces: `forecast-results`

## Key dependencies
- pytorch-forecasting (TFT implementation)
- torch + lightning (training backend)
- mlflow (experiment tracking — logs SMAPE, MASE, WAPE per fold)

## Ports
- Service: `8083`

## How to run
```bash
poetry run uvicorn app.main:app --reload --port 8083
```

## Experiments
- E1a: TFT only (ablation baseline)
- E3: Temporal robustness — 3 train/test splits
- E4: Noise injection — price perturbation, missing data, corrupt features