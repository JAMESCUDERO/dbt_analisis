{{config(tags= ['sales','dash_sales_bi'])}}

select 
rank() over (order by CARMAKE) AS ID_CARMAKE
,CARMAKE
FROM {{ref("psg_montly_sales_make")}}
group by CARMAKE 
