Ejercicio 3. CREAR TABLA DE ivr_detail. 

CREATE TABLE keepcoding.ivr_detail AS  

SELECT 

  ivr_calls.ivr_id as calls_ivr_id, 

  ivr_calls.phone_number as calls_phone_number, 

  ivr_calls.ivr_result as calls_ivr_result, 

  ivr_calls.vdn_label as calls_vdn_label, 

  ivr_calls.start_date as calls_start_date, 

  FORMAT_DATE("%Y%m%d",ivr_calls.start_date) AS calls_start_date_id, 

  ivr_calls.end_date as calls_end_date, 

 FORMAT_DATE("%Y%m%d",ivr_calls.end_date) AS calls_end_date_id, 

  ivr_calls.total_duration as calls_total_duration, 

  ivr_calls.customer_segment as calls_customer_segment, 

  ivr_calls.ivr_language as calls_ivr_language, 

  ivr_calls.steps_module as calls_steps_module, 

  ivr_calls.module_aggregation as calls_module_aggregation, 

  ivr_modules.module_sequece as module_sequece, 

  ivr_modules.module_name as module_name, 

  ivr_modules.module_duration as module_duration, 

  ivr_modules.module_result as module_result, 

  ivr_steps.step_sequence as step_sequence, 

  ivr_steps.step_name as step_name, 

  ivr_steps.step_result as step_result, 

  ivr_steps.step_description_error as step_description_error, 

  ivr_steps.document_type as document_type, 

  ivr_steps.document_identification as document_identification, 

  ivr_steps.customer_phone as customer_phone, 

  ivr_steps.billing_account_id as billing_account_id 

 

FROM 

  `alzuaskeepcoding.keepcoding.ivr_calls` as ivr_calls 

JOIN 

  `alzuaskeepcoding.keepcoding.ivr_modules` as ivr_modules 

ON 

  ivr_calls.ivr_id = ivr_modules.ivr_id 

JOIN 

  `alzuaskeepcoding.keepcoding.ivr_steps` as ivr_steps 

ON 

  CONCAT(ivr_steps.ivr_id,'_',ivr_steps.module_sequece) = CONCAT(ivr_modules.ivr_id,'_',ivr_modules.module_sequece); 