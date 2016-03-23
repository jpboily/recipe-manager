class UsersController < ApplicationController
  # TODO : Restrict page access to super admin
  def new
    @user = User.new
  end

  def login

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome to Recipe Manager, #{@user.name}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
     def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
     end
end
