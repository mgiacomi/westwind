# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cabin.create :name => "McIver Bunks (4x4)"
Cabin.create :name => "McIver Open Area"
Cabin.create :name => "Trillium (2)"
Cabin.create :name => "Roost (5)"
Cabin.create :name => "Wy'East (4)"
Cabin.create :name => "Neskowin (2)"
Cabin.create :name => "Robin Hood (9)"
Cabin.create :name => "Maid Marion (9)"
Cabin.create :name => "Nottingham (9)"
Cabin.create :name => "Alan-A-Dale (9)"
Cabin.create :name => "Aunt Vi's (14)"
Cabin.create :name => "Hidel (9)"
Cabin.create :name => "Tam'O Shanter (9)"
Cabin.create :name => "Bagpiper (9)"
Cabin.create :name => "Kilties (9)"
Cabin.create :name => "Thistledown (9)"
Cabin.create :name => "Klickitat (9)"
Cabin.create :name => "Tyee (9)"
Cabin.create :name => "Uncle Bliss (9)"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'mgiacomi@gltech.com', password: password, admin: 1)
puts "Created Admin: #{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'tricia.waineo@oyanokai.org', password: password, admin: 1)
puts "Created Admin: #{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'paul.nist@gmail.com', password: password, admin: 1)
puts "Created Admin: #{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'chiang_h@yahoo.com', password: password, admin: 1)
puts "Created Admin: #{user.email} #{password}"
