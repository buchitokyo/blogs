class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      #signinしたら,login状態にさせる
      #session[:user_id] = @user.id
      redirect_to new_blog_path
    #保存した場合
    # redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    @favorite_blogs = @user.favorite_blogs
  end

  private

  def user_params
   params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
