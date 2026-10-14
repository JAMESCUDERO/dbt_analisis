# dbt – Pipeline analítico de ventas de vehículos

Proyecto de formación en **dbt** sobre **Snowflake**: transforma una tabla transaccional de ventas
en un modelo estrella listo para consumo en BI, siguiendo la convención de capas
**staging → processing → mart**.

> Proyecto de aprendizaje con datos de ejemplo (`DATBUSTER_SAMPLE`). No es un desarrollo de producción.

## Arquitectura

```text
Snowflake: DATBUSTER_SAMPLE.PUBLIC.CAR_SALES   (source)
        │
        ▼
staging     stg_raw_bi_car__CAR_SALES     renombrado 1:1 de la fuente
            stg_sales_data_2020p          tipado (TRY_CAST) y filtro de ventas desde 2020
        │
        ▼
processing  psg_montly_sales_make         agregado mensual por vendedor y marca
        │
        ▼
mart        dim_carmake · dim_salesperson   dimensiones con clave subrogada
            fct_montly_sales                hechos mensuales: venta neta y comisión
```

| Capa | Materialización | Tag |
|---|---|---|
| staging | table | `staging` |
| processing | table | `processing` |
| mart | view | `mart`, `dash_sales_bi` |

## Qué practica este proyecto

- **Sources documentadas** (`models/source/source.yml`) con descripción por columna.
- **Pruebas de calidad** en `schema.yml`: `unique`, `not_null` y `accepted_values` (esta última con severidad `warn`).
- **Macro propia** `generate_id` para generar claves subrogadas con `RANK() OVER (...)`.
- **Jinja** en `analyses/for_loop_pivot.sql`: pivoteo de ventas por marca generado con un bucle.
- **Tags y configuración por carpeta** en `dbt_project.yml` para ejecutar capas por separado.

## Cómo ejecutarlo

Requiere un perfil `default` en `~/.dbt/profiles.yml` apuntando a Snowflake.

```bash
dbt run                       # construye todos los modelos
dbt test                      # ejecuta las pruebas de calidad
dbt run --select tag:mart     # solo la capa mart
dbt docs generate && dbt docs serve
```

## Stack

dbt Core · Snowflake · SQL · Jinja
