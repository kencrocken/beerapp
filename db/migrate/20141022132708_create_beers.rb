class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.datetime :drank_on

      t.timestamps
    end
  end
end
