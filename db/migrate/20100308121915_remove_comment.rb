class RemoveComment < ActiveRecord::Migration
    def self.up
      remove_column :mails, :comment
    end

    def self.down
      add_column :mails, :comment, :string
    end
  end
