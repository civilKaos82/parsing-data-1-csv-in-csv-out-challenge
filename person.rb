class Person
  attr_reader :first_name, :last_name, :email, :phone, :born_at

  def initialize(args = {})
    @first_name = args[:first_name]
    @last_name  = args[:last_name]
    @email      = args[:email]
    @phone      = args[:phone]
    @born_at    = args[:born_at]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def area_code
    phone[2..4]
  end

  def area_code?(code)
    area_code == code
  end
end
