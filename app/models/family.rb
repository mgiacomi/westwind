class Family < ActiveRecord::Base
  include CodeGen, Obscure

  has_many :people
  has_many :payments

  def bread_winner
    People.where(family_id: id, grade: 'Adult').first
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
        amount = 105
      when 2
        amount = 70
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
        puts "Wait List"
    end
  end
end
