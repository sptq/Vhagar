class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :id, presence: true
  validates :user_role, presence: true
  before_validation :ensure_uuid, :ensure_admin_presence

  def ensure_uuid
    self.id ||= SecureRandom.uuid
  end
  def ensure_admin_presence
    self.user_role = 'admin' if User.where(user_role: 'admin').to_a.count == 0
  end

  has_many :participations
  has_many :lectures, :through => :participations

  # named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }
  ROLES = %w[admin staff user guest]

  def role?(role)
    user_role.to_s.include? role.to_s
  end
end
