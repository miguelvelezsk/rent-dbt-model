WITH 

source AS (
    SELECT * FROM {{ source('rental_medellin', 'fincaraiz_raw_rentals') }}
)

SELECT
    LOWER(TRIM(location)) AS barrio,
    CAST(price AS INT64) AS precio_mensual,
    CAST(total_area_m2 AS INT64) AS area_m2,
    CAST(price_per_m2 AS FLOAT64) AS precio_por_m2,
    bathrooms AS banos,
    bedrooms AS habitaciones
FROM source