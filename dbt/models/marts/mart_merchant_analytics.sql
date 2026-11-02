select
    merch,
    count() as transaction_count,
    sum(amount) as turnover,
    countIf(target = 1) as fraud_count,
    round(100.0 * countIf(target = 1) / count(), 2) as fraud_rate,
    if(100.0 * countIf(target = 1) / count() >= 2, 1, 0) as suspicious_flag
from {{ ref('stg_transactions') }}
group by merch
