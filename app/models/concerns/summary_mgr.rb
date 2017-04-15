module SummaryMgr
  extend ActiveSupport::Concern

  module ClassMethods
    def get_summary
      families = Family.all
      people = People.all
      payments = Payment.all

      {
          registered: registered(families),
          people: total_people(families, people),
          onk_members: onk_members(families),
          not_onk_members: not_onk_members(families),
          deposit_paid: deposit_paid(families, payments),
          deposit_unpaid: deposit_unpaid(families, payments),
          paid_full: paid_full(families, people, payments),
          not_paid_full: not_paid_full(families, people, payments),
          #dietary: not_paid_full(people),
          #waivers: not_paid_full(people),
      }
    end

    def registered famalies
      week1 = famalies.select do |f|
        f.week == 1
      end
      week2 = famalies.select do |f|
        f.week == 2
      end
      week3 = famalies.select do |f|
        f.week == 3
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def total_people famalies, people
      week1 = people.select do |p|
        f = famalies.select do |f|
          p.family_id == f.id
        end
        f[0].week == 1
      end
      week2 = people.select do |p|
        f = famalies.select do |f|
          p.family_id == f.id
        end
        f[0].week == 2
      end
      week3 = people.select do |p|
        f = famalies.select do |f|
          p.family_id == f.id
        end
        f[0].week == 3
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def onk_members famalies
      week1 = famalies.select do |f|
        f.week == 1  && f.onk_member
      end
      week2 = famalies.select do |f|
        f.week == 2  && f.onk_member
      end
      week3 = famalies.select do |f|
        f.week == 3  && f.onk_member
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def not_onk_members famalies
      week1 = famalies.select do |f|
        f.week == 1  && !f.onk_member
      end
      week2 = famalies.select do |f|
        f.week == 2  && !f.onk_member
      end
      week3 = famalies.select do |f|
        f.week == 3  && !f.onk_member
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def deposit_paid famalies, payments
      week1 = Array.new
      week2 = Array.new
      week3 = Array.new

      famalies.each do |family|
        f_pmts = payments.select do |p|
          p.family_id == family.id
        end

        pmt_total = f_pmts.map{|p| p.amount }.reduce {|sum, n| sum + n}
        pmt_total = pmt_total.nil? ? 0 : pmt_total

        if pmt_total > 99
          if family.week == 1
            week1 << family
          end
          if family.week == 2
            week2 << family
          end
          if family.week == 3
            week3 << family
          end
        end
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def deposit_unpaid famalies, payments
      week1 = Array.new
      week2 = Array.new
      week3 = Array.new

      famalies.each do |family|
        f_pmts = payments.select do |p|
          p.family_id == family.id
        end

        pmt_total = f_pmts.map{|p| p.amount }.reduce {|sum, n| sum + n}
        pmt_total = pmt_total.nil? ? 0 : pmt_total

        if pmt_total < 100
          if family.week == 1
            week1 << family
          end
          if family.week == 2
            week2 << family
          end
          if family.week == 3
            week3 << family
          end
        end
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def paid_full famalies, people, payments
      week1 = Array.new
      week2 = Array.new
      week3 = Array.new

      famalies.each do |family|
        f_pmts = payments.select do |p|
          p.family_id == family.id
        end

        f_people = people.select do |p|
          p.family_id == family.id
        end

        pmt_total = f_pmts.map{|p| p.amount }.reduce {|sum, n| sum + n}
        pmt_total = pmt_total.nil? ? 0 : pmt_total

        amt_per_person = family.amount_per_person
        total_due = amt_per_person * f_people.length

        if pmt_total >= total_due
          if family.week == 1
            week1 << family
          end
          if family.week == 2
            week2 << family
          end
          if family.week == 3
            week3 << family
          end
        end
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def not_paid_full famalies, people, payments
      week1 = Array.new
      week2 = Array.new
      week3 = Array.new

      famalies.each do |family|
        f_pmts = payments.select do |p|
          p.family_id == family.id
        end

        f_people = people.select do |p|
          p.family_id == family.id
        end

        pmt_total = f_pmts.map{|p| p.amount }.reduce {|sum, n| sum + n}
        pmt_total = pmt_total.nil? ? 0 : pmt_total

        amt_per_person = family.amount_per_person
        total_due = amt_per_person * f_people.length

        if pmt_total < total_due
          if family.week == 1
            week1 << family
          end
          if family.week == 2
            week2 << family
          end
          if family.week == 3
            week3 << family
          end
        end
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end
  end
end