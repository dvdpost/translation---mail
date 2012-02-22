class CreateMailMessages < ActiveRecord::Migration
  def self.up
    create_table :mails, :options => "DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci" do |t|
      t.string :name
      t.string :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :mails
  end
end
