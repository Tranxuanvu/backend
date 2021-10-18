# User
User.create(name: 'Admin', email: 'admin@oivan.com', password: '123123', password_confirmation: '123123')

# Technologies
['Ruby', 'Angular', 'Rails', 'NodeJS'].each do |tech_name|
  Technology.create(name: tech_name)
end
