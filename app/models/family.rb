class Family < ActiveRecord::Base
  include SummaryMgr, CodeGen, Obscure

  belongs_to :cabin, optional: true
  has_many :members, class_name: "People"
  has_many :payments

  validates :email, presence: {message: " is required"}

  def bread_winner
    adult = People.where(family_id: id, grade: 'Adult').first

    if adult.nil?
      adult = People.where(family_id: id).first
    end

    adult
  end

  def waivers_complete?
    members.each do |person|
      if person.waiver.nil? || !person.waiver.complete?
        return false
      end
    end

    true
  end

  def diet_and_allergy_complete?
    members.each do |person|
      unless person.diet_and_allergy_complete?
        return false
      end
    end

    true
  end

  def total_paid
    Payment.where(family_id: id).sum(:amount)
  end

  def amount_due
    weekend_total - total_paid
  end

  def amount_per_person
    case week
      when 1
        amount = 125
      when 2
        amount = 170
      when 3
        amount = 125
      else
        amount = 0
    end
  end

  def weekend_total
    amount = amount_per_person
    amount * People.where(family_id: id).count
  end

  def week_desc
    case week
      when 1
        'Weekend 1 May 19 - May 21'
      when 2
        'Weekend 2 May 26 - May 29'
      when 3
        'Weekend 3 Jun 2 - Jun 4'
      else
        "Wait List"
    end
  end
end
