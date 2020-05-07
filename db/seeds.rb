# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

courses = Course.create!(
  [
    {name: 'Курс по Go', description: 'Супер дупер курс по Го'},
    {name: 'Курс по Ruby', description: 'Курс по лучшему на свете языку'},
    {name: 'Курс по Closure', description: '((языку (с особыми потребостями (по)(курс))))'},
    {name: 'Курс по основам уголовного права' , description: 'это важно знать каждому'}
  ]
)

courses.each.with_index do |c, i|
  Group.create!(start_date: Date.tomorrow + i.send(:day), course: c)
end

%w(one@mail.ru two@mail.ru three@mail.ru).each do |email|
  User.create!(email: email)
end
