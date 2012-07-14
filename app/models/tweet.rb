class Tweet < ActiveRecord::Base
  attr_accessible :scheduled_at, :sent, :text, :user_id
end
