class Comment < ApplicationRecord
  belongs_to :bug
  validates :content, presence: true
end
