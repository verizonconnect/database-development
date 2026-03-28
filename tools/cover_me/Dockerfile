FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY cover_me/ cover_me/
COPY tests/ tests/

ENTRYPOINT ["python", "-m", "cover_me.cli"]
