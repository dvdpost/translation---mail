class RenameCountries < ActiveRecord::Migration
  def self.up
    rename_table :keys_countries, :countries_keys
  end

  def self.down
    rename_table :countries_keys,:keys_countries
  end
end
