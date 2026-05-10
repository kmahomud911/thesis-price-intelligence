from fastapi import FastAPI
from prometheus_client import make_asgi_app

app = FastAPI(
    title="feature-pipeline",
    description="Shared feature computation pipeline",
    version="0.1.0"
)

# Mount Prometheus metrics
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)

@app.get("/health")
def health():
    return {"status": "ok", "service": "feature-pipeline"}