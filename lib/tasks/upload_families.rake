desc "Upload Families"
task :upload_families => :environment do

  ['ww_week1.csv', 'ww_week2.csv', 'ww_week3.csv', 'ww_waitlist.csv'].each do |filename|

    puts "Running File: #{filename}"
    csv = CSV.read(filename)

    case filename
      when 'ww_week1.csv'
        week = 1
      when 'ww_week2.csv'
        week = 2
      when 'ww_week3.csv'
        week = 3
      else
        week = 0
    end

    csv.each do |row|
      week1 = row[2].nil? ? nil : row[2].split[1]
      week2 = row[3].nil? ? nil : row[3].split[1]
      week3 = row[4].nil? ? nil : row[4].split[1]
      registered = row[1].nil? ? nil : Date.strptime(row[1], "%m/%d/%Y")

      print week
      family = Family.create(lottery:row[0], created_at: registered, name: row[8], phone: row[10], email: row[11], adults: row[6], kids: row[7], week: week, week1: week1, week2: week2, week3: week3)

      People.create(family_id: family.id, first: row[9], last: row[8], grade: 'Adult')
      print "a"

      unless row[12].nil?
        adult2 = row[12].split(",")
        first = adult2[1].nil? ? nil : adult2[1].strip
        People.create(family_id: family.id, first: first, last: adult2[0].strip, grade: 'Adult')
        print "a"
      end

      col = 13

      5.times do
        unless row[col].nil?
          kid = row[col].split(",")
          first = kid[1].nil? ? nil : kid[1].strip
          People.create(family_id: family.id, first: first, last: kid[0].strip, grade: row[(col +2)])
          print "k"
        end

        col +=  3
      end

    end
    puts "complete"
  end

end