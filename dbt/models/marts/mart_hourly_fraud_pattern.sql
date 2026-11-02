select
    day_of_week,
    toHour(transaction_time) as transaction_hour,
    count() as transaction_count,
    countIf(target = 1) as fraud_count,
    round(100.0 * countIf(target = 1) / count(), 2) as fraud_rate
from {{ ref('stg_transactions') }}
group by day_of_week, transaction_hour
