class BlogPostsController < ApplicationController
  before_action :find_blog_comment, only: [:update, :destroy]

  def update
    authorize! :update, @blog_comment
    if @blog_comment.update_attributes(blog_comment_params)
      flash[:notice] = "Successfully updated blog comment!"
      redirect_to blog_post_path(@blog_comment.blog_post_id)
    else
      flash[:alert] = "Error updating blog comment!"
      redirect_to blog_post_path(@blog_comment.blog_post_id)
    end
  end

  def destroy
    authorize! :destory, @blog_comment
    if @blog_comment.destroy
      flash[:notice] = "Successfully deleted blog comment!"
      redirect_to blog_post_path(@blog_comment.blog_post_id)
    else
      flash[:alert] = "Error deleting blog comment!"
    end
  end

  def create
    authorize! :create, @blog_comment
    @blog_comment = current_user.blog_comments.build(blog_comments_params)
    if @blog_comment.save
      flash[:notice] = "Successfully created blog comment!"
      redirect_to blog_post_path(@blog_comment.blog_post_id)
    else
      flash[:alert] = "Error creating new blog comment!"
      render blog_post_path(@blog_comment.blog_post_id)
    end
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:title, :body)
  end

  def find_blog_comment
    @blog_comment = BlogPost.where(slug: params[:slug]).first
  end
end
