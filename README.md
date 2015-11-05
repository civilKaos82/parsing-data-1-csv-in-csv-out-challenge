# Parsing Data: CSV to Ruby to CSV

## Summary
When we run our applications, Ruby objects are created that exist in our computer's memory.  These objects have state, or information, associated with them.  In-memory state is lost when our application ends, so if we want to save this state, we need to record it somewhere.

In addition to saving the state of our programs for ourselves, we sometimes want to share this information with other systems or programs.  To accomplish this, in addition to merely saving the data, we need to save it in a format that is both compatible with these other systems and easily transfered.

One common approach to saving state in an exchangeable format is to translate the information to text.  XML, JSON, CSV, and YAML are all examples of text-based data exchange formats.

In this challenge, we'll use [CSV][wikipedia csv] as our format for storing data.  We'll be representing people in Ruby as instances of the class `Person`.  We'll both build `Person` objects from data in a CSV file and also save the state of Ruby `Person` objects in a CSV file.


### Ruby's CSV Library
Ruby provides a library for working with CSV files (see [Ruby docs][ruby docs csv]).  It is part of Ruby's Standard Library, so we always have access to it.  However, as it's not part of Ruby's Core, it's not automatically loaded for us when our programs run.  We need to explicitly require it (see the top of the file `person_parser.rb`).

We'll use this CSV library to both read and write CSV files.  Take time to read through the Ruby docs on the class.  Also, the blog post *[Parsing CSV with Ruby][technical pickles csv]* might prove helpful in understanding some of the options that we can specify when reading a CSV file (e.g., specifying that the CSV file contains a row of headers).


### Lazy Initialization and Memoization
Reading and writing CSV—or another format—can be a resource-intensive operation. The file with which we'll be working contains just a couple hundred lines, so it can be read quickly.  But, imagine if it contained a couple hundred thousand lines.  Then we might notice a performance problem as reading the file could really slow down our program.

There are strategies to mitigate the costs of expensive operations like reading in a file.  Two of these are exhibited in the `PersonParser` class.

One of these strategies is *[lazy initialization][wikipedia lazy initialization]*.  With this strategy, we delay executing the costly operation until we absolutely need to. The `PersonParser` class is set up so that when we create a new instance of the class, we specify in which CSV file the data can be found.  But, we don't parse the file until we call the `#person` method, which returns a collection of `Person` objects based on the data in the file.

The other strategy used is *[memoization][wikipedia memoization]*.  In this strategy we limit the number of times that we run an expensive operation by caching the result of the operation.  In the `PersonParser` class, the first time we call the `#people` method, we parse the file and store the result of the parsing in an instance variable.  Subsequent calls to the `#people` method return the value of the instance variable.


## Releases
### Release 0: Represent People as Ruby Objects
We'll begin by creating a `Person` class; in our Ruby program, each instance of this class will represent a person.  Our person class should be designed to represent the data found in the file `people.csv`.  In other words, an instance our our `Person` class should have an id, a first name, a last name, etc.

We'll need to write tests for our class.  What behaviors does our `Person` class need?  Let's be sure that we can ask an instance of the class for each of its attributes:  id, first_name, etc.


### Release 1: Parsing from CSV to Ruby
We now have a Ruby object that can hold the information contained in the `people.csv` file.  So, now we're going to actually build some `Person` objects based on the data in the file.

We're presented with an unfinished `PersonParser` class.  One behavior that is missing is the parsing of a CSV file into `Person` objects.  Write out the method body for the private `#parse_people_objects_from_file` method.  This method should return an array of `Person` objects based on the data in the CSV file.  We won't call this method directly on the object, but it will be called from within the `#people` method.

We need to test the behavior of our `PersonParser` class.  Given an instance of the class, when we call `#people` what should be returned?


### Release 2: Appropriate Data Types in Ruby
In our CSV file everything is text.  That means everything comes into our Ruby application as strings.  Sometimes this is appropriate.  For example, names, phone numbers, and e-mail addresses are represented well as strings.  In other cases, it can be beneficial to convert the CSV text into objects other than strings.

In our case, the `people.csv` file has a `created_at` field.  In the CSV file this is just a conveniently-formatted string, but in Ruby we might want it to be an instance of the `DateTime` class.  Instead of storing the created at value as a string, use the [DateTime.parse method](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/date/rdoc/DateTime.html#method-c-parse) to parse the value in the CSV file into a `DateTime` object.

*Note:*  Like Ruby's CSV library, the `DateTime` class is not automatically loaded when our programs run.  We need to require it:  `require 'date'`.


### Release 3: Saving Ruby State to CSV
```ruby
jane = Person.new(...)
john = Person.new(...)

parser = PersonParser.new('friends.csv')
parser.save([jane, john])
```
*Figure 1*.  Creating people in ruby and saving their data to a CSV file.

We can now take CSV data and turn it into Ruby objects which we can use in our programs.  Now we're going to take Ruby objects and save their state to a CSV file.  To do this, we want to instantiate a `PeopleParser` with the name of the file to which we want to write.  We can create a collection of `People` objects and then give them to the parser to save to the file.  (see Figure 1)

*Note:* When we read and write to a file, we can choose a mode (like `"r"` for read and `"w"` for write).  The CSV modes are the same as the [modes available for File](http://ruby-doc.org/core-2.1.0/IO.html#method-c-new-label-IO+Open+Mode).


<!-- ##Optimize Your Learning  -->

##Resources

* [built-in CSV class](http://ruby-doc.org/stdlib-1.9.2/libdoc/csv/rdoc/CSV.html)

[ruby docs csv]: http://ruby-doc.org/stdlib-2.1.0/libdoc/csv/rdoc/CSV.html
[technical pickles csv]: http://technicalpickles.com/posts/parsing-csv-with-ruby/
[wikipedia csv]: https://en.wikipedia.org/wiki/Comma-separated_values
[wikipedia lazy initialization]: https://en.wikipedia.org/wiki/Lazy_initialization
[wikipedia memoization]: https://en.wikipedia.org/wiki/Memoization
