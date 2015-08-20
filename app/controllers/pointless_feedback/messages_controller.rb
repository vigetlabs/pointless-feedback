module PointlessFeedback
  class MessagesController < PointlessFeedback.parent_controller.constantize
    helper PointlessFeedback::ApplicationHelper

    def new
      @message = Message.new
    end

    def create
      @message = Message.new(params[:message])

      if pass_captcha? && @message.save
        flash[:notice] = I18n.t('pointless_feedback.messages.saved',
                                :default => 'Thanks for your feedback!')

        redirect_to after_message_create_path
      else
        render :new
      end
    end

    private

    def pass_captcha?
      if PointlessFeedback.using_captcha?
        PointlessFeedback::Captcha.pass?(params["g-recaptcha-response"])
      else
        true
      end
    end
  end
end
