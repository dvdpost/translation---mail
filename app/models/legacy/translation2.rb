class Translation2 < ActiveRecord::Base
  establish_connection "legacy_common"
  set_table_name :translation2
  set_primary_key  :translation_id 
  
end
 