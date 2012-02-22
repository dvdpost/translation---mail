class Key < ActiveRecord::Base
  has_many :keys_translations
  has_many :references
  has_many :countries, :through => :references

  validates_presence_of :name
  scope :by_page, lambda {|page| {:conditions => {:page => page}}}
  scope :ordered, :order => "id desc"
  
  after_destroy { |record| 
    Reference.destroy_all(:key_id => record.id)
  }
  
  def self.import_legacy
    belgium=Country.find(1)
    nederlands=Country.find(2)
    
    
    Translation2.all(:group => 'translation_page,translation_key').each do |t|
        page=t.translation_page
        key=Key.new(:page=>page,:name=>t.translation_key)
        key.save!
        Translation2.all(:conditions=>"translation_page = '#{t.translation_page}' and translation_key = '#{t.translation_key}' ", :group => 'entityid').each do |t2|
          if(t2.EntityID==38)
            reference=Reference.new(:key => key,:country => nederlands)
          else
            reference=Reference.new(:key => key,:country => belgium)
          end  
          reference.save!
          Translation2.all(:conditions=>"translation_page = '#{t2.translation_page}' and translation_key = '#{t2.translation_key}' ").each do |t3|
            translation=KeysTranslation.new(:reference => reference,:value => t3.translation_value,:language_id => t3.language_id)
            translation.save!
          end  
        end
    end
  end
  
  def self.per_page
    50
  end
  
end