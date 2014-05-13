class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.find_for_oauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :steam, :all
end