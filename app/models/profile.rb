class Profile < ActiveRecord::Base
  belongs_to :user

  validates :place, presence: true
  validates :job, presence: true
  validates :firstName, presence: true
  validates :lastName, presence: true
end
