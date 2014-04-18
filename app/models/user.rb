class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  
  scope :active, -> { where(isactive: true) }
  scope :inactive, -> { where(isactive: false) }

  has_one :profile
  has_many :participations
  has_many :lectures, :through => :participations

  primary_key = :uuid
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  

  validates :id, presence: true
  validates :user_role, presence: true
  validates_acceptance_of  :acceptTerms, :accept => true, :message => " musi zostać zaakceptowany"

  before_validation :ensure_uuid, :ensure_admin_presence

  # named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }
  ROLES = %w[admin staff sponsor user guest]

  def ensure_uuid
    self.id ||= SecureRandom.uuid
  end

  def ensure_admin_presence
    self.user_role = 'admin' if User.where(user_role: 'admin').to_a.count == 0
  end

  def role?(role)
    user_role.to_s.include? role.to_s
  end

  def admin?
    self.role?('admin')
  end

  def self.searchByFirstLastName(firstName, lastName)
    params = { :firstName => "%#{firstName.downcase}%", :lastName => "%#{lastName.downcase}%"}
    self.joins(:profile).where('lower("profiles"."firstName") LIKE :firstName AND lower("profiles"."lastName") LIKE :lastName', params)
  end

  def self.searchByPhrase(phrase)
    if (phrase != '')
      param = { :phrase => "%#{phrase.downcase}%" }
      self.joins(:profile).where('lower("profiles"."firstName") LIKE :phrase OR lower("profiles"."lastName") LIKE :phrase OR lower("users"."email") LIKE :phrase OR lower("profiles"."place") LIKE :phrase OR lower("profiles"."job") LIKE :phrase OR lower("profiles"."phone") LIKE :phrase', param)
    else
      self.all
    end
  end

  def self.haveGroup?
    self.haveGroup
  end

  def self.generateCode
    if self.profile != nil && (self.groupCode == nil || self.groupCode == '')
      return (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    else
      return self.groupCode
    end
  end

  def self.searchByGroupCode
    if self.groupCode != nil || self.groupCode != ''
      params = { :groupCode => self.groupCode }
      self.where('"users"."groupCode" == :groupCode AND "users"."job" <> nauczyciel', params)
    end
  end

  def profile?
    self.profile == nil
  end
end
