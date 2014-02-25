class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  primary_key = :uuid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :uuid, presence: true
  validates :user_role, presence: true
  before_validation :ensure_uuid
  def ensure_uuid; self.uuid ||= SecureRandom.uuid end

end
