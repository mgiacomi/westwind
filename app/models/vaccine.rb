class Vaccine < ActiveRecord::Base

  belongs_to :family

  validates :first, :last, :understand, :signature, :party, presence: {message: " is required"}
  validates :understand, acceptance: { accept: 'Yes, I fully understand and accept this Vaccine Attestation.' }

  def complete?
    if signature.blank?
      return false
    end

    true
  end

  class << self
  end

end
