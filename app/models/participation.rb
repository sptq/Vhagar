class Participation < ActiveRecord::Base
	belongs_to :user
	belongs_to :lecture


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.require(:participation).permit(:user_id, :lecture_id)
    end
end
