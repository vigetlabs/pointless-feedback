require 'test_helper'

module PointlessFeedback
  class FeedbackMailerTest < ActionMailer::TestCase
    before do
      @message = FactoryGirl.create(:message)
      @mail    = FeedbackMailer.feedback('to@example.com', @message)
    end

    test "feedback email" do
      assert_equal "Pointless Feedback", @mail.subject
      assert_equal ["to@example.com"], @mail.to
      assert_equal ["feedback@pointlesscorp.com"], @mail.from
    end

    test "feedback email body" do
      assert_match "You've got feedback!", @mail.body.encoded
      assert_match "Name: #{@message.name}", @mail.body.encoded
      assert_match "Email Address: #{@message.email_address}", @mail.body.encoded
      assert_match "Topic: #{@message.topic}", @mail.body.encoded
      assert_match "Description: #{@message.description}", @mail.body.encoded
    end

  end
end
