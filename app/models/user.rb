class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true,
                       format: { with: /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*\W).{8,14}/, message: 'Pasword should contain atleast one lowercase character, one uppercase character, one number and one special character and it should be between 8 to 14' }
end
