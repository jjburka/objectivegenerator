# Populates the Database with 5 students

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Student].each(&:delete_all)

    Student.populate 5 do |student|
      student.name        = Faker::Name.name
      student.gpa         = 3.14
      student.enrolled    = Time.now - 2.weeks
      student.graduated   = Time.now + 4.years
      student.first_class = Time.now
      student.life_story  = Populator.paragraphs(3)
      student.greek       = true
    end
  end
end