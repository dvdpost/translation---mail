class CreateMailMessagesTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci"  do |t|
      t.string :subject
      t.text :body
      t.integer :language_id
      t.integer :mail_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
