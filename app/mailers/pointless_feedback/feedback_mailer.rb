module PointlessFeedback
  class FeedbackMailer < ActionMailer::Base
    default :from => PointlessFeedback.from_email

    def feedback(message)
      @message = message
      mail(:to => to_emails, :subject => feedback_subject)
    end

    private

    def to_emails
      Array(PointlessFeedback.to_emails)
    end

    def feedback_subject
      I18n.t('pointless_feedback.email.subject', :default => 'Pointless Feedback')
    end
  end
end
