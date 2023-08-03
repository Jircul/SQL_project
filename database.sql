/* primární tabulku jsem vytvořil z dvou views */

-- první view
	
CREATE VIEW v_price_zaklad AS (
	SELECT 
		cpc.name,
		cp.value,
		cpc.price_value,
		cpc.price_unit, 
		cp.date_from,
		cp.date_to 
	FROM czechia_price cp 
	JOIN czechia_price_category cpc 
		ON cp.category_code = cpc.code
	WHERE cp.region_code = 'CZ010'
)

-- druhy view

CREATE VIEW v_payroll AS (
	SELECT 
		cpib.name,
		cp.industry_branch_code,
		cp.value,
		cp.payroll_year 
	FROM czechia_payroll cp 
	JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code = cpib.code 
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND payroll_quarter = 1
)			

-- vytvoření primární tabulky

CREATE OR REPLACE TABLE t_jiri_culka_project_SQL_primary_final AS (
SELECT 
	vp.name AS nazev_odvetvi,
	vp.industry_branch_code AS kod_odvetvi,
	vp.value AS prumerna_mzda,
	vp.payroll_year AS rok_mezd,
	vpz.name AS nazev_produktu,
	vpz.value AS prumerna_cena,
	vpz.price_value AS pocet_jednotek,
	vpz.price_unit AS merna_jednotka,
	vpz.date_from AS mereno_od,
	vpz.date_to AS mereno_do
FROM v_payroll vp
JOIN v_price_zaklad vpz 
	ON vp.payroll_year = year(vpz.date_from)
GROUP BY year(vpz.date_from), vp.name, vpz.name
)
