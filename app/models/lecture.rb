class Lecture < ActiveRecord::Base

  primary_key = :uuid

  before_validation :ensure_uuid

  def ensure_uuid; self.uuid ||= SecureRandom.uuid end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
	def lecture_params
		params.require(:lecture).permit(:title, :description, :start_date)
	end
end
