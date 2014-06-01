class User < ActiveRecord::Base
	has_many :likes, :dependent => :destroy
	has_many :liked_movies, through: :likes, :source => :movie	
	validates :email, :uniqueness=> true

	def duplicate?
		if User.find_by_email(self.email)
			true
		else
			false
		end	
	end	
end
