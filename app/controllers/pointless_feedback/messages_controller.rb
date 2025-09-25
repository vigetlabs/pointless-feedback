module PointlessFeedback
  class MessagesController < PointlessFeedback.parent_controller.constantize
    helper PointlessFeedback::ApplicationHelper

    def new
      @message = Message.new
    end

    def create
      @message = Message.new(message_params)

      begin
        captcha_passed = pass_captcha?
        message_saved = @message.save if captcha_passed

        if captcha_passed && message_saved
          flash[:notice] = I18n.t('pointless_feedback.messages.saved',
                                  :default => 'Thanks for your feedback!')
          redirect_to after_message_create_path
        else
          flash[:alert] = I18n.t('pointless_feedback.messages.invalid_captcha',
                                 :default => 'Are you a robot? Please check the box at the bottom of the page and try again.')
          render :new
        end
      rescue => e
        Rails.logger.error "PointlessFeedback error: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")

        if Rails.env.development?
          raise e
        else
          flash[:alert] = "Sorry, there was a technical problem. Please try again later."
          render :new
        end
      end
    end

    private

    def message_params
      params.require(:message).permit([
        :description,
        :email_address,
        :name,
        :topic,
        :contact_info
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
