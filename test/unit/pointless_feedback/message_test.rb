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
      subject { FactoryGirl.build(:message) }

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

    describe "validating email" do
      subject { FactoryGirl.build(:message) }

      it "allows a valid email address" do
        subject.email_address = 'test@example.com'

        assert subject.valid?
      end

      it "does not allow invalid emails address" do
        subject.email_address = 'test@example'
        assert subject.invalid?

        subject.email_address = 'test.com'
        assert subject.invalid?

        subject.email_address = 'come on'
        assert subject.invalid?
      end
    end

    describe "validating against spam" do
      subject { FactoryGirl.build(:message) }

      it "allows descriptions with no links" do
        subject.description = "I have no links!"

        assert subject.valid?
      end

      it "does not allow descriptions with 3 or more links" do
        subject.description = 'CXYz73 <a href="http://kniuzeqqywrg.com/">kniuzeqqywrg</a>, [url=http://kdvfwnevgkcq.com/]kdvfwnevgkcq[/url], [link=http://fibhlwzwvxjr.com/]fibhlwzwvxjr[/link], http://pebecsefhsmz.com/'

        assert subject.invalid?
      end
    end

    describe "export_feedback" do
      describe "when PointlessFeedback.email_feedback is true" do
        before  do
          PointlessFeedback.email_feedback = true
          PointlessFeedback.to_emails = ['test1@example.com', 'test2@example.com']
        end

        subject { FactoryGirl.build(:message) }

        it "sends mail after create" do
          mailer = stub(:deliver_now => true)
          FeedbackMailer.expects(:feedback).with(subject).returns(mailer)

          subject.save
        end

        describe "when the honeypot field is not nil" do
          it "does not send mail after create" do
            subject.contact_info = "I'm a spam bot!"
            FeedbackMailer.expects(:feedback).never

            subject.save
          end
        end

        describe "when the description contains an invalid word" do
          it "does not send mail after create" do
            PointlessFeedback.invalid_words = ['nymphomania']

            subject.description = "I have nymphomania."
            FeedbackMailer.expects(:feedback).never

            subject.save
          end
        end
      end

      describe "when PointlessFeedback.email_feedback is false" do
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
