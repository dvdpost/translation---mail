class Createindex < ActiveRecord::Migration
  def self.up
    add_index(:keys_translations, :reference_id)
    add_index(:references, :key_id)
  end

  def self.down
    remove_index(:keys_translations, :reference_id)
    remove_index(:references, :key_id)
  end
end
