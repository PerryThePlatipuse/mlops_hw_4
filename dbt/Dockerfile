FROM python:3.11-slim

ARG PIP_INDEX_URL=https://pypi.org/simple
RUN pip install --no-cache-dir dbt-core==1.10.23 dbt-clickhouse==1.10.3 sqlfluff==4.5.0 sqlfluff-templater-dbt==4.5.0 pre-commit==4.7.0
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /work
ENTRYPOINT ["dbt"]
