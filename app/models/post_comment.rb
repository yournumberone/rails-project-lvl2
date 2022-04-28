# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates :content, presence: true
end
