# frozen_string_literal: true

module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def error_response(error, status = :unprocessable_entity)
    error_object = {
      error_code: error.code,
      error_message: error.message
    }
    render json: error_object, status: status
  end
end
