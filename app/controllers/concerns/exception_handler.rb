module ExceptionHandler
  extend ActiveSupport::Concern
  include Error
  include Response

  CUSTOM_MESSAGE = {
    not_found: 'Record not found.',
    unauthorized: 'Unauthorized.',
    internal_server_error: 'Something went wrong!'
  }.freeze

  included do
    rescue_from StandardError, with: :handle_internal_server_error
    rescue_from AuthenticationError, with: :handle_unauthorized
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActionController::ParameterMissing, with: :handle_strong_parameters
  end

  private

  def log_exception(error)
    Rails.logger.error(error.message)
    Rails.logger.error(error.backtrace.join("\r\n"))
  end

  %i[internal_server_error unauthorized not_found].each do |status|
    define_method("handle_#{status}") do |error|
      log_exception(error)

      render_json(
        success: false,
        message: CUSTOM_MESSAGE[status]
      )
    end
  end

  def handle_strong_parameters(error)
    log_exception(error)

    render_json(
      success: false,
      message: error.message
    )
  end
end
