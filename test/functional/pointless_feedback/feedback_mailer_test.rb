require 'test_helper'

module PointlessFeedback
  class FeedbackMailerTest < ActionMailer::TestCase
    before do
      PointlessFeedback.to_emails = 'to@example.com'

      @message = FactoryGirl.create(:message)
      @mail    = FeedbackMailer.feedback(@message)
    end

    test "feedback email" do
      assert_equal "Feedback", @mail.subject
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

    test "feedback email body with URL field" do
      PointlessFeedback.show_url_field = true
      PointlessFeedback.url_label = "Story URL"

      assert_match "You've got feedback!", @mail.body.encoded
      assert_match "Name: #{@message.name}", @mail.body.encoded
      assert_match "Email Address: #{@message.email_address}", @mail.body.encoded
      assert_match "Topic: #{@message.topic}", @mail.body.encoded
      assert_match "Description: #{@message.description}", @mail.body.encoded
      assert_match "Story URL: #{@message.url}", @mail.body.encoded
    end

    test "feedback from email when set" do
      PointlessFeedback.from_email = 'from@example.com'
      @mail = FeedbackMailer.feedback(@message)

      assert_equal 'from@example.com', @mail.from.first
    end

    test "feedback from email when set as the sender" do
      PointlessFeedback.send_from_submitter = true
      @mail = FeedbackMailer.feedback(@message)

      assert_equal @message.email_address, @mail.from.first
    end

  end
end
