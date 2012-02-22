class KeysTranslation < ActiveRecord::Base
  belongs_to :reference
  belongs_to :language
  
end