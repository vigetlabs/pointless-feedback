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
end
