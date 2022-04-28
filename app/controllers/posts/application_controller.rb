# frozen_string_literal: true

class Posts::ApplicationController < ApplicationController
  def find_post
    Post.find(params[:post_id])
  end
end
