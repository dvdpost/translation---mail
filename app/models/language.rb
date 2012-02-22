class Language < ActiveRecord::Base
  has_many :keys_translations
  has_many :translations
end
