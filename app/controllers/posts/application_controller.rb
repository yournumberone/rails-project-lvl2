# frozen_string_literal: true

class Posts::ApplicationController < ApplicationController
  def set_post
    @post = Post.find(params[:post_id])
  end
end
