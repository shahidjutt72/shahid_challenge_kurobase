class Movie < ActiveRecord::Base
	has_many :likes, :dependent => :destroy
	has_many :liked_users, through: :likes, :source => :user
	acts_as_taggable
end
