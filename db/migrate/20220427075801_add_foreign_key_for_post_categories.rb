class AddForeignKeyForPostCategories < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :posts, :post_categories
  end
end
