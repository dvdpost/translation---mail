class Reference < ActiveRecord::Base
  belongs_to :key
  belongs_to :country
  has_many :keys_translations
  validate :exist, :on => :create
  def exist
    size= Reference.where("key_id = ? and country_id = ?",self.key_id,self.country_id).size
    errors.add('reference already exist') if size>0
  end
  
  
  after_destroy { |record| 
    KeysTranslation.destroy_all(:reference_id=>record.id)
  }
  
end