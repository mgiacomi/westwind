module Obscure
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def unobscure_id id
      Base64.urlsafe_decode64(id)
    end
  end

  def obscure_id
    padded_id = self.id.to_s
    Base64.urlsafe_encode64(padded_id)
  end

end