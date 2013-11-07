require 'test_helper'

class MainAppRootUrlTest < ActionDispatch::IntegrationTest
  test "root_url link points to main_app.root_url" do
    visit "/pointless_feedback"

    assert page.has_link?("Homepage", :href => current_host + "/")
  end
end
