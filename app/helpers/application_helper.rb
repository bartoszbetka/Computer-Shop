module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'application/error_messages', :locals => {:object => object})
  end

  def logged_in?
    session[:user_id].present?
  end

  def admin?
    @user = User.find(session[:user_id]) if logged_in?
    @user.privilege.present? if logged_in?
  end

  def user
    @user = User.find(session[:user_id]) if logged_in?
  end

end
