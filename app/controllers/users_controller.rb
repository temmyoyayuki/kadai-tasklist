class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = '登録が完了しました'
      redirect_to tasks_path
    else
      flash[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def new
    @user = User.new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
