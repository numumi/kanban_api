class ApplicationController < ActionController::API
  # include ErrorHandler
  include DefaultResponseFormat
  before_action :authorize_request_or_cache


  private

  def authorize_request
    authorize_request = AuthorizationService.new(request.headers)
    @current_user = authorize_request.current_user
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def authorize_request_or_cache
    authorize_request = AuthorizationService.new(request.headers)
    if authorize_request.cached_user
      @current_user = authorize_request.cached_user
    else
      authorize_request
    end
  end
end
