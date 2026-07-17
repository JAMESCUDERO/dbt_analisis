{{
    config(
        materialized='table',
        tags=['Processing','sales','carmake']
    )
}}

select 
    date_trunc('MONTH',DDATE) as DDATE 
    ,SALESPERSON
    ,CARMAKE
    ,SUM(SALEPRICE - COMNEA) AS TOTALSALE
    ,SUM(COMNEA) AS TOTALCOM
from {{ref("stg_sales_data_2020p")}}
GROUP BY date_trunc('MONTH',DDATE) 
    ,SALESPERSON
    ,CARMAKE