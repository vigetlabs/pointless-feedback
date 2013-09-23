module PointlessFeedback
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      extend ActiveSupport::Concern

      def after_message_create_path
        main_app.try(:root_path) || '/'
      end
    end
  end
end
