class CategoryTicket < ActiveRecord::Base
  establish_connection "legacy"
  has_many :mails, :foreign_key => :category_id
end