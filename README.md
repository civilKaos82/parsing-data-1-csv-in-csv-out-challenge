# Parsing Data: CSV to Ruby to CSV

## Summary
In this challenge we'll begin to explore *[persistence][]*, which allows the *state* of our applications—their data—to live on after our applications are done running.  See, as a program runs, Ruby creates objects that exist only in our computer's memory.  And when the application ends, that in-memory data is lost.  To save the state of our applications, we need to store the data somewhere more permanent than the computer's memory.

For this challenge, we're going to use a text file as a data store.  We'll load data from a text file into a Ruby application.  We'll also write data from a Ruby application to a text file.

### Encoding Data as Text
There are a number of other commonly used formats for encoding data as text.  We'll be using [CSV][wikipedia csv] in this challenge.  Other examples are XML, JSON, and YAML.  Encoding data in one of these formats has some advantages.  First, these standard formats make our data easily transferable.  So, for example, our Ruby application can save data formatted as CSV and then a JavaScript application can load that CSV data.  Second, most languages provide libraries for reading and writing these formats.

### Ruby's CSV Library
Ruby provides a `CSV` library which we'll use to read from and write to CSV files (see [Ruby docs][ruby docs csv]).  `CSV` is not automatically loaded when Ruby starts.  We need to explicitly require it (see `person_parser.rb`).

In addition to learning about persistence and transferring data between formats, another goal of this challenge is to learn how to use a new library.  The `CSV` library will be unfamiliar to us.  But, we're going to learn how to use it.  How do we do that?  Reading documentation is a great starting point.  We can also experiment in IRB.  What else?  







## Releases
### Release 0: Represent People as Ruby Objects
We'll begin by creating a `Person` class; in our Ruby program, each instance of this class will represent a person.  Our person class should be designed to represent the data found in the file `people.csv`.  In other words, an instance of our `Person` class should have a first name, a last name, etc.

We'll need to write tests for our class.  What behaviors does our `Person` class need?  To start, let's ensure that we can ask an instance of the class for each of its attributes:  first name, last name, etc.


### Release 1: Parsing from CSV to Ruby
We now have a custom Ruby class designed to represent a person.  In order to build a `Person` object, we need to supply some data:  the first name, last name, etc.  It doesn't matter where that data comes from.  The data could be supplied through a user interface, it could exist on a webpage, anywhere.  In this challenge, the data comes from a CSV file.

We'll build a `PersonParser` module whose responsibility is to parse the text in a file into `Person` objects.  Write out the method body for the `.parse` method.  This method should convert each line in the file into a `Person` object and return those objects in an array.

We need to test the behavior of our `PersonParser` module.  Given a CSV file with specific data in it, when we tell our parser to parse that file, what do we expect to be returned?


### Release 2: Appropriate Data Types in Ruby
In our CSV file everything is text.  That means everything comes into our Ruby application as a string.  Sometimes this is appropriate.  Names, phone numbers, and e-mail addresses are represented well as strings.  In other cases, it can be beneficial to convert the CSV text into a different type of object.

In `people.csv` the date and time a person was born is saved in the `born_at` field.  In the CSV file this is a string formatted `YYYY-MM-DD HH:MM:SS`.  While this string does represent a date and time, Ruby provides classes like [DateTime][] specifically built for representing dates and times.  
 
When we create `Person` objects from our CSV file, ensure that their `born_at` attributes are `DateTime` objects, not strings. We might want to check out the [DateTime.parse][] method.

*Note:*  Like Ruby's CSV library, the `DateTime` class is not automatically loaded when our programs run.  We need to require it:  `require 'date'`.  


### Release 3: Working with the Ruby Objects
![runner animation](readme-assets/runner_animation.gif)  
*Figure 1*.  Filtering the ruby objects created from the CSV file.

One of the advantages of loading the data from the CSV file into Ruby objects is that it becomes easier for us to filter the collection of people or to manipulate their attributes.  For example, we could order the people by first name.  Or, we could update a person's phone number.

Read through `runner.rb`. We want our program to allow users to filter people using different commands: filtering people from a specific area code, with a specific last name, with an e-mail address from a specific domain, or born after a given year.  When we're done, the program should operate similar to the example in Figure 1.

Begin by completing the feature for searching for people by area code.  Run the program and follow the error messages (Hint:  we'll be adding to our `Person` class).  Once users can search for people by area code, implement the other three features:  searching by last name, by e-mail domain, and by birth year.  Then think up and add another feature of our own.


### Release 4: Saving Ruby State to CSV
```ruby
jane = Person.new(...)
john = Person.new(...)

PersonWriter.write('friends.csv', [jane, john])
```
*Figure 1*.  Creating people in ruby and saving their data to a CSV file.

We can parse CSV data into Ruby objects which we can use in our programs.  Now we're going to take Ruby objects and save their state to a CSV file.  To do this, we'll build a `PeopleWriter` module with a `.write` method.  We can create a collection of `People` objects and then tell the writer to write them to a file.  (see Figure 1)

We do not need to write tests for the writing behavior.

*Note:* When we read and write to a file, we can choose a mode (like `"r"` for read and `"w"` for write).  The CSV modes are the same as the [modes available for File][ruby file modes].


### Release 5: Collect and Save Information
Now that we can write data to CSV, let's write a script that will allow us to create a CSV address book based on user input.  We'll enter people's names, phone numbers, etc. and then save the data to a CSV file.  Let's modify the runner file so that when it runs, we're prompted to enter information.  We'll enter the data for as many people as we want.  And then, once we're done making entries, the data we've entered will be written to a CSV file.


## Conclusion
The overall goal of this challenge is to learn to manipulate Ruby objects and CSV as part of a single application. All the data we needed to represent people was held in a CSV file, but the CSV file is just text and lacks person-like behavior (e.g., returning a name).  By creating Ruby objects based on the data, we were able to create objects whose behaviors matched the needs of our application. This is a common pattern in software engineering: change the representation of data from Format A to Format B to make it easier to do X with it.

[DateTime]: https://ruby-doc.org/stdlib-2.4.0/libdoc/date/rdoc/DateTime.html
[DateTime.parse]: http://www.ruby-doc.org/stdlib-2.4.0/libdoc/date/rdoc/DateTime.html#method-c-parse
[persistence]: https://en.wikipedia.org/wiki/Persistence_(computer_science)
[ruby docs csv]: http://ruby-doc.org/stdlib-2.4.0/libdoc/csv/rdoc/CSV.html
[ruby file modes]: http://ruby-doc.org/core-2.4.0/IO.html#method-c-new-label-IO+Open+Mode
[wikipedia csv]: https://en.wikipedia.org/wiki/Comma-separated_values
