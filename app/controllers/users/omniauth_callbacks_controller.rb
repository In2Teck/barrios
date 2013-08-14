class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
		@user = User.find_for_facebook_oauth(auth_hash, current_user)
		if @user.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
			#sign_in_and_redirect @user, :event => :authentication
      sign_in @user
      redirect_to :hood_select
		else
			session["devise.facebook_data"] = auth_hash.except("extra")
			redirect_to signup_url(@user)
		end
	end

  def twitter
		@user = User.find_for_twitter_oauth(auth_hash, current_user)
    logger.info @user.to_yaml
    # REDIRECT A HOMEPAGE DE USUARIO
    redirect_to :profile
	end

	def auth_hash
		request.env["omniauth.auth"]
	end
end
