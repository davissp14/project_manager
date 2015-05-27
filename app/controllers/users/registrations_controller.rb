class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def new
   # Override Devise default behaviour and create a profile as well
    build_resource({})
    resource.build_account
    respond_with self.resource
  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :account_attributes => :name)
    end
  end

end