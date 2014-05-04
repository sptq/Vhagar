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
  validates_acceptance_of  :acceptTerms, :accept => true, :message => " musi zostać zaakceptowany", :on => :create

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

  def self.filter(params)
    users = self.joins(:profile)

    #firstName
    if params[:firstName]
      users = users.where('lower("profiles"."firstName") LIKE ?', createLikeStatment(params[:firstName]))

    end

    #lastName
    if params[:lastName]
      users = users.where('lower("profiles"."lastName") LIKE ?', createLikeStatment(params[:lastName]))
    end

    #user role
    if params[:role]
      users = users.where('lower("users"."user_role") LIKE ?', createLikeStatment(params[:role]))
    end

    #user email
    if params[:email]
      users = users.where('lower("users"."email") LIKE ?', createLikeStatment(params[:email]))
    end

    #place
    if params[:place]
      users = users.where('lower("profiles"."place") LIKE ?', createLikeStatment(params[:place]))
    end

    if params[:job]
      users = users.where('lower("profiles"."job") LIKE ?', createLikeStatment(params[:job]))
    end

    return users
  end

  def self.createLikeStatment(statment)
    if statment
      return "%#{statment.downcase}%"
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

  def as_json(options={})
    super(:only => [:email, :id, :barcode],
      :include => {
        :profile => {:only => [:id, :firstName, :lastName, :job, :place]},
        :lectures => {:only => [:id, :title, :start_date]}
      } 
    )
  end
end
