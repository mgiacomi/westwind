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
          deposit_paid: deposit_paid(families, people, payments),
          paid_full: paid_full(families, people, payments),
          dietary: dietary(families, people),
          waivers: waivers(families, people),
          volunteers: volunteers(people),
          dietary_restrictions: dietary_restrictions(people),
      }
    end

    def registered families
      week1 = families.select do |f|
        f.week == 1
      end
      week2 = families.select do |f|
        f.week == 2
      end
      week3 = families.select do |f|
        f.week == 3
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def total_people families, people
      week1 = people.select do |p|
        f = families.select do |f|
          p.family_id == f.id
        end
        f[0].week == 1
      end
      week2 = people.select do |p|
        f = families.select do |f|
          p.family_id == f.id
        end
        f[0].week == 2
      end
      week3 = people.select do |p|
        f = families.select do |f|
          p.family_id == f.id
        end
        f[0].week == 3
      end

      total = week1.length + week2.length + week3.length
      {week1: week1, week2: week2, week3: week3, total: total}
    end

    def onk_members families
      week1y = families.select do |f|
        f.week == 1  && f.onk_member
      end
      week2y = families.select do |f|
        f.week == 2  && f.onk_member
      end
      week3y = families.select do |f|
        f.week == 3  && f.onk_member
      end

      week1n = families.select do |f|
        f.week == 1  && !f.onk_member
      end
      week2n = families.select do |f|
        f.week == 2  && !f.onk_member
      end
      week3n = families.select do |f|
        f.week == 3  && !f.onk_member
      end

      totaly = week1y.length + week2y.length + week3y.length
      totaln = week1n.length + week2n.length + week3n.length
      {week1y: week1y, week2y: week2y, week3y: week3y, totaly: totaly,
       week1n: week1n, week2n: week2n, week3n: week3n, totaln: totaln}
    end

    def deposit_paid families, people, payments
      week1y = Array.new
      week2y = Array.new
      week3y = Array.new
      week1n = Array.new
      week2n = Array.new
      week3n = Array.new

      families.each do |family|
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

        if pmt_total > 99 || pmt_total >= total_due
          if family.week == 1
            week1y << family
          end
          if family.week == 2
            week2y << family
          end
          if family.week == 3
            week3y << family
          end
        else
          if family.week == 1
            week1n << family
          end
          if family.week == 2
            week2n << family
          end
          if family.week == 3
            week3n << family
          end
        end
      end

      totaly = week1y.length + week2y.length + week3y.length
      totaln = week1n.length + week2n.length + week3n.length
      {week1y: week1y, week2y: week2y, week3y: week3y, totaly: totaly,
       week1n: week1n, week2n: week2n, week3n: week3n, totaln: totaln}
    end

    def paid_full families, people, payments
      week1y = Array.new
      week2y = Array.new
      week3y = Array.new
      week1n = Array.new
      week2n = Array.new
      week3n = Array.new

      families.each do |family|
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
            week1y << family
          end
          if family.week == 2
            week2y << family
          end
          if family.week == 3
            week3y << family
          end
        else
          if family.week == 1
            week1n << family
          end
          if family.week == 2
            week2n << family
          end
          if family.week == 3
            week3n << family
          end
        end
      end

      totaly = week1y.length + week2y.length + week3y.length
      totaln = week1n.length + week2n.length + week3n.length
      {week1y: week1y, week2y: week2y, week3y: week3y, totaly: totaly,
       week1n: week1n, week2n: week2n, week3n: week3n, totaln: totaln}
    end

    def dietary families, people
      week1y = Array.new
      week2y = Array.new
      week3y = Array.new
      week1n = Array.new
      week2n = Array.new
      week3n = Array.new

      families.each do |family|
        f_people = people.select do |p|
          p.family_id == family.id
        end

        dietary_missing = f_people.select do |p|
          !p.diet_and_allergy_complete?
        end

        if dietary_missing.nil? || dietary_missing.length == 0
          if family.week == 1
            week1n << family
          end
          if family.week == 2
            week2n << family
          end
          if family.week == 3
            week3n << family
          end
        else
          if family.week == 1
            week1y << family
          end
          if family.week == 2
            week2y << family
          end
          if family.week == 3
            week3y << family
          end
        end
      end

      totaly = week1y.length + week2y.length + week3y.length
      totaln = week1n.length + week2n.length + week3n.length
      {week1y: week1y, week2y: week2y, week3y: week3y, totaly: totaly,
       week1n: week1n, week2n: week2n, week3n: week3n, totaln: totaln}
    end

    def waivers families, people
      week1y = Array.new
      week2y = Array.new
      week3y = Array.new
      week1n = Array.new
      week2n = Array.new
      week3n = Array.new

      families.each do |family|
        f_people = people.select do |p|
          p.family_id == family.id
        end

        waiver_missing = f_people.select do |p|
          p.waiver.nil? || !p.waiver.complete?
        end

        if waiver_missing.nil? || waiver_missing.length == 0
          if family.week == 1
            week1n << family
          end
          if family.week == 2
            week2n << family
          end
          if family.week == 3
            week3n << family
          end
        else
          if family.week == 1
            week1y << family
          end
          if family.week == 2
            week2y << family
          end
          if family.week == 3
            week3y << family
          end
        end
      end

      totaly = week1y.length + week2y.length + week3y.length
      totaln = week1n.length + week2n.length + week3n.length
      {week1y: week1y, week2y: week2y, week3y: week3y, totaly: totaly,
       week1n: week1n, week2n: week2n, week3n: week3n, totaln: totaln}
    end

    def volunteers people
      week1 = Array.new
      week2 = Array.new
      week3 = Array.new

      people.each do |person|

        if person.volunteer?
          if person.family.week == 1
            week1 << person
          end
          if person.family.week == 2
            week2 << person
          end
          if person.family.week == 3
            week3 << person
          end
        end
      end

      {week1: week1, week2: week2, week3: week3}
    end

    def dietary_restrictions people
      week1 = Array.new
      week2 = Array.new
      week3 = Array.new

      people.each do |person|

        if person.dietary_restrictions?
          if person.family.week == 1
            week1 << person
          end
          if person.family.week == 2
            week2 << person
          end
          if person.family.week == 3
            week3 << person
          end
        end
      end

      {week1: week1, week2: week2, week3: week3}
    end

  end
end