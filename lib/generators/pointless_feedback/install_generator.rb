module PointlessFeedback
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a PointlessFeedback initializer for your application."

      def copy_initializer
        template "pointless_feedback.rb", "config/initializers/pointless_feedback.rb"
      end
    end
  end
end
