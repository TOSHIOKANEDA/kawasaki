module CommonActions
  extend ActiveSupport::Concern

  def authorized_user
    if user_signed_in?
      redirect_to destroy_user_session_path unless current_user.authority ==  9
    else
      redirect_to destroy_user_session_path
    end
  end

end