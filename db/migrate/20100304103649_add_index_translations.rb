class AddIndexTranslations < ActiveRecord::Migration
  def self.up
    add_index :translations, [:mail_id, :language_id], :unique => true
  end

  def self.down
    remove_index :translations, :columns => [:mail_id, :language_id]
  end
end
