require 'test_helper'

class FeedbackSubmissionTest < ActionDispatch::IntegrationTest
  fixtures :all

  describe "submitting feedback" do
    before do
      visit "/pointless_feedback"

      fill_in_fields

      click_on "Submit"
    end

    test "redirects to the root path" do
      assert_equal current_path, "/"
    end

    test "thanks message is displayed" do
      within('body') do
        assert_match 'Thanks for your feedback!', text
      end
    end
  end

  describe "submitting feedback with the honeypot field filled in" do
    before do
      visit "/pointless_feedback"

      fill_in_fields
      fill_in "message_contact_info", :with => "I'm a spam bot!"

      click_on "Submit"
    end

    test "redirects to the root path" do
      assert_equal current_path, "/"
    end

    test "thanks message is displayed" do
      within('body') do
        assert_match 'Thanks for your feedback!', text
      end
    end
  end

  def fill_in_fields
    fill_in "Name",          :with => "Eli"
    fill_in "Email address", :with => "eli@example.com"
    select "Other",          :from => "Topic"
    fill_in "Description",   :with => "This site is awful"
  end

end
