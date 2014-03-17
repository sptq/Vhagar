class Lecture < ActiveRecord::Base

  validates :id, presence: true
  before_validation :ensure_uuid

  def ensure_uuid; self.id ||= SecureRandom.uuid end

  has_many :participations
  has_many :participants, :through => :participations, :source => :user

	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def lecture_params
		params.require(:lecture).permit(:title, :description, :start_date)
	end
end
