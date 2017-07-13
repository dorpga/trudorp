class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]

  def show
    @user = User.where(username: params[:id]).first
  end

  def destroy
    authorize! :destory, @user
    if @user.destroy
      flash[:notice] = "Successfully deleted user!"
      redirect_to '/'
    else
      flash[:alert] = "Error updating user!"
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
