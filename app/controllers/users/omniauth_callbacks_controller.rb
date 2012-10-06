class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    Rails.logger.info request.env["omniauth.auth"].inspect
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if current_user
      session[:fb_access_token] = request.env["omniauth.auth"]["credentials"]["token"]
      begin
        redirect_to :back
      rescue RedirectBackError
        redirect_to root_url
      end
      return
    end

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      session[:fb_access_token] = request.env["omniauth.auth"]["credentials"]["token"]
      sign_in @user, :event => :authentication
      begin
        redirect_to :back
      rescue RedirectBackError
        redirect_to root_url
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    # raise ActionController::RoutingError.new('Not Found')
  end
end
