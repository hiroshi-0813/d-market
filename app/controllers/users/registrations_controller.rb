class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @user = User.new
  end


  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    session["devise.regist_data"][:user]["password_confirmation"] = params[:user][:password_confirmation]
    @address = @user.build_address
    render :new_address
  end


  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    if @user.save
      sign_in(:user, @user)
    else
      flash.now[:alert] = '登録に失敗しました。'
      redirect_to "/" and return
  end
end


  protected


  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :phone_number, :gender, :birth_date])
  end

  def address_params
    params.require(:address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :city, :local, :block, :building, :phone_number)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
