class ForumPostsController < ApplicationController
  before_action :find_forum_post, only: [:edit, :update, :show, :destroy]

  def new
    @forum_post = ForumPost.new
    authorize! :new, @forum_post
  end

  def edit
    authorize! :update, @forum_post
  end

  def create
    @forum_post = ForumPost.new
    authorize! :create, @forum_post

    t = nil

    if params[:thread_id]
      t = ForumThread.find(params[:thread_id])
      puts('UUUUU')
      t.forum_posts.create(title: params.require(:forum_post)[:title], body: params.require(:forum_post)[:body], user: current_user)
      current_user.add_role :creator, t.forum_posts.last
    else
      t = ForumThread.new(forum_category_id: params[:category_id])
      t.save
      t.forum_posts.create(title: params.require(:forum_post)[:title], body: params.require(:forum_post)[:body], user: current_user)
      current_user.add_role :creator, t.forum_posts.last
    end

    redirect_to forum_thread_path(t.id)
  end

  def destroy
    authorize! :destory, @forum_post
    if @forum_post.destroy
      flash[:notice] = "Successfully deleted forum post!"
      redirect_to forum_thread_path(@forum_post.forum_thread_id)
    else
      flash[:alert] = "Error updating forum post!"
    end
  end

  def update
    authorize! :update, @forum_post
    if @forum_post.update_attributes(forum_post_params)
      flash[:notice] = "Successfully updated forum post!"
      redirect_to forum_thread_path(@forum_post.forum_thread_id)
    else
      flash[:alert] = "Error updating forum post!"
      render :edit
    end
  end

  def show
  end

  def index
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:title, :body)
  end

  def find_forum_post
    @forum_post = ForumPost.find(params[:id])
  end
end
