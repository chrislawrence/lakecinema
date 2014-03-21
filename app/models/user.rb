class User < ActiveRecord::Base
  has_secure_password
  before_save :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex
  end
end
