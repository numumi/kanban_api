module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :handle_record_not_unique
    rescue_from ActiveModel::ForbiddenAttributesError, with: :handle_forbidden_attributes
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from ActiveRecord::NotNullViolation, with: :handle_not_null_violation
    rescue_from ActiveRecord::RecordNotSaved, with: :handle_record_not_saved
    rescue_from ActiveRecord::StatementInvalid, with: :handle_statement_invalid
  end

  private

  def handle_internal_server(exception)
    log_error(exception, :error)
    render json: { error: 'Internal server error', message: exception.message }, status: :internal_server_error
  end

  def handle_record_not_found(exception)
    log_error(exception, :warn)
    render json: { error: 'Record not found', message: exception.message }, status: :not_found
  end

  def handle_record_invalid(exception)
    log_error(exception, :warn)
    render json: { error: 'Record invalid', message: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def handle_record_not_unique(exception)
    log_error(exception, :warn)
    render json: { error: 'Record not unique', message: exception.message }, status: :conflict
  end

  def handle_forbidden_attributes(exception)
    log_error(exception, :error)
    render json: { error: 'Forbidden attributes', message: exception.message }, status: :bad_request
  end

  def handle_parameter_missing(exception)
    log_error(exception, :info)
    render json: { error: 'Parameter missing', message: exception.message }, status: :bad_request
  end

  def handle_not_null_violation(exception)
    log_error(exception, :error)
    render json: { error: 'Not null violation', message: exception.message }, status: :unprocessable_entity
  end

  def handle_record_not_saved(exception)
    log_error(exception, :warn)
    render json: { error: 'Record not saved', message: exception.message }, status: :unprocessable_entity
  end

  def handle_statement_invalid(exception)
    log_error(exception, :error)
    render json: { error: 'Statement invalid', message: exception.message }, status: :bad_request
  end

  def log_error(exception, level = :error)
    case level
    when :error
      logger.error "エラー発生: #{exception.class.name} : #{exception.message}"
    when :warn
      logger.warn "警告: #{exception.class.name} : #{exception.message}"
    when :info
      logger.info "情報: #{exception.class.name} : #{exception.message}"
    end
    logger.error exception.backtrace.join("\n") if level == :error && exception.backtrace
  end
end
