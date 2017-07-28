class BlogTagsController < ApplicationController
  before_action :find_blog_tag, only: [:show]

  def show
    authorize! :show, BlogTag
    @blog_posts = @blog_tag.blog_posts
  end

  private
  def find_blog_tag
    @blog_tag = BlogTag.find_by_name!(params[:slug])
  end
end
