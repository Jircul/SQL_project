/* Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? */

SELECT
	rok_mezd,
	round (Avg(prumerna_mzda), 2) AS prumerna_mzda,
	nazev_produktu,
	round (avg(prumerna_cena), 2) AS prumerna_cena,
	round (Avg(prumerna_mzda) / avg(prumerna_cena), 2) AS vysledek
FROM t_jiri_culka_project_sql_primary_final 
WHERE rok_mezd IN (2006, 2018)
	AND nazev_produktu IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
GROUP BY rok_mezd, nazev_produktu
