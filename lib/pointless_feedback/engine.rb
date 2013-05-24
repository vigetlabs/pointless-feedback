module PointlessFeedback
  class Engine < ::Rails::Engine
    isolate_namespace PointlessFeedback

    initializer "pointless_feedback.controller.helpers" do
      ActiveSupport.on_load(:action_controller) do
        if defined?(PointlessFeedback::Controllers::Helpers)
          include PointlessFeedback::Controllers::Helpers
        end
      end
    end
  end
end
