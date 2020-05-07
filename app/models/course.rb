class Course < ApplicationRecord
  has_many :groups
  has_many :users, through: :groups

  # I could move the validation to the validation layer in a separate class instead of here, but in this case it would be overkill
  validates :name, presence: true, uniqueness: true
end
