module DefaultResponseFormat
  extend ActiveSupport::Concern

  included do
    before_action :set_default_response_format
  end

  private

  def set_default_response_format
    request.format = :json
  end
end