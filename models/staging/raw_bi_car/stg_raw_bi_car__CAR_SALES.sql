with 

source as (

    select * from {{ source('raw_bi_car', 'CAR_SALES') }}

),

renamed as (

    select
        ddate,
        salesperson,
        customername,
        carmake,
        carmodel,
        caryear,
        saleprice,
        commissionrate,
        commissionearned

    from source

)

select * from renamed