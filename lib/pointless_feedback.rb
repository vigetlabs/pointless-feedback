require "pointless_feedback/engine"

module PointlessFeedback
  module Controllers
    autoload :Helpers, 'pointless_feedback/controllers/helpers'
  end

  # The parent controller all PointlessFeedback controllers inherit from.
  # Defaults to ApplicationController. This should be set early
  # in the initialization process and should be set to a string.
  mattr_accessor :parent_controller
  @@parent_controller = "ApplicationController"

  # Custom topics to display on message form
  mattr_accessor :message_topics
  @@message_topics = ['Error on page', 'Other']

  # Default way to setup PointlessFeedback. Run rails generate
  # pointless_feedback_install to create a fresh initializer with all
  # configuration values.
  def self.setup
    yield self
  end
end
