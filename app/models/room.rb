class Room < ActiveRecord::Base
  validates :title, presence: true
  validates :descriptions, presence: true
  before_validation :ensure_uuid

  def ensure_uuid; self.id ||= SecureRandom.uuid end

  has_many :lectures
end
