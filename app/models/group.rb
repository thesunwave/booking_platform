class Group < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :course

  scope :allowed_to_check_in, -> { where('start_date > ?', Date.current) }

  def allow_to_join?
    start_date > Date.current
  end

  def joined_user?(payload)
    users.where(payload).exists?
  end

  def join_user(user)
    users << user
    self
  end
end
