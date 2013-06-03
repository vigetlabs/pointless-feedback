module PointlessFeedback
  class FeedbackMailer < ActionMailer::Base
    default :from => PointlessFeedback.from_email

    def feedback(email, message)
      @message = message
      mail(:to => email, :subject => feedback_subject)
    end

    private

    def feedback_subject
      I18n.t('pointless_feedback.email.subject', :default => 'Pointless Feedback')
    end
  end
end
