module PointlessFeedback
  class MessagesController < PointlessFeedback.parent_controller.constantize
    helper PointlessFeedback::ApplicationHelper

    def new
      @message = Message.new
    end

    def create
      @message = Message.new(message_params)

      if @message.save
        flash[:notice] = I18n.t('pointless_feedback.messages.saved',
                                :default => 'Thanks for your feedback!')

        redirect_to after_message_create_path
      else
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
        :contact_info
      ])
    end
  end
end
