Ejercicio 4. CREAR TABLA DE ivr_summary. 

CREATE OR REPLACE TABLE keepcoding.ivr_summary as 

SELECT 

calls_ivr_id as ivr_id, 

calls_phone_number as phone_number,  

calls_ivr_result as ivr_result, 

if (LEFT(calls_vdn_label,3) = 'ATC','FRONT', 

  if (LEFT (calls_vdn_label,4) = 'TECH', 'TECH', 

    if (LEFT (calls_vdn_label,11) = 'ABSORPTION', 'ABSORPTION', 

      'RESTO' 

    ) 

  ) 

) as vdn_aggregation, 

calls_start_date, 

calls_end_date,  

calls_total_duration,  

calls_ivr_language, 

calls_steps_module,  

calls_module_aggregation,  

COALESCE(MAX(CASE  

                WHEN UPPER(TRIM(document_type)) <> 'UNKNOWN' THEN document_type 

                ELSE NULL  

              END), 'UNKNOWN') AS document_type, 

COALESCE(MAX(CASE  

                WHEN UPPER(TRIM(document_identification)) <> 'UNKNOWN' THEN document_identification 

                ELSE NULL  

              END), 'UNKNOWN') AS document_identification, 

COALESCE(MAX(CASE  

                WHEN UPPER(TRIM(customer_phone)) <> 'UNKNOWN' THEN customer_phone 

                ELSE NULL  

              END), 'UNKNOWN') AS customer_phone, 

COALESCE(MAX(CASE  

                WHEN UPPER(TRIM(billing_account_id)) <> 'UNKNOWN' THEN billing_account_id 

                ELSE NULL  

              END), 'UNKNOWN') AS billing_account_id, 

MAX(if (UPPER(TRIM(module_name,' ')) = 'AVERIA_MASIVA',1,0)) as masiva_lg, 

MAX(if (UPPER(TRIM(step_name,' ')) = 'CUSTOMERINFOBYPHONE.TX' AND UPPER(TRIM(step_description_error,' ')) = 'UNKNOWN',1,0)) as info_by_phone_lg, 

MAX(if (UPPER(TRIM(step_name,' ')) = 'CUSTOMERINFOBYDNI.TX' AND UPPER(TRIM(step_description_error,' ')) = 'UNKNOWN',1,0)) as info_by_dni_lg 

FROM `alzuaskeepcoding.keepcoding.ivr_detail` 

GROUP BY 

  calls_ivr_id,calls_phone_number,calls_ivr_result,calls_vdn_label,calls_start_date, 

calls_end_date,  

calls_total_duration,  

calls_ivr_language, 

calls_steps_module,  

calls_module_aggregation; 

   

CREATE OR REPLACE VIEW `keepcoding.auxiliar` AS 

  WITH CallsWithLagAndLead AS ( 

  SELECT 

    ivr_id, 

    phone_number, 

    calls_start_date, 

    LAG(calls_start_date) OVER (PARTITION BY phone_number ORDER BY calls_start_date) AS previous_call_timestamp, 

    LEAD(calls_start_date) OVER (PARTITION BY phone_number ORDER BY calls_start_date) AS next_call_timestamp 

  FROM 

    `alzuaskeepcoding.keepcoding.ivr_summary` 

) 

SELECT 

  *, 

  CASE 

    WHEN TIMESTAMP_DIFF(calls_start_date, previous_call_timestamp, HOUR) <= 24 THEN 1 

    ELSE 0 

  END AS repeated_phone_24H, 

  CASE 

    WHEN TIMESTAMP_DIFF(next_call_timestamp, calls_start_date, HOUR) <= 24 THEN 1 

    ELSE 0 

  END AS cause_recall_phone_24H 

FROM 

  CallsWithLagAndLead; 

 

CREATE OR REPLACE TABLE keepcoding.ivr_summary as 

SELECT ivr_summary.*, ivr_auxiliar.repeated_phone_24H,ivr_auxiliar.cause_recall_phone_24H FROM alzuaskeepcoding.keepcoding.ivr_summary as ivr_summary 

JOIN 

  alzuaskeepcoding.keepcoding.auxiliar as ivr_auxiliar 

ON 

  ivr_summary.ivr_id = ivr_auxiliar.ivr_id 