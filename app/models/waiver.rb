class Waiver < ActiveRecord::Base

  belongs_to :person

  validates :relationship, :first, :last, :understand, :signature, :email, :phone, presence: {message: " is required"}
  validates :understand, acceptance: { accept: 'Yes, I fully understand and accept this waiver.' }

  def complete?
    if signature.blank? || relationship.blank? || email.blank? || phone.blank?
      return false
    end

    true
  end

  class << self
  end

end
