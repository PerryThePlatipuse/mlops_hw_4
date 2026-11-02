# dbt домашка

ClickHouse → staging → 6 витрин. есть свой макрос amount_bucket, тесты и линтер

нужен train.csv в ../data/train.csv. команды запускать из hw3

~~~bash
docker-compose up -d clickhouse
docker-compose exec -T clickhouse sh -c 'clickhouse-client --user "$CLICKHOUSE_USER" --password "$CLICKHOUSE_PASSWORD" --multiquery' < dbt/setup_clickhouse.sql
docker-compose exec -T clickhouse sh -c 'clickhouse-client --user "$CLICKHOUSE_USER" --password "$CLICKHOUSE_PASSWORD" --date_time_input_format=best_effort --query "INSERT INTO transactions_db.transactions FORMAT CSVWithNames"' < ../data/train.csv
docker-compose exec -T clickhouse sh -c 'clickhouse-client --user "$CLICKHOUSE_USER" --password "$CLICKHOUSE_PASSWORD" --query "SELECT count(), countIf(target = 1) FROM transactions_db.transactions"'
docker-compose --profile dbt build dbt
docker-compose --profile dbt run --rm dbt deps
docker-compose --profile dbt run --rm dbt run --select package:fraud_analytics
make -C dbt test
make -C dbt lint
make -C dbt hooks
~~~

csv заливать один раз. должно быть 786431 строк и 4504 фрода. тестов 25

если pip не качает с обычного pypi, сборка с зеркалом

~~~bash
docker-compose --profile dbt build --build-arg PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple dbt
~~~

проверка dbt проекта, одна проверка пакета падает на ClickHouse 25.8 поэтому исключена

~~~bash
docker-compose --profile dbt run --rm dbt build --select package:dbt_project_evaluator --exclude 'fct_rejoining_of_upstream_concepts+'
~~~

доки

~~~bash
docker-compose --profile dbt run --rm dbt docs generate
docker-compose --profile dbt run --rm -p 127.0.0.1:8088:8080 dbt docs serve --host 0.0.0.0 --port 8080
~~~

открыть http://127.0.0.1:8088. скрины графа и тестов лежат в docs_lineage.png и all_test_passed.png

dbt-core 1.10.23, dbt-clickhouse 1.10.3
