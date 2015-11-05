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






Create a `PersonParser` class that is initialized with the name of a CSV file.  Then use Ruby's [built-in CSV class](http://ruby-doc.org/stdlib-1.9.2/libdoc/csv/rdoc/CSV.html) to implement a `PersonParser#people` method that returns an `Array` of properly-parsed `Person`s, based on the data in the CSV file.  Say that three times fast.

*Note: CSV is a "built-in" class, but you still need to `require` it at the top of your program.*

###Release 1 : Manipulating in Ruby, Saving to CSV

Create a `PersonParser#add_person` method which takes a new `Person` instance as its input and appends that instance to the parser's internal `@people` array.

Next, create a `PersonParser#save` method which uses the CSV class to save the current state of the parser to a new CSV file.  For example

```ruby
parser = PersonParser.new('people.csv')

parser.add_person Person.new(...)

# This will now write to people.csv, but there will be
# one more row, corresponding to the extra Person you just added
parser.save
```
Note: When you read and write to a file, you can choose a format (like "r" for read and "w" for write).  The CSV formats are the same as the [file formats](http://ruby-doc.org/core-1.9.3/IO.html).

###Release 2 :Translating from CSV-land to Ruby-land

Because text-based data formats don't know anything about where your data is going to be used, there aren't easy ways to encode language-specific features into the format.  For example, the `people.csv` file has a `created_at` field.  In a CSV this is just a conveniently-formatted string, but in Ruby we might want it to be an instance of the `DateTime` class.

At the top of your Ruby program add the line

```ruby
require 'date'
```

Instead of storing `Person#created_at` as a `String`, use the [DateTime.parse method](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/DateTime.html#method-c-parse) to parse the `String` into an actual honest-to-goodness `DateTime` object.


<!-- ##Optimize Your Learning  -->

##Resources

* [built-in CSV class](http://ruby-doc.org/stdlib-1.9.2/libdoc/csv/rdoc/CSV.html)

[ruby docs csv]: http://ruby-doc.org/stdlib-2.1.0/libdoc/csv/rdoc/CSV.html
[technical pickles csv]: http://technicalpickles.com/posts/parsing-csv-with-ruby/
[wikipedia csv]: https://en.wikipedia.org/wiki/Comma-separated_values
[wikipedia lazy initialization]: https://en.wikipedia.org/wiki/Lazy_initialization
[wikipedia memoization]: https://en.wikipedia.org/wiki/Memoization
