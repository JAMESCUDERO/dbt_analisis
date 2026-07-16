{{ config(tags=['dash_sales_bi'])}}

select 
     DDATE 
    ,ID_SALESPERSON
    ,ID_CARMAKE
    ,TOTALSALE
    ,TOTALCOM
from {{ref("psg_montly_sales_make")}} as psgm

left join {{ref("dim_carmake")}} as dimcm
on psgm.CARMAKE = dimcm.CARMAKE

left join {{ref("dim_salesperson")}} as dimsp
on psgm.SALESPERSON = dimsp.SALESPERSON
