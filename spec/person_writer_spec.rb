require_relative "../person_writer"

describe PersonWriter do

  # Before each test example, create a temporary file
  # with CSV data in it.  The test expectations are
  # based on the content of this temporary file,
  # which contains a header row and one row of data.
  before(:each) do
    @csv_file = Tempfile.new("person_data")
    @csv_file << "first_name,last_name,email,phone,born_at\n"
    @csv_file << "Jayde,Beahan,beahan.jayde@gmail.com,1-542-555-5812,2004-01-06 11:54:00\n"
    @csv_file.flush
  end

  # After each test, delete the temporary file.
  after(:each) do
    @csv_file.close
    @csv_file.delete
  end

  let(:new_person) do
    Person.new({
      :first_name => "Camille",
      :last_name  => "Maxwell",
      :email      => "camille.maxwell@domain.com",
      :phone      => "1-419-555-1234",
      :born_at    => DateTime.parse("1999-02-16 22:11:00")
    })
  end

  it "does not overwrite the contents of the file" do
    # Append data to the file
    PersonWriter.append(@csv_file, new_person)

    # Check the contents of the file
    updated_file_content = File.read(@csv_file)
    expect(updated_file_content).to match /\Afirst_name,last_name,email,phone,born_at\nJayde,Beahan,beahan.jayde@gmail.com,1-542-555-5812,2004-01-06 11:54:00\n/
  end

  it "appends the person's data formatted correctly" do
    # Append data to the file
    PersonWriter.append(@csv_file, new_person)

    # Check the contents of the file
    updated_file_content = File.read(@csv_file)
    expect(updated_file_content).to match /Camille,Maxwell,camille.maxwell@domain.com,1-419-555-1234,1999-02-16 22:11:00\n\z/
  end
end
