require 'test_helper'

class FeedbackSubmissionTest < ActionDispatch::IntegrationTest
  fixtures :all

  describe "submitting feedback" do
    before do
      visit "/pointless_feedback"

      fill_in "Name",          :with => "Eli"
      fill_in "Email address", :with => "eli@example.com"
      select "Other",          :from => "Topic"
      fill_in "Description",   :with => "This site is awful"

      click_on "Create Message"
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

end
