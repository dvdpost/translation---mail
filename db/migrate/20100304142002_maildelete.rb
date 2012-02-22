class Maildelete < ActiveRecord::Migration
  def self.up
    add_column :mails, :deleted, :boolean, :default=>0
  end

  def self.down
    remove_column :mails, :deleted
  end
end
