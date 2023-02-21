class Api::V1::AccountsController < ApplicationController
  before_action :authenticate, only: [:create, :my_accounts]

  def create
    @account = Account.new(account_params)
    if @account.save
      render :show
    else
      render json: @account.errors, status: 400 and return
    end
  end

  def show
    begin
      @account = Account.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end

  def my_accounts
    @my_accounts = Account.where(user: @current_user)
  end

  private
  def account_params
    params.require(:account).permit(:payment_method_id, :active).merge(user: @current_user)
  end
end
