require_relative "../person"

require "date"

describe Person do
  let(:person) do
    Person.new({
      :first_name => "Jose",
      :last_name  => "Leal",
      :email      => "jose.leal@domain.com",
      :phone      => "1-419-531-8916",
      :born_at    => DateTime.parse("1920-01-01 15:30:00")
    })
  end

  it "has a first name" do
    expect(person.first_name).to eq "Jose"
  end

  it "has a last name" do
    expect(person.last_name).to eq "Leal"
  end

  it "has a full name" do
    expect(person.full_name).to eq "Jose Leal"
  end

  it "has an email address" do
    expect(person.email).to eq "jose.leal@domain.com"
  end

  it "has a phone number" do
    expect(person.phone).to eq "1-419-531-8916"
  end

  describe "phone number's area code" do
    it "has an area code" do
      expect(person.area_code).to eq "419"
    end

    it "returns true when it's phone number is in an area code" do
      expect(person.area_code?("419")).to be true
    end

    it "returns false when it's phone number is not in an area code" do
      expect(person.area_code?("312")).to be false
    end
  end

  it "has a born at date and time" do
    expect(person.born_at).to eq DateTime.parse("1920-01-01 15:30:00")
  end
end
