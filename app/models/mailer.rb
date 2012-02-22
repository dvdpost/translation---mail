class Mailer < ActiveRecord::Base
  has_many :translations
  belongs_to :category_ticket, :foreign_key => :category_id
  validates_presence_of :name, :unless => :deleted?

  def self.import_legacy
    MailMessage.group(mail_messages_id).each do |m|
      trans = MailMessage.where("mail_messages_id = ?", m.mail_messages_id).order('language_id')
      mail = Mailer.new(:name => trans[0].messages_subject)
      mail.id = trans[0].mail_messages_id
      mail.save(false)
      trans.each do |trn|
        t = Translation.new(:subject => trn.messages_subject, :body => trn.messages_html)
        t.mail = mail
        t.language = Language.find(trn.language_id)
        t.save(false)
      end
    end
  end
  
  def self.per_page
    20
  end
end