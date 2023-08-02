/* Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? */

SELECT 
	t1.nazev_produktu,
	t1.rok_mezd,
	t2.rok_mezd AS rok_mezd_minuly,
	round((t1.prumerna_cena - t2.prumerna_cena) / t2.prumerna_cena * 100, 2) AS mezirocni_narust
FROM t_jiri_culka_project_sql_primary_final t1
JOIN t_jiri_culka_project_sql_primary_final t2
	ON t1.nazev_produktu = t2.nazev_produktu
	AND t1.rok_mezd = t2.rok_mezd + 1
	AND t1.rok_mezd < 2018
GROUP BY t1.rok_mezd, nazev_produktu
