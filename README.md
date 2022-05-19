# Pointless Feedback

[![Code Climate](https://codeclimate.com/github/vigetlabs/pointless-feedback.png)](https://codeclimate.com/github/vigetlabs/pointless-feedback) [![Build Status](https://travis-ci.org/vigetlabs/pointless-feedback.svg?branch=master)](https://travis-ci.org/vigetlabs/pointless-feedback)

A Rails engine that provides a platform for your app to submit user feedback to
a specified service. Messages are stored in your database as a fail-safe when
the specified service is unavailable. Currently, only email, Unfuddle, and
Github Issues are supported.

*Brought to you by the fine folks at [Viget](http://viget.com) and commissioned
under [Pointless Corp](http://www.pointlesscorp.com/).*

## Contents

1. [Versions](#versions)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Customization](#customization)
5. [Development](#development)
6. [Roadmap](#roadmap)
7. [Contributors](#contributors)

## Versions

For Rails 3.x support, use Pointless Feedback version 1.x.

For Rails 4.x and greater, use Pointless Feedback version 4.x.

Additionally, Pointless 4.x will only support Ruby 2.x.

## Installation

To install, simply add the following to your Gemfile:

```ruby
gem 'pointless_feedback'
```

After you install Pointless Feedback and add it to your Gemfile, you need to
run the generator and install the engine migrations:

```
bundle exec rails generate pointless_feedback:install
bundle exec rake pointless_feedback:install:migrations
bundle exec rake db:migrate
```

The generator will install an initializer which describes ALL Pointless
Feedback's configuration options and you MUST take a look at it. When you are
done, you are ready to mount the routes in your `config/routes.rb` file.

```ruby
mount PointlessFeedback::Engine, :at => '/feedback'
```

Pointless Feedback uses flash messages to let users know if feedback was
successfully sent. Pointless Feedback expects your application to call
`flash[:notice]` as appropriate.

After submitting feedback, Pointless Feedback will use your application's
default `root_path`. This means that you need to set the root inside your
routes:

```ruby
root :to => 'home#index'
```

That's it! Start your Rails server and navigate to `/feedback` to see a basic
feedback form that users can submit.

## Configuration

There are a number of configuration variables you can set in the initializer generated by `rails generate pointless_feedback:install`

#### Email Configuration

**email_feedback:**
Defaults to `false`. If set to `true` will send feedback as an email.

**message_topics:**
Defaults to `['Error on page', 'Other']`. Populates the "Topic" dropdown for feedback submissions.

**send_from_submitter:**
Defaults to `false`. If set to `true` will use the submitted email address as the from address for feedback emails.

**to_emails:**
Specifies to what addresses feedback email is sent to.

**from_email:**
Specifies what address the feedback email is sent from.

**table_name:**
Defaults to engine's namespace, e.g. `pointless_feedback_messages`.  Change to any desired table for `PointlessFeedback::Message` model.

**invalid_words:**
List of words in the feedback description that would prevent an email from sending.

**show_url_field:**
Defaults to `false`. If set to `true`, will show an additional URL field in the form.

**url_label:**
Defaults to `URL`. The label for the URL field that will be shown if `show_url_field` is `true`.

**google_captcha_site_key & google_captcha_secret_key:**
If you'd like to block out the robots, set up a Google Captcha instance:

Do so here - http://www.google.com/recaptcha/admin. Be sure to configure it with the reCAPTCHA v2 `"I'm not a robot" Checkbox`. Then copy the site_key and secret_key into these config variables and PointlessFeedback will handle the rest!

#### Airtable Configuration

**airtable_api_key:**
Self explanatory, required if you want to export submitted feedback contents into an Airtable database.

**airtable_app_key:**
Self explanatory

**airtable_table_name:**
Self explanatory

## Customization

Pointless Feedback provides you with a simple setup that should cover most
cases. However, certain things are customizable to suit your app's needs.

#### Views

Since Pointless Feedback is an engine, all its views are packaged inside the
gem. These views will help you get started, but after some time you may want
to change them. If this is the case, you just need to invoke the following
generator, and it will copy all views to your application:

```
bundle exec rails generate pointless_feedback:views
```

After doing so, you will find the views at `app/views/pointless_feedback/`
within your application.

**Note: Any url helpers used while on the feedback form page will need to prefaced with `main_app`.**

#### I18n

Most of the messaging in the Pointless Feedback engine uses I18n and can be
customized within your respective localization file.

To customize the flash notification upon successful submission, add the
following to your `config/locales/en.yml` file:

```yml
pointless_feedback:
  messages:
    saved: "Thanks for your feedback!"
```

The error messages output defaults to the following:

```yml
activerecord:
  errors:
    header: "Invalid Fields"
    message: "Correct the following errors and try again."
```

To customize the subject of the feedback email, add the following to your
`config/locales/en.yml` file as well:

```yml
pointless_feedback:
  email:
    subject: "Pointless Feedback"
```

#### Controllers

You can overwrite `after_message_create_path` in your `ApplicationController`
to customize your redirect hook.

## Development

1. Clone the repo: `git clone git://github.com/vigetlabs/pointless-feedback.git`
2. Install dependencies: `bundle install`
3. Setup databases: `bundle exec rake db:migrate && rake app:db:test:prepare`
4. Run the test suite: `bundle exec rake test`
5. Make your changes in a feature branch
6. Make sure the test suite passes before submitting a Pull Request

## Roadmap

- [ ] Add service to send to Github
- [ ] Add admin view for messages with comments

## Contributors

* [@zporter](http://github.com/zporter)
* [@efatsi](http://github.com/efatsi)
* [@reagent](http://github.com/reagent)

This project rocks and uses MIT-LICENSE.

***

<a href="http://code.viget.com">
  <img src="http://code.viget.com/github-banner.png" alt="Code At Viget">
</a>

Visit [code.viget.com](http://code.viget.com) to see more projects from [Viget.](https://viget.com)
