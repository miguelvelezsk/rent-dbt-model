WITH rentals AS (
    SELECT * FROM {{ ref('stg_rentals') }}
)

SELECT
    barrio,
    COUNT(*) AS total_ofertas,
    ROUND(AVG(precio_mensual), 2) AS precio_promedio_sector,
    ROUND(AVG(area_m2), 2) AS area_promedio_sector,
    ROUND(AVG(precio_por_m2), 2) AS costo_m2_promedio
FROM rentals
GROUP BY barrio
HAVING total_ofertas >= 3  
ORDER BY costo_m2_promedio DESC