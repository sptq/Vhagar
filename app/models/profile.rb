class Profile < ActiveRecord::Base
  belongs_to :user

  validates :place, presence: true
  validates :job, presence: true
  validates :firstName, presence: true
  validates :lastName, presence: true

  def isFromShool?
  	if (self.job == 'uczen' || self.job == 'nauczyciel')
  		return true
  	else 
  		return false
  	end
  end
end
