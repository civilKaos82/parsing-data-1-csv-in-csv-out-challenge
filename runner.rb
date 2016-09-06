require_relative 'person'
require_relative 'person_parser'

# Parse the data in the csv file into ruby objects
people = PersonParser.parse('people.csv')


# Get people with phone numbers in a certain area code
puts "The following people have phone numbers from area code 419."

people_with_area_code_419 = people.select { |person| person.area_code?("419") }
people_with_area_code_419.each { |person| puts person.full_name }
