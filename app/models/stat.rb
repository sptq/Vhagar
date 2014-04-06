class Stat < ActiveRecord::Base
	has_many :user
	has_many :profile
end
