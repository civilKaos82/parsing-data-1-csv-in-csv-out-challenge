require 'csv'

class Person
  # Look at the above CSV file
  # What attributes should a Person object have?
end

class PersonParser
  attr_reader :file
  
  def initialize(file)
    @file = file
    @people = nil
  end
  
  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people
    
    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
  end
end

parser = PersonParser.new('people.csv')

puts "There are #{parser.people.size} people in the file '#{parser.file}'."