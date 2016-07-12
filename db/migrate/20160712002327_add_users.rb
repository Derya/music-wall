class AddUsers < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.references :user
    end

    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :profile_pic_url
      t.text :biography
      t.timestamps
    end
  end
end