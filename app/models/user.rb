class User < ApplicationRecord
  has_secure_password

  has_many :articles
  validates_presence_of :name, :email
  validates :email, uniqueness: true
end
