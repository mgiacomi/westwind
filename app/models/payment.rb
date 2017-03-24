class Payment < ActiveRecord::Base

  belongs_to :family

  validates :amount, :pmtdate, :pmttype, presence: {message: " is required"}
  validates :amount, numericality: true
  #validate :validate_pmt_date

  default_scope { order('pmtdate desc') }

  class << self
  end

  private

  #def validate_pmt_date
  #  DateTime.strptime(pmtdate.to_s, '%m/%d/%Y') rescue errors.add(:pmtdate, "must be a date (mm/dd/yy)")
  #end

end
