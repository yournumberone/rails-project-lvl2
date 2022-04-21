# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def set_post
    @post = Post.find(params[:post_id])
  end
end
