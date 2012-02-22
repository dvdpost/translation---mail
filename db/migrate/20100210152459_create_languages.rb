class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci"  do |t|
      t.string :name
      t.timestamps
    end
    
    Language.new(:name => 'fr').save!
    Language.new(:name => 'nl').save!    
    Language.new(:name => 'en').save!
  end

  def self.down
    drop_table :languages
  end
end
