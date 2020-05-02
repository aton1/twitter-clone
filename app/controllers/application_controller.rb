class ApplicationController < ActionController::Base
  private

  def after_sign_out_path_for(resource_of_scope)
    new_user_session_path
  end
end
