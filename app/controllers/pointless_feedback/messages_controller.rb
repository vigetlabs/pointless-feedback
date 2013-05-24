require_dependency "pointless_feedback/application_controller"

module PointlessFeedback
  class MessagesController < ApplicationController
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

    private

    def after_message_create_path
      main_app.respond_to?(:root_path) ? main_app.root_path : '/'
    end
  end
end
