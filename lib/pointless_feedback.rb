require "pointless_feedback/engine"
require "pointless_feedback/captcha"
require "typhoeus"

module PointlessFeedback
  module Controllers
    autoload :Helpers, 'pointless_feedback/controllers/helpers'
  end

  # The parent controller all PointlessFeedback controllers inherit from.
  # Defaults to ApplicationController. This should be set early
  # in the initialization process and should be set to a string.
  mattr_accessor :parent_controller
  @@parent_controller = "ApplicationController"

  # The table name that will be used to store all messages.  By default this
  # includes the engine's namespace (e.g. `pointless_feedback_messages`), but
  # it can be configured to whatever is desired.
  mattr_accessor :table_name

  # Custom topics to display on message form
  mattr_accessor :message_topics
  @@message_topics = ['Error on page', 'Other']

  # Variables needed for emailing feedback
  mattr_accessor :email_feedback
  @@email_feedback = false

  mattr_accessor :from_email
  @@from_email = 'feedback@pointlesscorp.com'

  mattr_accessor :send_from_submitter
  @@send_from_submitter = false

  mattr_accessor :to_emails
  @@to_emails = ['first@example.com', 'second@example.com']

  mattr_accessor :google_captcha_site_key
  @@google_captcha_site_key = nil

  mattr_accessor :google_captcha_secret_key
  @@google_captcha_secret_key = nil

  # Default way to setup PointlessFeedback. Run rails generate
  # pointless_feedback_install to create a fresh initializer with all
  # configuration values.
  def self.setup
    yield self
  end

  def self.using_captcha?
    @@google_captcha_site_key.present? && @@google_captcha_secret_key.present?
  end
end
