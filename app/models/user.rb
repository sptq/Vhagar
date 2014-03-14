class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  primary_key = :uuid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :uuid, presence: true
  validates :user_role, presence: true
  before_validation :ensure_uuid
  after_save :ensure_admin_presence

  def ensure_uuid; self.uuid ||= SecureRandom.uuid end

  # named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }
  ROLES = %w[admin staff user guest]

  def role?(role)
    user_role.to_s.include? role.to_s
  end

  def admin?
    role? :admin
  end

private

  def ensure_admin_presence
    @admins = User.where(['user_role LIKE ?', '%admin%']).to_a
    user_role = 'admin' unless @admins.count > 0
  end
end
