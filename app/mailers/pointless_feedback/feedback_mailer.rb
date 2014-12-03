module PointlessFeedback
  class FeedbackMailer < ActionMailer::Base
    def feedback(message)
      @message = message

      mail(:to => to_emails, :subject => feedback_subject, :from => from_address)
    end

    private

    def from_address
      if PointlessFeedback.send_from_submitter
        @message.email_address
      else
        PointlessFeedback.from_email
      end
    end

    def to_emails
      Array(PointlessFeedback.to_emails)
    end

    def feedback_subject
      I18n.t('pointless_feedback.email.subject', :default => 'Feedback')
    end
  end
end
