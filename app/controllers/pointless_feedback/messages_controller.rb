module PointlessFeedback
  class MessagesController < PointlessFeedback.parent_controller.constantize
    helper PointlessFeedback::ApplicationHelper

    def new
      @message = Message.new
    end

    def create
      @message = Message.new(message_params)

      if pass_captcha? && @message.save
        flash[:notice] = I18n.t('pointless_feedback.messages.saved',
                                :default => 'Thanks for your feedback!')

        redirect_to after_message_create_path
      else
        flash[:alert] = I18n.t('pointless_feedback.messages.invalid_captcha',
                               :default => 'Are you a robot? Please check the box at the bottom of the page and try again.')
        render :new
      end
    end

    private

    def message_params
      params.require(:message).permit([
        :description,
        :email_address,
        :name,
        :topic,
        :contact_info,
        :url
      ])
    end

    def pass_captcha?
      if PointlessFeedback.using_captcha?
        PointlessFeedback::Captcha.pass?(params["g-recaptcha-response"])
      else
        true
      end
    end
  end
end
