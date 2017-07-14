class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def show
    authorize! :show, @user
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user

    params['user']['_roles'] ||= []

    @user.roles = []
    
    params['user']['_roles'].each do |role|
      @user.add_role role unless @user.has_role? role
    end

    if @user.update_without_password(user_params)
      flash[:notice] = "Successfully updated user!"
      redirect_to user_path(@user)
    else
      throw 'e'
      flash[:alert] = "Error updating user!"
      render :edit
    end
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

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def find_user
    @roles = [
      :admin,
      :moderator,
      :newuser
    ]
    if params[:id].is_a? String
      @user = User.where(username: params[:id]).first
    else
      @user = User.find(params[:id])
    end
  end
end
