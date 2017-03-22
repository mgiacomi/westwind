module Obscure
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def unobscure_id id
      padded_id = Base64.urlsafe_decode64(id)
      padded_id[10..-1]
    end
  end

  def obscure_id
    padded_id = "#{rand.to_s[2..11]}#{self.id.to_s}"
    Base64.urlsafe_encode64(padded_id)
  end

end