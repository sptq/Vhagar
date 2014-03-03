class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  primary_key = :uuid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :uuid, presence: true
  validates :user_role, presence: true
  before_validation :ensure_uuid, :ensure_admin_presence
  def ensure_uuid; self.uuid ||= SecureRandom.uuid end

  def is_admin
    user_role.to_sym == :admin
  end

private

  def ensure_admin_presence
  		self.user_role = :admin unless User.where(user_role: :admin).count != 0
  end
end
