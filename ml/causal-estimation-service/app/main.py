from fastapi import FastAPI
from  prometheus_fastapi_instrumentator import Instrumentator


app = FastAPI(
    title="Causal Estimation Service",
    description="Causal price elasticity estimation via Double ML + IV",
    version="0.1.0",
)

Instrumentator().instrument(app).expose(app)

@app.get("/health")
def health():
    return {"status": "ok", "version": app.version, "service": "causal-estimation-service"}