/* Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? */

SELECT
    a.rok_mezd,
	b.rok_mezd AS minuly_rok_mezd,
	round((a.prumer_mezd - b.prumer_mezd) / a.prumer_mezd * 100, 2) AS narust_mezd_perc,
	round((a.prumer_cen - b.prumer_cen) / b.prumer_mezd * 100, 2) AS narust_cen_perc 
FROM (
		SELECT
			nazev_produktu,
			rok_mezd,
			round(avg(prumerna_mzda), 2) AS prumer_mezd,
			round(avg(prumerna_cena), 2) AS prumer_cen
		FROM t_jiri_culka_project_sql_primary_final 
		WHERE rok_mezd BETWEEN 2006 AND 2018
		GROUP BY rok_mezd
		) AS a 
JOIN (
		SELECT
			nazev_produktu,
			rok_mezd,
			round(avg(prumerna_mzda), 2) AS prumer_mezd,
			round(avg(prumerna_cena), 2) AS prumer_cen
		FROM t_jiri_culka_project_sql_primary_final 
		WHERE rok_mezd BETWEEN 2006 AND 2018
		GROUP BY rok_mezd
		) AS b 
	ON a.nazev_produktu = b.nazev_produktu
	AND a.rok_mezd = b.rok_mezd + 1 
	AND a.rok_mezd < 2019
