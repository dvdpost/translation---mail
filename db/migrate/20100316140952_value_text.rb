class ValueText < ActiveRecord::Migration
  def self.up
    change_column :keys_translations, :value, :text
  end

  def self.down
    change_column :keys_translations, :value, :string
  end
end
