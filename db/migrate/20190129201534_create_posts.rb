class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :article
      t.integer :likes
      t.integer :status, defaut: 1

      t.timestamps
    end
  end
end
