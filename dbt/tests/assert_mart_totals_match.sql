with state_totals as (
    select sum(transaction_count) as transactions, sum(fraud_count) as frauds
    from {{ ref('mart_fraud_by_state') }}
),
category_totals as (
    select sum(transaction_count) as transactions, sum(fraud_count) as frauds
    from {{ ref('mart_fraud_by_category') }}
)

select state_totals.transactions, state_totals.frauds
from state_totals cross join category_totals
where state_totals.transactions != category_totals.transactions
    or state_totals.frauds != category_totals.frauds
