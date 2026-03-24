--examine the imported data from churn table
SELECT * FROM customer_churn_raw

-- check customer_id for duplicates
-- results: no duplicates
SELECT 
	customer_id, 
	COUNT(*)
FROM customer_churn_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- check missing values for gender and knowing gender distribution	
-- results: no missing, even distibution
SELECT 
    COALESCE(gender, 'Total') AS gender,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE gender IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((gender), ())

-- checking age validity
-- results: age makes sense
SELECT 
	MIN(age) youngest, 
	MAX(age) oldest, 
	COUNT(*) FILTER(where age IS NUll) no_of_missing
FROM customer_churn_raw

-- check missing values for marital status and knowing distribution	
-- results: no missing, even distribution
SELECT 
    COALESCE(married, 'Total') AS married,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE married IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((married), ())

-- checking no_of_dependents validity
-- results: no_of_dependents makes sense
SELECT 
	MIN(no_of_dependents) least_dependents, 
	MAX(no_of_dependents) most_dependents, 
	COUNT(*) FILTER(WHERE no_of_dependents IS NUll) no_of_missing
FROM customer_churn_raw

-- checking missing city and zipcode and if it is valid
-- results: no missing, no abnormal amount of zipcodes
SELECT 
	COUNT(*) FILTER (WHERE city IS NULL) AS missing_city,
	COUNT(*) FILTER (WHERE zip_code IS NULL) AS missing_zip_code,
	COUNT(*) FILTER (WHERE latitude IS NULL) AS missing_latitude,
	COUNT(*) FILTER (WHERE longitude IS NULL) AS missing_longitude,
	COUNT(DISTINCT city) AS total_cities,
	COUNT(DISTINCT zip_code) AS total_zipdcode,
	COUNT(DISTINCT latitude) AS total_latitude,
	COUNT(DISTINCT longitude) AS total_longitude
FROM customer_churn_raw

SELECT
	MAX(num_zip_codes),
	MIN(num_zip_codes)
FROM (
	SELECT 
    	city,
    	COUNT(DISTINCT zip_code) AS num_zip_codes
	FROM customer_churn_raw
	GROUP BY city
	ORDER BY num_zip_codes, city
)

-- checking no_of_referrals validity
-- results: no_of_referrals makes sense
SELECT 
	MIN(no_of_referrals) least_referrals, 
	MAX(no_of_referrals) most_referrals, 
	COUNT(*) FILTER(where no_of_referrals IS NUll) no_of_missing
FROM customer_churn_raw

-- checking tenure_in_months validity
-- results: tenure_in_months makes sense
SELECT 
	MIN(tenure_in_months) least_tenure, 
	MAX(tenure_in_months) most_tenure, 
	COUNT(*) FILTER(where tenure_in_months IS NUll) no_of_missing
FROM customer_churn_raw

-- checking offer validity and distribution
-- results: no anomalies

SELECT 
    COALESCE(offer, 'Total') AS offer,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE offer IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((offer), ())


-- checking data validity based on phone_service subscription
-- results: no anomalies
SELECT 
	phone_service,
	COUNT(multiple_lines) FILTER(WHERE multiple_lines = 'Yes') AS with_multiple_lines,
	COUNT(multiple_lines) FILTER(WHERE multiple_lines = 'No') AS without_multiple_lines,
	MIN(avg_monthly_long_distance_charges),
	ROUND(AVG(avg_monthly_long_distance_charges), 2) AS avg,
	MAX(avg_monthly_long_distance_charges),
	COUNT(*) AS no_of_customers
FROM customer_churn_raw
GROUP BY phone_service
ORDER BY no_of_customers DESC

-- checking data validity based on internet_service subscription
-- results: no anomalies, no internet product for non-internet users
SELECT  
	internet_service,
	COUNT(*) AS no_of_customers,
	ROUND(AVG(avg_monthly_gb_download), 2) AS AVG,
	MIN(avg_monthly_gb_download),
	MAX(avg_monthly_gb_download),
	COUNT(online_security) AS with_online_security,
	COUNT(online_backup) AS with_online_backup,
	COUNT(device_protection_plan) AS with_device_protection_plan,
	COUNT(premium_tech_support) AS with_premium_tech_support,
	COUNT(streaming_tv) AS with_streaming_tv,
	COUNT(streaming_movies) AS with_streaming_movies,
	COUNT(unlimited_data) AS with_unlimited_data
FROM customer_churn_raw
GROUP BY internet_service
ORDER BY no_of_customers DESC

-- looking at customer spread by type of internet
-- results: no anomalies
SELECT  
	internet_type,
	COUNT(*) AS no_of_customers,
	ROUND(AVG(avg_monthly_gb_download), 2) AS AVG,
	MIN(avg_monthly_gb_download),
	MAX(avg_monthly_gb_download),
	COUNT(*) FILTER (WHERE online_security = 'Yes') AS with_online_security,
	COUNT(*) FILTER (WHERE online_backup = 'Yes') AS with_online_backup,
	COUNT(*) FILTER (WHERE device_protection_plan = 'Yes') AS with_device_protection_plan,
	COUNT(*) FILTER (WHERE premium_tech_support = 'Yes') AS with_premium_tech_support,
	COUNT(*) FILTER (WHERE streaming_tv = 'Yes') AS with_streaming_tv,
	COUNT(*) FILTER (WHERE streaming_movies = 'Yes') AS with_streaming_movies,
	COUNT(*) FILTER (WHERE unlimited_data = 'Yes') AS unlimited_data
