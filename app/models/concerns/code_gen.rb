module CodeGen
  extend ActiveSupport::Concern

  included do
    before_create :gen_code
  end

  module ClassMethods
  end

  private

  def gen_code
    self.code = SecureRandom.urlsafe_base64(5)
  end

end