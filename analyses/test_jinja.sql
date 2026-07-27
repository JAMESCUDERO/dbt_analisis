
select
 *
from {{ ref("stg_sales_data_2020p") }}

{% if target.name != 'prod_databoosters'%} 
limit 10 
{% endif %}
