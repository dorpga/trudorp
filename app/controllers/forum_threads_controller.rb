class ForumThreadsController < ApplicationController
  before_action :find_forum_thread, only: [:edit, :update, :show, :destroy]

  def new
    @forum_thread = ForumThread.new
    authorize! :create, @forum_thread
  end

  def edit
    authorize! :update, @forum_thread
  end

  def create
    @forum_thread = ForumThread.new
    authorize! :create, @forum_thread
    if @forum_thread.update(forum_thread_params)
      flash[:notice] = "Successfully created forum thread!"
      redirect_to forum_thread_path(@forum_thread)
    else
      flash[:alert] = "Error creating new forum thread!"
      render :new
    end
  end

  def show
  end

  def index
  end

  def destroy
    authorize! :destory, @forum_thread
    if @forum_thread.destroy
      flash[:notice] = "Successfully deleted forum thread!"
      redirect_to forum_categories_path
    else
      flash[:alert] = "Error updating forum thread!"
    end
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :description)
  end

  def find_forum_thread
    @forum_thread = ForumThread.find(params[:id])
  end
end
