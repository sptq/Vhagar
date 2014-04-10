class Lecture < ActiveRecord::Base

  validates :id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true

  before_validation :ensure_uuid

  def ensure_uuid; self.id ||= SecureRandom.uuid end

  belongs_to :room
  has_many :participations
  has_many :participants, :through => :participations, :source => :user

  def available_places
    room.capacity - participants.active.count - reserved
  end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def lecture_params
		params.require(:lecture).permit(:title, :description, :start_date, :room_id, :duration, :reserved)
	end
end
