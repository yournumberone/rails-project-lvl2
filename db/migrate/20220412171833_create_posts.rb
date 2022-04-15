class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, index: true
      t.references :post_category, index: true

      t.timestamps
    end
  end
end
