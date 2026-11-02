{{ config(materialized='view') }}

select
    transaction_time,
    toDate(transaction_time) as transaction_date,
    toStartOfMonth(transaction_time) as transaction_month,
    {{ dbt_date.day_of_week('transaction_time') }} as day_of_week,
    merch,
    trimBoth(cat_id) as cat_id,
    amount,
    {{ amount_bucket('amount') }} as amount_bucket,
    name_1,
    name_2,
    gender,
    street,
    one_city,
    upper(trimBoth(us_state)) as us_state,
    post_code,
    lat,
    lon,
    population_city,
    jobs,
    merchant_lat,
    merchant_lon,
    target
from {{ source('transactions_db', 'transactions') }}
