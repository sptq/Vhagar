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

private

def ensure_admin_presence
	if User.find_by_user_role(:admin).count == 0
		self.user_role = :admin
	end	
end
end
