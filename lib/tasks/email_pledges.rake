desc "Email Pledges"
task :email_pledges => :environment do

  Pledge.where("email_sent_date is null and ptype = 'hourly'").limit(10).each do |pledge|
    GeneralMailer.pledge_payment(pledge).deliver
    p "Sending pledge to #{pledge.email} #{pledge.ptype}"
  end

end