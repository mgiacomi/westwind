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
      family = Family.create(lottery:row[0], created_at: registered, name: row[9], phone: row[10], email: row[11], adults: row[6], kids: row[7], week: week, week1: week1, week2: week2, week3: week3)
      People.create(family_id: family.id, first: row[8], last: row[9], grade: 'Adult')
      print "a"

      unless row[12].nil? && row[13].nil?
        first = row[12].nil? ? nil : row[12].strip
        last = row[13].nil? ? nil : row[13].strip
        People.create(family_id: family.id, first: first, last: last, grade: 'Adult')
        print "a"
      end

      col = 14

      5.times do
        unless row[col].nil?
          first = row[col].nil? ? nil : row[col].strip
          last = row[(col+1)].nil? ? nil : row[(col+1)].strip
          grade = row[(col+3)].nil? ? nil : row[(col+3)].strip
          People.create(family_id: family.id, first: first, last: last, grade: grade)
          print "k"
        end

        col += 4
      end

    end
    puts "complete"
  end

end