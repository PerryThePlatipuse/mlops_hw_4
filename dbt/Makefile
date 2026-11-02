.PHONY: lint test hooks

lint:
	cd .. && docker-compose --profile dbt run --rm --entrypoint sqlfluff dbt lint models tests

test:
	cd .. && docker-compose --profile dbt run --rm dbt test --select package:fraud_analytics

hooks:
	cd .. && docker-compose --profile dbt run --rm --workdir /repo --entrypoint pre-commit dbt run --config dbt/.pre-commit-config.yaml --files dbt/models/staging/*.sql dbt/models/marts/*.sql dbt/tests/*.sql
