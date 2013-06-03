module PointlessFeedback
  class Message < ActiveRecord::Base
    attr_accessible :description, :email_address, :name, :topic

    validates :name, :email_address, :topic, :description, :presence => true
    validates :topic, :inclusion => { :in => PointlessFeedback.message_topics }

    after_save :export_feedback

    private

    def export_feedback
      if PointlessFeedback.email_feedback
        PointlessFeedback.to_emails.each do |email|
          FeedbackMailer.feedback(email, self).deliver
        end
      end
    end
  end
end
