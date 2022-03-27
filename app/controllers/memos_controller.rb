class MemosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]  

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = 'メモを投稿しました。'
      redirect_to user_url(id: session[:user_id])
    else
      @pagy, @memos = pagy(current_user.memos.order(id: :desc))
      flash.now[:danger] = 'メモの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @memo = 
    @memo.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end
  
  def correct_user
    @memo = current_user.memos.find_by(id: params[:id])
    unless @memo
      redirect_to root_url
    end
  end
end