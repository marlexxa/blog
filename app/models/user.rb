class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email
  validates :email, uniqueness: true
end
