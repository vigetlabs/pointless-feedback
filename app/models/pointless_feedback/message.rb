module PointlessFeedback
  class Message < ActiveRecord::Base
    attr_accessible :description, :email_address, :name, :topic, :contact_info
    attr_accessor :contact_info

    validates :name, :email_address, :topic, :description, :presence => true
    validates :topic, :inclusion => PointlessFeedback.message_topics
    validates :email_address, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validate :is_not_spam

    after_save :export_feedback, :unless => :honeypot_filled_in?

    private

    def export_feedback
      if PointlessFeedback.email_feedback
        FeedbackMailer.feedback(self).deliver
      end
    end

    def honeypot_filled_in?
      contact_info.present?
    end

    def is_not_spam
      if URI.extract(description || "").count >= 3
        errors.add(:description, "can not contain more than 2 http links (often a sign of spam)")
      end
    end
  end
end
