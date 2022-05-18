module PointlessFeedback
  class Message < ActiveRecord::Base
    if PointlessFeedback.table_name.present?
      self.table_name = PointlessFeedback.table_name
    end

    attr_accessor :contact_info

    validates :name, :email_address, :topic, :description, :presence => true
    validates :topic, :inclusion => PointlessFeedback.message_topics
    validates :email_address, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validate :is_not_spam

    after_save :export_feedback, :unless => :ignore_feedback?

    private

    def export_feedback
      if PointlessFeedback.email_feedback
        # Support Rails < 4.2 and >= 4.2 delivery options
        mailer = FeedbackMailer.feedback(self)
        mailer.respond_to?(:deliver_now) ? mailer.deliver_now : mailer.deliver
      end

      if PointlessFeedback.airtable_api_key
        feedback_table = Airrecord.table(
          PointlessFeedback.airtable_api_key,
          PointlessFeedback.airtable_app_key,
          PointlessFeedback.airtable_table_name
        )

        begin
          feedback_table.create(
            "Name"        => name,
            "Email"       => email_address,
            "Topic"       => topic,
            "Description" => description,
            "Date"        => created_at.strftime("%m/%d/%y")
          )
        rescue => e
          # ignore errors in production, last thing you want is a 500
          # when someone's trying to complain about your site.
          raise(e) if Rails.env.development?
        end
      end
    end

    def ignore_feedback?
      honeypot_filled_in? || contains_invalid_words?
    end

    def honeypot_filled_in?
      contact_info.present?
    end

    def contains_invalid_words?
      PointlessFeedback.invalid_words.each do |word|
        if description.downcase.include? word.downcase
          return true
        end
      end

      false
    end

    def is_not_spam
      if URI.extract(description || "").count >= 3
        errors.add(:description, "can not contain more than 2 http links (often a sign of spam)")
      end
    end
  end
end
