module PointlessFeedback
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      desc "Copies Pointless Feedback views to your application."
      source_root File.expand_path("../../../../app/views/pointless_feedback", __FILE__)

      public_task :copy_views

      def copy_views
        directory 'messages', 'app/views/pointless_feedback/messages' do |content|
          content
        end
      end
    end
  end
end
