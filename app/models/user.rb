class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :password_digest, length: { minimum: 6},  confirmation: true, on: :create

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".strip.squeeze(" ")
    else
      email
    end
  end

end
