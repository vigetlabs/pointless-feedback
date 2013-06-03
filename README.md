# Pointless Feedback

**Currently, a work-in-progress -- not production-ready**

A Rails engine that provides a platform for your app to submit user feedback to
a specified service. Messages are stored in your database as a fail-safe when
the specified service is unavailable. Currently, only email, Unfuddle, and
Github Issues are supported.

*Brought to you by the fine folks at [Viget](http://viget.com) and commissioned
under [Pointless Corp](http://www.pointlesscorp.com/).*

## Contents

1. [Installation](#installation)
2. [Customization](#customization)
3. [Development](#development)
4. [Roadmap](#roadmap)
5. [Contributors](#contributors)

## Installation

Pointless Feedback has been tested against Rails 3.2+. To install, simply add
the following to your Gemfile:

```ruby
gem 'pointless_feedback', :git => 'git@github.com:vigetlabs/pointless-feedback.git'
```

After you install Pointless Feedback and add it to your Gemfile, you need to
run the generator:

```
bundle exec rails generate pointless_feedback:install
```

The generator will install an initializer which describes ALL Pointless
Feedback's configuration options and you MUST take a look at it. When you are
done, you are ready to mount the routes in your `config/routes.rb` file.

```ruby
mount PointlessFeedback::Engine => '/feedback'
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

- [ ] Add configurable list of topics for form
- [ ] Add service to send email
- [ ] Add service to send to Unfuddle
- [ ] Add service to send to Github
- [ ] Add honeypot to prevent spam bots

## Contributors

* @zporter

This project rocks and uses MIT-LICENSE.
