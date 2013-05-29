module PointlessFeedback
  class Message < ActiveRecord::Base
    attr_accessible :description, :email_address, :name, :topic

    validates :name, :email_address, :topic, :description, :presence => true
    validates :topic, :inclusion => { :in => PointlessFeedback.message_topics }
  end
end
