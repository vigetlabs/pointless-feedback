require_dependency "pointless_feedback/application_controller"

module PointlessFeedback
  class FeedbacksController < ApplicationController
    def new
      @feedback = Feedback.new
    end

    def create
      @feedback = Feedback.new(params[:feedback])

      if @feedback.save
        redirect_to '/', :notice => I18n.t('pointless_feedback.feedbacks.saved')
      else
        render :new
      end
    end
  end
end
