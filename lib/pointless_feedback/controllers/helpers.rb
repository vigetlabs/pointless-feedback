module PointlessFeedback
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      def after_message_create_path
        main_app.try(:root_path) || '/'
      end
    end
  end
end
