class RenameData < ActiveRecord::Migration
  def self.up
    rename_table :countries_keys, :references
    rename_column :keys_translations, :key_country_id, :reference_id
  end

  def self.down
    rename_table :references, :countries_keys
    rename_column :reference_id, :key_country_id
  end
end
