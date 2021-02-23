# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      Rails.logger.error(e.message)
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      Rails.logger.error(e.message)
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end
