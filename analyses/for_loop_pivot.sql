{% set target_makes = ['Toyota', 'Ford','Chevrolet','Honda','Nissan'] %}

select DDATE,
SALESPERSON,
{% for make in target_makes %}
sum(case when CARMAKE = '{{ make }}' then TOTALSALE else 0 end) as sales_{{ make }} {% if not loop.last %},{% endif %}
{% endfor %}
FROM {{ ref("psg_montly_sales_make") }}
group by DDATE, SALESPERSON