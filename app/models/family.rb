class Family < ActiveRecord::Base
  include SummaryMgr, CodeGen, Obscure

  belongs_to :cabin, optional: true
  has_many :members, class_name: "People"
  has_many :payments
  has_one :vaccine

  def bread_winner
    adult = People.where(family_id: id, grade: 'Adult').first

    if adult.nil?
      adult = People.where(family_id: id).first
    end

    adult
  end

  def vaccines_complete?
    if !vaccine.nil? && vaccine.complete?
      return true
    end

    false
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
        amount = 100
      when 2
        amount = 145
      when 3
        amount = 100
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
        'Weekend 1 May 17 - May 19'
      when 2
        'Weekend 2 May 24 - May 27'
      when 3
        'Weekend 3 May 31 - Jun 2'
      else
        "Wait List"
    end
  end
end
