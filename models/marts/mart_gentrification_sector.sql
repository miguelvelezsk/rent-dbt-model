WITH rentals AS (
    SELECT * FROM {{ ref('stg_rentals') }}
)

SELECT
    barrio,
    COUNT(*) AS total_ofertas,
    ROUND(AVG(precio_mensual), 2) AS precio_promedio_sector,
    ROUND(AVG(area_m2), 2) AS area_promedio_sector,
    ROUND(AVG(precio_por_m2), 2) AS costo_m2_promedio,
    ROUND(AVG(precio_esperado_inflacion), 2) AS costo_m2_esperado_inflacion,
    ROUND(AVG(brecha_inflacion_pct), 2) AS porcentaje_sobrecosto_mercado,
    ROUND(AVG(brecha_inflacion_renta_pct), 2) AS porcentaje_sobrecosto_renta_mensual,
    ROUND(AVG(precio_esperado_renta_mensual), 2) AS costo_renta_mensual_esperado_inflacion
FROM rentals
GROUP BY barrio
HAVING total_ofertas >= 3  
ORDER BY costo_m2_promedio DESC