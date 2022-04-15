class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category, class_name: 'PostCategory', foreign_key: 'post_category_id'
end
