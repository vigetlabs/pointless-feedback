require_dependency "pointless_feedback/application_controller"

module PointlessFeedback
  class FeedbacksController < ApplicationController
    def new
      @feedback = Feedback.new
    end

    def create
      @feedback = Feedback.new(params[:feedback])

      if @feedback.save
        flash[:notice] = I18n.t('pointless_feedback.feedbacks.saved',
                                :default => 'Thanks for your feedback!')

        redirect_to after_feedback_create_path
      else
        render :new
      end
    end

    private

    def after_feedback_create_path
      main_app.respond_to?(:root_path) ? main_app.root_path : '/'
    end
  end
end
