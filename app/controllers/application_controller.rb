class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json, :xml

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActionController::ParameterMissing, with: :parameters_missing

  private
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      flash[:error] = I18n.t "pundit.#{policy_name}.#{exception.query}",
        default: 'You cannot perform this action.'
      redirect_to_last_visited_path
    end

    def parameters_missing(exception)
      flash[:error] = I18n.t "parameter_missing",
        default: 'There is a parameter missing.',
        param: exception.param
      redirect_to_last_visited_path
    end

    def redirect_to_last_visited_path
      redirect_to(request.referrer || root_path)
    end
end