FROM customer_churn_raw
GROUP BY internet_type
HAVING internet_type IS NOT NULL
ORDER BY no_of_customers DESC

--examine the imported data from churn table
SELECT * FROM customer_churn_raw

-- check customer_id for duplicates
-- results: no duplicates
SELECT 
	customer_id, 
	COUNT(*)
FROM customer_churn_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- check missing values for gender and knowing gender distribution	
-- results: no missing, even distibution
SELECT 
    COALESCE(gender, 'Total') AS gender,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE gender IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((gender), ())

-- checking age validity
-- results: age makes sense
SELECT 
	MIN(age) youngest, 
	MAX(age) oldest, 
	COUNT(*) FILTER(where age IS NUll) no_of_missing
FROM customer_churn_raw

-- check missing values for marital status and knowing distribution	
-- results: no missing, even distribution
SELECT 
    COALESCE(married, 'Total') AS married,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE married IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((married), ())

-- checking no_of_dependents validity
-- results: no_of_dependents makes sense
SELECT 
	MIN(no_of_dependents) least_dependents, 
	MAX(no_of_dependents) most_dependents, 
	COUNT(*) FILTER(WHERE no_of_dependents IS NUll) no_of_missing
FROM customer_churn_raw

-- checking missing city and zipcode and if it is valid
-- results: no missing, no abnormal amount of zipcodes
SELECT 
	COUNT(*) FILTER (WHERE city IS NULL) AS missing_city,
	COUNT(*) FILTER (WHERE zip_code IS NULL) AS missing_zip_code,
	COUNT(*) FILTER (WHERE latitude IS NULL) AS missing_latitude,
	COUNT(*) FILTER (WHERE longitude IS NULL) AS missing_longitude,
	COUNT(DISTINCT city) AS total_cities,
	COUNT(DISTINCT zip_code) AS total_zipdcode,
	COUNT(DISTINCT latitude) AS total_latitude,
	COUNT(DISTINCT longitude) AS total_longitude
FROM customer_churn_raw

SELECT
	MAX(num_zip_codes),
	MIN(num_zip_codes)
FROM (
	SELECT 
    	city,
    	COUNT(DISTINCT zip_code) AS num_zip_codes
	FROM customer_churn_raw
	GROUP BY city
	ORDER BY num_zip_codes, city
)

-- checking no_of_referrals validity
-- results: no_of_referrals makes sense
SELECT 
	MIN(no_of_referrals) least_referrals, 
	MAX(no_of_referrals) most_referrals, 
	COUNT(*) FILTER(where no_of_referrals IS NUll) no_of_missing
FROM customer_churn_raw

-- checking tenure_in_months validity
-- results: tenure_in_months makes sense
SELECT 
	MIN(tenure_in_months) least_tenure, 
	MAX(tenure_in_months) most_tenure, 
	COUNT(*) FILTER(where tenure_in_months IS NUll) no_of_missing
FROM customer_churn_raw

-- checking offer validity and distribution
-- results: no anomalies

SELECT 
    COALESCE(offer, 'Total') AS offer,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE offer IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((offer), ())


-- checking data validity based on phone_service subscription
-- results: no anomalies
SELECT 
	phone_service,
	COUNT(multiple_lines) FILTER(WHERE multiple_lines = 'Yes') AS with_multiple_lines,
	COUNT(multiple_lines) FILTER(WHERE multiple_lines = 'No') AS without_multiple_lines,
	MIN(avg_monthly_long_distance_charges),
	ROUND(AVG(avg_monthly_long_distance_charges), 2) AS avg,
	MAX(avg_monthly_long_distance_charges),
	COUNT(*) AS no_of_customers
FROM customer_churn_raw
GROUP BY phone_service
ORDER BY no_of_customers DESC

-- checking data validity based on internet_service subscription
-- results: no anomalies, no internet product for non-internet users
SELECT  
	internet_service,
	COUNT(*) AS no_of_customers,
	ROUND(AVG(avg_monthly_gb_download), 2) AS AVG,
	MIN(avg_monthly_gb_download),
	MAX(avg_monthly_gb_download),
	COUNT(online_security) AS with_online_security,
	COUNT(online_backup) AS with_online_backup,
	COUNT(device_protection_plan) AS with_device_protection_plan,
	COUNT(premium_tech_support) AS with_premium_tech_support,
	COUNT(streaming_tv) AS with_streaming_tv,
	COUNT(streaming_movies) AS with_streaming_movies,
	COUNT(unlimited_data) AS with_unlimited_data
FROM customer_churn_raw
GROUP BY internet_service
ORDER BY no_of_customers DESC

