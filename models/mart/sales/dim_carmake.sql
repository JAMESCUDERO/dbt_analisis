{{config(tags= ['sales','dash_sales_bi'])}}

select 
{{ generate_id('CARMAKE') }} AS ID_CARMAKE
,CARMAKE
FROM {{ref("psg_montly_sales_make")}}
group by CARMAKE 
