class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process(email)
    binding.pry
    Newsletter.last.update_attribute(introduction, email.body)
  end
end
