class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :track
      t.integer :rating
      t.text :content
      t.timestamps
    end
  end
end
