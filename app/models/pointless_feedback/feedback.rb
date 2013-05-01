module PointlessFeedback
  class Feedback < ActiveRecord::Base
    attr_accessible :description, :email_address, :name, :topic

    validates :name, :email_address, :topic, :description, :presence => true
  end
end
