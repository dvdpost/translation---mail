class InsertCountries < ActiveRecord::Migration
  def self.up
    Country.new(:name => 'Belgium',:short=>'be',:entity_id=>1).save!
    Country.new(:name => 'Nederlands',:short=>'nl',:entity_id=>38).save!
  end

  def self.down
  end
end
