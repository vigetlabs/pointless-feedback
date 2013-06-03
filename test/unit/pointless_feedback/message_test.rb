require 'test_helper'

module PointlessFeedback
  class MessageTest < ActiveSupport::TestCase
    subject { PointlessFeedback::Message.new }

    %w(name email_address topic description).each do |field|
      it "requires #{field}" do
        subject.send("#{field}=", '')
        subject.save

        subject.errors[field.to_sym].must_include "can't be blank"
      end
    end

    describe "validating topics" do
      subject do
        PointlessFeedback::Message.new(:name          => 'A Developer',
                                       :email_address => 'developer@pointlesscorp.com',
                                       :description   => 'Site is broke')
      end

      it "allows valid topic" do
        subject.topic = 'Other'

        assert subject.valid?
      end

      it "does not allow invalid topic" do
        subject.topic = 'lolwut'

        assert subject.invalid?
        subject.errors[:topic].must_include "is not included in the list"
      end
    end

    describe "exports" do
      describe "when PointlessFeedback.send_emails is true" do
        before  do
          PointlessFeedback.email_feedback = true
          PointlessFeedback.to_emails = ['test1@example.com', 'test2@example.com']
        end
        subject { FactoryGirl.build(:message) }

        it "sends mail after create" do
          mailer = stub(:deliver => true)
          ['test1@example.com', 'test2@example.com'].each do |email|
            FeedbackMailer.expects(:feedback).with(email, subject).returns(mailer)
          end

          subject.save
        end
      end

      describe "when PointlessFeedback.send_emails is false" do
        before  do
          PointlessFeedback.email_feedback = false
        end
        subject { FactoryGirl.build(:message) }

        it "does not send any mail" do
          FeedbackMailer.expects(:feedback).times(0)

          subject.save
        end
      end
    end
  end
end
