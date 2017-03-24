class Family < ActiveRecord::Base
  include CodeGen, Obscure

  has_many :people
  has_many :payments

  def bread_winner
    People.where(family_id: id, grade: 'Adult').first
  end

  def diet_and_allergy_complete?
    People.where(family_id: id).each do |person|
      if !person.vegetarian? && !person.vegan? && !person.pescetarian? && !person.gluten_free? && !person.lactose_free? && !person.no_dietary_issues?
        return false
      end
      if !person.no_allergies? && person.allergies.blank?
        puts "before"
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

  def weekend_total
    case week
      when 1
        amount = 70
      when 2
        amount = 105
      when 3
        amount = 70
      else
        amount = 0
    end

    amount * People.where(family_id: id).count
  end

  def week_desc
    case week
      when 1
        'Weekend 1 May 19 - May 21'
      when 2
        'Weekend 2 May 26 - May 29'
      when 3
        'Weekend 3 June 2 - Jun 4'
      else
        "Wait List"
    end
  end
end
