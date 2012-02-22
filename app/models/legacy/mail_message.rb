class MailMessage < ActiveRecord::Base
  establish_connection "legacy"
  
  set_primary_key [:mail_messages_id, :language_id]
  
end