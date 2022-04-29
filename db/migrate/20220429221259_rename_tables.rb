class RenameTables < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_categories, :categories
    rename_column :posts, :post_category_id, :category_id
  end
end
