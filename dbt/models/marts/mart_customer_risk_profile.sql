with customer_stats as (
    select
        cityHash64(tuple(name_1, name_2, street, post_code)) as customer_id,
        count() as transaction_count,
        countIf(target = 1) as fraud_count,
        sum(amount) as total_amount,
        avg(amount) as average_amount,
        min(transaction_time) as first_transaction_time,
        max(transaction_time) as last_transaction_time
    from {{ ref('stg_transactions') }}
    group by name_1, name_2, street, post_code
)

select
    customer_id,
    transaction_count,
    fraud_count,
    round(100.0 * fraud_count / transaction_count, 2) as fraud_rate,
    total_amount,
    average_amount,
    first_transaction_time,
    last_transaction_time,
    case
        when fraud_count = 0 then 'LOW'
        when 10 * fraud_count >= transaction_count then 'HIGH'
        else 'MEDIUM'
    end as risk_level
from customer_stats
