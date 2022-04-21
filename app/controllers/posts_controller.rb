# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_post, only: %i[destroy show edit update]
  before_action :owner?, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      redirect_to post_path(@post), notice: t('.success')
    else
      flash[:alert] = t('.error')
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t('.success')
    else
      flash[:alert] = t('.error')
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: t('.success')
    else
      redirect_to post_path(@post), alert: t('.error')
    end
  end

  private

  def post_params
    params.require(:post).permit(%i[title body post_category_id])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def owner?
    @photo = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, alert: t('permission_denied') if @photo.nil?
  end
end
