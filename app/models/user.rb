class User < ActiveRecord::Base
  has_many :tweets
end
