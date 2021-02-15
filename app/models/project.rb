class Project < ApplicationRecord
  validates :title, presence: true
  validates :description, presence:true
  has_many :bugs, dependent: :destroy
end
