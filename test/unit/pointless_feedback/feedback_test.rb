require 'test_helper'

module PointlessFeedback
  class FeedbackTest < ActiveSupport::TestCase
    subject { PointlessFeedback::Feedback.new }

    %w(name email_address topic description).each do |field|
      it "requires #{field}" do
        subject.send("#{field}=", '')
        subject.save

        subject.errors[field.to_sym].must_include "can't be blank"
      end
    end
  end
end
