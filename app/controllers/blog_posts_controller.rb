class BlogPostsController < ApplicationController
  before_action :find_blog_post, only: [:edit, :update, :show, :destroy]

  def index
    @blog_posts = BlogPost.all
  end

  def show
    authorize! :show, @blog_post
    @blog_comment = BlogComment.new
  end

  def edit
    authorize! :update, @blog_post
  end

  def new
    authorize! :create, @blog_post
    @blog_post = BlogPost.new
  end

  def update
    authorize! :update, @blog_post
    if @blog_post.update_attributes(blog_post_params) && @blog_post.update_attribute(:slug, @blog_post.slug.parameterize)
      flash[:notice] = "Successfully updated blog post!"
      redirect_to blog_post_path(@blog_post)
    else
      flash[:alert] = "Error updating blog post!"
      render :edit
    end
  end

  def destroy
    authorize! :destory, @blog_post
    if @blog_post.destroy
      flash[:notice] = "Successfully deleted blog post!"
      redirect_to blog_posts_path
    else
      flash[:alert] = "Error deleting blog post!"
    end
  end

  def create
    authorize! :create, @blog_post
    @blog_post = current_user.blog_posts.build(blog_post_params)
    @blog_post.slug = @blog_post.slug.parameterize
    if @blog_post.save
      flash[:notice] = "Successfully created blog post!"
      redirect_to blog_post_path(@blog_post)
    else
      flash[:alert] = "Error creating new blog post!"
      render :new
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :slug, :all_tags)
  end

  def find_blog_post
    @blog_post = BlogPost.where(slug: params[:slug]).first
  end
end
