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

Mount the routes in your `config/routes.rb` file.

```ruby
mount PointlessFeedback::Engine => '/feedback'
```

That's it! Start your Rails server and navigate to `/feedback` to see a basic
feedback form that users can submit.

## Customization

Pointless Feedback provides you with a simple setup that should cover most
cases. However, certain things are customizable to suit your app's needs.

#### Views

To override the feedback form, simply add
`pointless_feedback/messages/new.html.erb` to your `app/views` directory.

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

## Development

1. Clone the repo: `git clone git://github.com/vigetlabs/pointless-feedback.git`
2. Install dependencies: `bundle install`
3. Run the test suite: `bundle exec rake test`
4. Make your changes in a feature branch
5. Make sure the test suite passes before submitting a Pull Request

## Roadmap

- [ ] Add configurable list of topics for form
- [ ] Add service to send email
- [ ] Add service to send to Unfuddle
- [ ] Add service to send to Github
- [ ] Add honeypot to prevent spam bots

## Contributors

* @zporter

This project rocks and uses MIT-LICENSE.
