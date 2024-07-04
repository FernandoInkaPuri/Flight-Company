class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :route_origin
      t.string :route_destiny
      t.string :departure_date
      t.string :return_date
    end
  end
end
