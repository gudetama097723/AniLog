class Admin::BaseController < ApplicationController
  allow_unauthenticated_access

  before_action :require_admin_login

  private

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  def require_admin_login
    unless current_admin
      redirect_to admin_sign_in_path, alert: "管理者としてログインしてください"
    end
  end
end
