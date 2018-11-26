PointlessFeedback.setup do |config|
  # ==> Feedback Configuration
  # Configure the topics for the user to choose from on the feedback form
  # config.message_topics = ['Error on page', 'Feature Request', 'Praise', 'Other']

  # ==> Email Configuration
  # Configure feedback email properties (disabled by default)
  # Variables needed for emailing feedback
  # config.email_feedback      = false
  # config.send_from_submitter = false
  # config.from_email          = 'feedback@pointlesscorp.com'
  # config.to_emails           = ['first@example.com', 'second@example.com']

  # ==> Google reCAPTCHA Configuration
  # If you'd like to enable Google reCAPTCHA,
  # 1. Register your site at: https://www.google.com/recaptcha/admin
  # 2. !! Ensure you opt for reCAPTCHA v2. Support for v3 is not here yet.
  # 3. Grab the site and secret key and paste them here.
  #
  # config.google_captcha_site_key   = nil
  # config.google_captcha_secret_key = nil

  # ==> Airtable Configuration
  # If you'd like to export feedback submissions to an Airtable database,
  # 1. Create an Airtable database with the following columns:
  #    - Name
  #    - Email
  #    - Topic
  #    - Description
  # 2. Generate an API Key: https://airtable.com/account
  # 3. Find your app key and table name: https://airtable.com/api
  # 4. Fill in all these configs
  #
  # config.airtable_api_key    = "key--------------"
  # config.airtable_app_key    = "app--------------"
  # config.airtable_table_name = "Feedback Tracker"
end
