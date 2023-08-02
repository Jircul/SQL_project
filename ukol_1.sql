/* Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? */

CREATE VIEW v_narust_prumerne_mzdy AS (
SELECT 
	t1.nazev_odvetvi,
	t1.rok_mezd,
	t2.rok_mezd AS rok_mezd_minuly,
	round(t1.prumerna_mzda - t2.prumerna_mzda, 2) AS narust_prumerne_mzdy
FROM t_jiri_culka_project_sql_primary_final t1
JOIN t_jiri_culka_project_sql_primary_final t2
	ON t1.nazev_odvetvi = t2.nazev_odvetvi
	AND t1.rok_mezd = t2.rok_mezd + 1
	AND t1.rok_mezd <2021
)

SELECT *
FROM v_narust_prumerne_mzdy 	
WHERE narust_prumerne_mzdy < 1 
GROUP BY nazev_odvetvi, rok_mezd
