select
    us_state,
    count() as transaction_count,
    countIf(target = 1) as fraud_count,
    round(100.0 * countIf(target = 1) / count(), 2) as fraud_rate,
    uniqExact(tuple(name_1, name_2, street, post_code)) as customer_count,
    uniqExact(merch) as merchant_count,
    sum(amount) as total_amount,
    sumIf(amount, target = 1) as fraud_amount
from {{ ref('stg_transactions') }}
group by us_state
