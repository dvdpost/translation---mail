class RefontDb < ActiveRecord::Migration
  def self.up
    remove_column :keys_translations,:country_id
    rename_column :keys_translations,:key_id,:key_country_id  
    create_table :keys_countries, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci" do |t|
      t.integer :key_id
      t.integer :country_id
      t.timestamps
    end
  end

  def self.down
    add_column :keys_translations,:country_id, :integer
    rename_column :keys_translations,:key_id;:key_country_id
    drop_table :keys_countries 
    
  end
end
