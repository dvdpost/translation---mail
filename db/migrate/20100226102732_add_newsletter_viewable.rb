class AddNewsletterViewable < ActiveRecord::Migration
  def self.up
    add_column :mails, :newsletter, :boolean
    add_column :mails, :viewable, :boolean
  end

  def self.down
    remove_column :mails, :viewable
    remove_column :mails, :newsletter
  end
end
