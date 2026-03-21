-- create table while copying schema of customer_churn_raw
CREATE TABLE customer_churn_cleaned (LIKE customer_churn_raw INCLUDING ALL);

-- rename table
ALTER TABLE customer_churn_cleaned
RENAME TO customer_churn_clean;

-- copy data
INSERT INTO customer_churn_clean
SELECT * FROM customer_churn_raw;

-- alter columns using a tranform logic for values
ALTER TABLE customer_churn_clean
ALTER COLUMN married TYPE boolean
USING LOWER(married) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN phone_service TYPE boolean
USING LOWER(phone_service) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN multiple_lines TYPE boolean
USING LOWER(multiple_lines) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN internet_service TYPE boolean
USING LOWER(internet_service) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN online_security TYPE boolean
USING LOWER(online_security) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN online_backup TYPE boolean
USING LOWER(online_backup) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN device_protection_plan TYPE boolean
USING LOWER(device_protection_plan) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN premium_tech_support TYPE boolean
USING LOWER(premium_tech_support) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN streaming_tv TYPE boolean
USING LOWER(streaming_tv) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN streaming_movies TYPE boolean
USING LOWER(streaming_movies) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN streaming_music TYPE boolean
USING LOWER(streaming_music) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN unlimited_data TYPE boolean
USING LOWER(unlimited_data) = 'yes';

ALTER TABLE customer_churn_clean
ALTER COLUMN paperless_billing TYPE boolean
USING LOWER(paperless_billing) = 'yes';

-- view data
SELECT * FROM customer_churn_clean
