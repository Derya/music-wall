class Upvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :user
      t.references :track
      t.timestamps
    end
  end
end
