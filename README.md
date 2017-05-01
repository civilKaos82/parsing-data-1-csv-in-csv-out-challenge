# Parsing Data: CSV to Ruby to CSV

## Summary
In this challenge we'll begin to explore *[persistence][]*, which allows the *state* of our applications—their data—to live on after our applications are done running.  See, as a program runs, Ruby creates objects that exist only in our computer's memory.  And when the application ends, that in-memory data is lost.  To save the state of our applications, we need to store the data somewhere more permanent than the computer's memory.

For this challenge, we're going to use a text file as a data store.  We'll load data from a text file into a Ruby application.  We'll also write data from a Ruby application to a text file.

### Encoding Data as Text
Since we'll be saving data in a text file, we'll need to encode all of our data as text.  There are a number of commonly used formats for encoding data as text.  We'll be using [CSV][wikipedia csv] in this challenge.  Other examples are XML, JSON, and YAML.  Encoding data in one of these formats has some advantages.  First, these standard formats make our data easily transferable.  So, for example, our Ruby application can save data formatted as CSV and then a JavaScript application can load that CSV data.  Second, most languages provide libraries for reading and writing these formats.

### Ruby's CSV Library
Ruby provides a `CSV` library which we'll use to read from and write to CSV files (see [Ruby docs][ruby docs csv]).  `CSV` is not automatically loaded when Ruby starts.  We need to explicitly require it (see `person_parser.rb`).

`CSV` provides a handful of different methods we can use to read a file.  And these methods allow us to pass options that customize how the data in the file is represented in Ruby.  So, how exactly do we use the library?  Well, in addition to learning about persistence and transforming data between formats, another goal of this challenge is to learn how to use a new library.  The `CSV` library will be unfamiliar to us.  But, we're going to learn how to use it.  How do we do that?  Reading documentation is a great starting point.  We can also experiment in IRB.  What else?  


## Releases
### Release 0: Build Ruby Objects from CSV Data
We'll start by building Ruby objects from CSV data.  We'll build a `PersonParser` module with the responsibility of parsing the data in a CSV file into `Person` objects (see `people.csv` and `person.rb`).  Our module will have one method:  `.parse`.  The method accepts one argument, the name of a CSV file.  It converts each line of data in the file into a `Person` object and returns those objects in an array.  Write out the method body for `PersonParser.parse`; tests are provided in `spec/person_parser_spec.rb`.

*Note:*  The data in a CSV file is represented as text, and it comes into Ruby as strings by default.  Names, phone numbers, and e-mail addresses are represented well as strings, but there are better options for other data.  A date and time, for example.  Ruby provides classes like [DateTime][] specifically built for representing them.  The tests expect that appropriate data types are chosen.


### Release 1: Saving Ruby State to CSV
```ruby
jane = Person.new(...)

PersonWriter.append('some_file.csv', jane)
```
*Figure 1*.  Saving a person's data to a CSV file.

Now that we can parse CSV data into Ruby objects, we're going to take Ruby objects and save their state to a CSV file.  To do this, we'll build a `PeopleWriter` module with an `.append` method.  The method takes two arguments:  the name of a file and a `Person` object.  The method appends the person's data to the end of the file; tests are provided in `spec/person_parser_spec.rb`.

*Note:* When we open a file in Ruby, we can choose a mode (e.g., `"r"` for read).  The modes for `CSV` are the same as the [modes available][ruby file modes] for `File`.  We'll need to select the appropriate mode.


### Release 2: Working with a Data Store in an Application
Now that we can both read from a data store file and write to one, let's incorporate reading and writing to a file into an application.  We want to do two things.  One, we want to allow users to filter the list of people in `people.csv` to just those from a specific area code, with a specific last name, etc.  Two, we want to allow users to add data to `people.csv`.

Read through the `runner.rb` file.  The first command, search by area code, is written for us—provided our parser works correctly; run the command following the example seen in Figure 2.  Then, continue to develope the runner until all the commands are functional, including being able to add data to the file.

![runner animation](readme-assets/runner_animation.gif)  
*Figure 2*.  Filtering the ruby objects created from the CSV file.


## Conclusion
The overall goal of this challenge is to learn to manipulate Ruby objects and CSV as part of a single application. All the data we needed to represent people was held in a CSV file, but the CSV file is just text and lacks person-like behavior (e.g., returning a name).  By creating Ruby objects based on the data, we were able to create objects whose behaviors matched the needs of our application. This is a common pattern in software engineering: change the representation of data from Format A to Format B to make it easier to do X with it.

[DateTime]: https://ruby-doc.org/stdlib-2.4.0/libdoc/date/rdoc/DateTime.html
[DateTime.parse]: http://www.ruby-doc.org/stdlib-2.4.0/libdoc/date/rdoc/DateTime.html#method-c-parse
[persistence]: https://en.wikipedia.org/wiki/Persistence_(computer_science)
[ruby docs csv]: http://ruby-doc.org/stdlib-2.4.0/libdoc/csv/rdoc/CSV.html
[ruby file modes]: http://ruby-doc.org/core-2.4.0/IO.html#method-c-new-label-IO+Open+Mode
[wikipedia csv]: https://en.wikipedia.org/wiki/Comma-separated_values
