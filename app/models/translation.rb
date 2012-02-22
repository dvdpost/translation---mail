class Translation < ActiveRecord::Base

  validates_presence_of :subject, :body
  
  belongs_to :mailer
  belongs_to :language
  validate :exist, :on => :create
  def exist  
    size= self.language.translations.where("mailer_id = ?",self.mailer.id).size
    errors.add('translation already exist') if size>0
  end   
end
