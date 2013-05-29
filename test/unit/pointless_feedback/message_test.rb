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
  end
end
