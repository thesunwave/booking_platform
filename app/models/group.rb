class Group < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :course

  scope :allowed_to_check_in, -> { where('start_date > ?', Date.current) }

  def allow_to_join?
    start_date > Date.current
  end
end
