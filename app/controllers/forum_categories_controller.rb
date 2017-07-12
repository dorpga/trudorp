class ForumCategoriesController < ApplicationController
  before_action :find_forum_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = ForumCategory.all
  end

  def new
    @forum_category = ForumCategory.new
    authorize! :create, @forum_category
  end

  def create
    authorize! :create, @forum_category
    @forum_category = ForumCategory.new
    if @forum_category.update(forum_category_params)
      flash[:notice] = "Successfully created category!"
      redirect_to forum_category_path(@forum_category)
    else
      flash[:alert] = "Error creating new category!"
      render :new
    end
  end

  def edit
    authorize! :update, @forum_category
  end

  def show
  end

  def update
    authorize! :update, @forum_category
    if @forum_category.update_attributes(forum_category_params)
      flash[:notice] = "Successfully updated forum category!"
      redirect_to forum_category_path(@forum_category)
    else
      flash[:alert] = "Error updating forum category!"
      render :edit
    end
  end

  def destroy
    authorize! :destory, @forum_category
    if @forum_category.destroy
      flash[:notice] = "Successfully deleted category!"
      redirect_to forum_categories_path
    else
      flash[:alert] = "Error updating category!"
    end
  end

  private

  def forum_category_params
    params.require(:forum_category).permit(:title, :description)
  end

  def find_forum_category
    @forum_category = ForumCategory.find(params[:id])
  end
end
