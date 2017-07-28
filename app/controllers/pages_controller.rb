class PagesController < ApplicationController
  before_action :find_page, only: [:edit, :update, :show, :destroy]

  def index
    @pages = Pages.all
  end

  def new
    @page = Page.new
    authorize! :create, @page
  end

  def create
    authorize! :create, @page
    @page = Page.new
    if @page.update(page_params)
      flash[:notice] = "Successfully created page!"
      redirect_to page_path(@page)
    else
      flash[:alert] = "Error creating new page!"
      render :new
    end
  end

  def edit
    authorize! :update, @page
  end

  def show
  end

  def update
    authorize! :update, @page
    if @page.update_attributes(page_params)
      flash[:notice] = "Successfully updated page!"
      redirect_to page_path(@page)
    else
      flash[:alert] = "Error updating page!"
      render :edit
    end
  end

  def destroy
    authorize! :destory, @page
    if @page.destroy
      flash[:notice] = "Successfully deleted page!"
      redirect_to pages_path
    else
      flash[:alert] = "Error updating page!"
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :title, :path, :body)
  end

  def find_page
    @page = Page.where(path: params[:path]).first
  end
end
