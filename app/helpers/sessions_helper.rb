module SessionsHelper
  def current_user
    #セッションidを保持している。@current_userが真の場合はそのままにし、偽の場合は右辺の値 User.find_by(id: session[:user_id]) を代入するというものです。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
