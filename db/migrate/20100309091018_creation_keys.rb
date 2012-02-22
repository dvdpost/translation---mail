class CreationKeys < ActiveRecord::Migration
    def self.up
      create_table :keys, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci" do |t|
        t.string :page
        t.string :name
        t.timestamps
      end
      create_table :keys_translations, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci" do |t|
        t.integer :key_id
        t.integer :language_id
        t.integer :country_id
        t.string :value
        t.timestamps
      end
      create_table :countries, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci" do |t|
        t.string :name
        t.string :short
        t.integer :entity_id
        t.timestamps
      end
    end

    def self.down
      drop_table :keys
      drop_table :keys_translations
      drop_table :countries
    end
  end