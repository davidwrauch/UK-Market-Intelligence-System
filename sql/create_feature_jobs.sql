CREATE OR REPLACE TABLE `{project_id}.{dataset}.feature_jobs` AS
SELECT
    ingested_at,
    job_id,
    search_term,
    search_location,
    location_filter_applied,
    title,
    company,
    location,
    category,
    description,
    redirect_url,
    created,
    salary_min,
    salary_max,
    CASE
        WHEN salary_min IS NOT NULL AND salary_max IS NOT NULL THEN (salary_min + salary_max) / 2
        WHEN salary_min IS NOT NULL THEN salary_min
        WHEN salary_max IS NOT NULL THEN salary_max
        ELSE NULL
    END AS salary,

    LOWER(CAST(title AS STRING)) LIKE '%senior%' AS senior_flag,
    LOWER(CAST(title AS STRING)) LIKE '%lead%' AS lead_flag,
    LOWER(CAST(title AS STRING)) LIKE '%machine learning%' OR LOWER(CAST(title AS STRING)) LIKE '% ml %' AS ml_flag,
    LOWER(CAST(title AS STRING)) LIKE '%analyst%' AS analyst_flag,

    LOWER(TRIM(CAST(company AS STRING))) AS company_lower,
    LOWER(TRIM(CAST(title AS STRING))) AS title_lower,

    CASE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%training%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%learning%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%course%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%bootcamp%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%career switch%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%itonlinelearning%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%newto training%' THEN 'training_or_spam'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%recruit%' THEN 'recruiter'
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%career%' THEN 'recruiter'
        ELSE 'employer'
    END AS job_type_category,

    CASE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%training%' THEN FALSE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%learning%' THEN FALSE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%course%' THEN FALSE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%bootcamp%' THEN FALSE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%career switch%' THEN FALSE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%itonlinelearning%' THEN FALSE
        WHEN LOWER(TRIM(CAST(company AS STRING))) LIKE '%newto training%' THEN FALSE
        ELSE TRUE
    END AS is_valid_job

FROM `{project_id}.{dataset}.raw_jobs`;
