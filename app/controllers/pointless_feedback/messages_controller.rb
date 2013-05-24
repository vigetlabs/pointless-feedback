module PointlessFeedback
  class MessagesController < PointlessFeedback.parent_controller.constantize
    def new
      @message = Message.new
    end

    def create
      @message = Message.new(params[:message])

      if @message.save
        flash[:notice] = I18n.t('pointless_feedback.messages.saved',
                                :default => 'Thanks for your feedback!')

        redirect_to after_message_create_path
      else
        render :new
      end
    end
  end
end
