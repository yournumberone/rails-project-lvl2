# frozen_string_literal: true

class PostCategory < ApplicationRecord
  has_many :posts, dependent: :nullify
  validates :name, presence: true
end
