class AddDefaultCountValues < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :post_likes_count, :integer, :default => 0
    change_column :posts, :post_comments_count, :integer, :default => 0
  end
end