-- looking at customer spread by type of internet
-- results: no anomalies
SELECT  
	internet_type,
	COUNT(*) AS no_of_customers,
	ROUND(AVG(avg_monthly_gb_download), 2) AS AVG,
	MIN(avg_monthly_gb_download),
	MAX(avg_monthly_gb_download),
	COUNT(*) FILTER (WHERE online_security = 'Yes') AS with_online_security,
	COUNT(*) FILTER (WHERE online_backup = 'Yes') AS with_online_backup,
	COUNT(*) FILTER (WHERE device_protection_plan = 'Yes') AS with_device_protection_plan,
	COUNT(*) FILTER (WHERE premium_tech_support = 'Yes') AS with_premium_tech_support,
	COUNT(*) FILTER (WHERE streaming_tv = 'Yes') AS with_streaming_tv,
	COUNT(*) FILTER (WHERE streaming_movies = 'Yes') AS with_streaming_movies,
	COUNT(*) FILTER (WHERE unlimited_data = 'Yes') AS unlimited_data
FROM customer_churn_raw
GROUP BY internet_type
HAVING internet_type IS NOT NULL
ORDER BY no_of_customers DESC

-- checking contract, billing, and payment method distribution
-- results: no anomalies
SELECT 
    COALESCE(contract, 'Total') AS contract,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE contract IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((contract), ())

SELECT 
    COALESCE(paperless_billing, 'Total') AS paperless_billing,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE paperless_billing IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((paperless_billing), ())

SELECT 
    COALESCE(payment_method, 'Total') AS payment_method,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE payment_method IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM customer_churn_raw
GROUP BY GROUPING SETS ((payment_method), ())

SELECT
	offer,
	COUNT(*),
	ROUND(AVG(avg_monthly_gb_download), 2) AS avg_monthly_gb,
	MIN(avg_monthly_gb_download) AS min_monthly_gb,
	MAX(avg_monthly_gb_download) AS max_monthly_gb,
	ROUND(AVG(total_extra_data_charges), 2) AS avg_total_extra_data_charges,
	MIN(total_extra_data_charges) AS min_total_extra_data_charges,
	MAX(total_extra_data_charges) AS max_total_extra_data_charges
FROM customer_churn_raw
WHERE avg_monthly_gb_download = 2 AND total_extra_data_charges > 0
GROUP BY offer

-- checking the validity of total_extra_data_charges
-- results: total_extra_data_charges is strictly tied to internet_service and unlimited_data value, no anomalies
SELECT
	internet_service,
	unlimited_data,
	COUNT(*),
	ROUND(AVG(total_extra_data_charges), 2) AS avg_total_extra_data_charges,
	MIN(total_extra_data_charges) AS min_total_extra_data_charges,
	MAX(total_extra_data_charges) AS max_total_extra_data_charges
FROM customer_churn_raw
WHERE total_extra_data_charges > 0
GROUP BY internet_service, unlimited_data

-- checking the validity of total_extra_data_charges
-- results: total_extra_data_charges is strictly tied to internet_service and unlimited_data value, no anomalies
SELECT 
	phone_service,
	multiple_lines,
	COUNT(*),
	ROUND(AVG(total_long_distance_charges), 2) AS avg_total_long_distance_charges,
	MIN(total_long_distance_charges) AS min_total_long_distance_charges,
	MAX(total_long_distance_charges) AS max_total_long_distance_charges
FROM customer_churn_raw
WHERE total_long_distance_charges > 0
GROUP BY phone_service

-- checking the validity of billing records
-- result: no anomalies
WITH monthly_charge_category AS (
	SELECT 
		CASE
    		WHEN monthly_charge < 0 THEN 'Negative Monthly Charge'
    		ELSE 'Positive Monthly Charge'
		END AS monthly_charge_type,
		CASE
    		WHEN total_refunds > 0 THEN true
    		ELSE false
		END AS is_refunded
	FROM customer_churn_raw
)

SELECT 
	COALESCE(monthly_charge_type, 'Total') AS monthly_charge_type,
	is_refunded,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE monthly_charge_type IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM monthly_charge_category
GROUP BY GROUPING SETS ((monthly_charge_type, is_refunded), ())

SELECT 
	COUNT(*),
	CASE
    	WHEN (total_charges + total_extra_data_charges + total_long_distance_charges - total_refunds ) = total_revenue THEN 'Valid'
    	ELSE 'Invalid'
	END AS is_valid
FROM customer_churn_raw
GROUP BY is_valid

-- checking churn data based on customer_status
-- result: no anomaly
WITH has_churn_data_category AS (
	SELECT * , 
		CASE
    		WHEN churn_category IS NOT NULL and churn_reason IS NOT NULL  THEN true
    		ELSE false
		END AS has_churn_data
	FROM customer_churn_raw
)

SELECT 
	COALESCE(customer_status, 'Total') AS customer_status,
	has_churn_data,
    COUNT(*) AS no_of_customers,
    ROUND(
        COUNT(*) * 100.0 
        / SUM(COUNT(*)) FILTER (WHERE customer_status IS NOT NULL) OVER (),
        2
    ) AS percent_from_total
FROM has_churn_data_category
GROUP BY GROUPING SETS ((customer_status, has_churn_data), ())
