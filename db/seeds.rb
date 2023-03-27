# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts "Destroying previous seeds..."

# Destroy all the previous data
AmplifierConversation.destroy_all
Message.destroy_all
Attachment.destroy_all
Amplifier.destroy_all
AmplifierType.destroy_all
User.destroy_all

puts "Seeding the database..."


k12_descriptions = [
  "This amplifier helps students learn how to add and subtract fractions.",
  "Students will explore ancient civilizations with this amplifier.",
  "This amplifier introduces students to the basics of physics.",
  "In this amplifier, students will learn how to write persuasive essays.",
  "Students will develop their reading comprehension skills with this amplifier.",
  "This amplifier teaches students how to solve quadratic equations.",
  "In this amplifier, students will study the works of Shakespeare.",
  "Students will explore the properties of matter in this amplifier.",
  "This amplifier teaches students how to create and interpret graphs.",
  "In this amplifier, students will learn about different types of poetry."
]

# Create the user
User.create!(email: 'admin@admin.com', password: 'password')

# Create 5 amplifier types
["Mathematics", "Science", "Social Studies", "English Language Arts", "Physical Education"].each do |title|
  AmplifierType.create!(title: title)
end

AmplifierType.create!(title: "Unassigned")

# Create 10 amplifiers assigned to the user
20.times do
  Amplifier.create!(
    user: User.first,
    title: Faker::Lorem.sentence,
    description: k12_descriptions.sample,
    start_at: Time.current,
    state: Amplifier.states.keys.sample,
    amplifier_type: AmplifierType.all.sample
  )
end

puts "Seeding done!"
