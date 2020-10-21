class UsersController < ApplicationController
  before_action :set_user_params, only: [:show, :edit, :update]

  private
  
  def set_user_params
    @user = User.find(params[:id])
  end

end
