class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :following, :followers]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome to the Sample app!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Successfully updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
  def following
    @following_users = @user.following_users
  end
  
  def followers
    @follower_users = @user.follower_users
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :location, :description, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
