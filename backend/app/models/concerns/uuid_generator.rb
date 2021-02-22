# frozen_string_literal: true

module UuidGenerator
  extend ActiveSupport::Concern

  included do
    after_initialize :generate_uuid

    validates :uuid, presence: true, uniqueness: true
  end

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
