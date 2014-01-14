# Parsing Data 1 Csv In Csv Out 
 
##Learning Competencies 

* Map data in a file from one format to another using ruby
* Choose the appropriate method to store data in a file.
 
##Summary 

 When two processes on a single computer or two computers across a network want to share information they have to pre-agree on a format for exchanging data.  A program running on my laptop can't directly access the memory of some program running on yours, so they translate their internal state to/from this intermediate format first.  XML, JSON, CSV, and YAML are all examples of text-based data exchange formats.

You can think of it like a dial-up modem.  Because phone lines were designed to transmit audio signals, my modem translates all outgoing data into an audio signal before it's sent over the phone line.  Your modem receives the audio signal and translates it back into data your computer can make sense of.

If heaven forbid you've never heard what this sounds like, [enjoy this video](http://www.youtube.com/watch?v=GSRG0TqxLWc).  That's the sound of **DATA**.

You'll be receiving, transforming, and forwarding data like this all the time in every program you write, so it's important to get used to it.  We're going to start with a CSV file.

The overall objective here is to learn to manipulate CSV data and objects as part of a single application.  This is a common pattern in software engineering as per the above: change the representation of data from format A to format B to make it easier to do X with it.

Consider, for example, that trying to manipulate CSV data as pure text could get pretty tricky.  Say you wanted to filter out a list of first names from the CSV file that started with the letter "A" or even find all people who had similar last names in area code 415 -- how would you do that?

What if the contents of the CSV file was instead represented as objects in your program.  Couldn't you then just use Enumerable#select or similar methods to grab just the records that matched your search criteria?

These next few steps will walk you through the core part of this process -- getting data out of the file and turning it into a bunch of objects you can manipulate in your program and then save them back to the file.

##Releases

###Release 0 : Person and PersonParser

First, make sure you have a copy of the CSV file from the `people.csv` file.  It contains a few hundred rows of random data about people.

Create a `Person` class such that each row of the CSV file represents a particular instance of the `Person` class.  What attributes should a `Person` object have?

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