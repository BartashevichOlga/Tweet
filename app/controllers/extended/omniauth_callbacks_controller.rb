module Extended
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      user = User.find_for_twitter_oauth(request.env['omniauth.auth'])
      if user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success'
        sign_in_and_redirect(user, event: :authentication)
      else
        redirect_to root_path notice: 'authentication error'
      end
    end
  end
end
