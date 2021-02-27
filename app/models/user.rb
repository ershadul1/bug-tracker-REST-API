class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true
  validates_uniqueness_of :username
  has_many :assigns
  has_many :resolves
  has_many :comments
  has_many :bugs
end
