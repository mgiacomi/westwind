module CodeGen
  extend ActiveSupport::Concern

  included do
    before_create :gen_code
    #after_create :gen_bitly
  end

  module ClassMethods
  end

  def gen_bitly
    pub_profile_url = Rails.application.routes.url_helpers.pub_profile_url(host: 'www.read4richmond.com', id: obscure_id)
    bitly_pub_profile_url = Bitly.client.shorten(pub_profile_url).short_url
    self.update_attributes(bitly_profile: bitly_pub_profile_url, bitly_pledge: bitly_pub_pledge_url)
  end

  private

  def gen_code
    self.code = SecureRandom.urlsafe_base64(5)
  end

end