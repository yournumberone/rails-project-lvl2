class PostCategory < ApplicationRecord
  has_many :posts, dependent: :nullify
end
