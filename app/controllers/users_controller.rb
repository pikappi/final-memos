class UsersController < ApplicationController
  def show
    if logged_in?
      @memo = current_user.memos.build  # form_with 用
      @pagy, @memos = pagy(current_user.memos.order(id: :desc))
    else
      redirect_to root_url
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
