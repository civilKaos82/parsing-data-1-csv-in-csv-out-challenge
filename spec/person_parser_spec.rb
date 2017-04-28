require_relative '../person_parser'

describe PersonParser do

  # Before each test example, create a temporary file
  # with CSV data in it.  The test expectations are
  # based on the content of this temporary file.
  # It has a header row and two rows of data.
  before(:each) do
    @csv_file = Tempfile.new("person_data")
    @csv_file << "first_name,last_name,email,phone,born_at\n"
    @csv_file << "Jayde,Beahan,beahan.jayde@gmail.com,1-542-555-5812,2004-01-06 11:54:00\n"
    @csv_file << "Freddy,Lakin,freddy.lakin@gmail.com,1-406-555-1825,1999-02-16 22:11:00"
    @csv_file.flush
  end

  # After each test, delete the temporary file.
  after(:each) do
    @csv_file.close
    @csv_file.delete
  end

  let(:parsing_results) { PersonParser.parse(@csv_file) }
  let(:first_parsed_object) { parsing_results[0] }
  let(:second_parsed_object) { parsing_results[1] }

  it "parses each line of data into an object" do
    expect(parsing_results.count).to eq 2
  end

  it "creates objects with first names" do
    expect(first_parsed_object.first_name).to eq "Jayde"
  end

  it "creates objects with last names" do
    expect(second_parsed_object.last_name).to eq "Lakin"
  end

  it "creates objects with email addresses" do
    expect(first_parsed_object.email).to eq "beahan.jayde@gmail.com"
  end

  it "creates objects with phone numbers" do
    expect(second_parsed_object.phone).to eq "1-406-555-1825"
  end

  it "creates objects with born at dates and times" do
    expect(first_parsed_object.born_at).to eq DateTime.parse("2004-01-06 11:54:00")
  end
end
