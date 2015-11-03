require_relative 'person'
require_relative 'person_parser'

parser = PersonParser.new('people.csv')

puts "There are #{parser.people.size} people in the file '#{parser.file}'."
