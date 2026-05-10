from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(
    title="demand-forecast-service",
    description="TFT demand forecasting on residualized demand",
    version="0.1.0"
)

Instrumentator().instrument(app).expose(app)

@app.get("/health")
def health():
    return {"status": "ok", "service": "demand-forecast-service"}