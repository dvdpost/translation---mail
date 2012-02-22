class Country < ActiveRecord::Base
  has_many :references
  has_many :keys, :through => :references
end