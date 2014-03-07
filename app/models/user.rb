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

  # named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }
  ROLES = [:admin, :moderator, :author, :editor]

  def role?(role)
    user_role.to_s == role.to_s
  end

  def admin?
    role? :admin
  end

private

  def ensure_admin_presence
  		user_role = 'admin' unless User.where(user_role: :admin).count != 0
  end
end
