{{config(tags= ['sales','dash_sales_bi'])}}

select 
rank() over (order by SALESPERSON) AS ID_SALESPERSON
,SALESPERSON
FROM {{ref("psg_montly_sales_make")}}
group by SALESPERSON 