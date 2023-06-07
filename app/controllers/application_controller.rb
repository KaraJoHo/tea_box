class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionController::ParameterMissing, with: :missing_parameter_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_reponse

  def render_not_found_response(exception)
    render json: ErrorSerializer.new(exception).bad_request, status: 404
  end

  def missing_parameter_response(exception)
    render json: ErrorSerializer.new(exception).bad_request, status: 400
  end

  def invalid_reponse(exception)
    render json: ErrorSerializer.new(exception).bad_request, status: 404
  end
end
