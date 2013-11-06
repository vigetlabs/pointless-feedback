module PointlessFeedback
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper PointlessFeedback::ApplicationHelper
      end

      def after_message_create_path
        main_app.respond_to?(:root_path) ? main_app.root_path : '/'
      end
    end
  end
end
