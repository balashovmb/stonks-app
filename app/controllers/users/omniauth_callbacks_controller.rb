class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_request
  def google_oauth2
    p 'google_oauth2'
    p request.env['omniauth.auth']

      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.present?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end

  def okta
    p 'okta'
    p request.env['omniauth.auth']
  end



  def passthru
    p '11111111111111111'
  end
end