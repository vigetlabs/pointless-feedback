require "test_helper"
require "rails/generators/test_case"
require "generators/pointless_feedback/views_generator"

class ViewsGeneratorTest < Rails::Generators::TestCase
  tests PointlessFeedback::Generators::ViewsGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert all views are properly created" do
    run_generator
    assert_file 'app/views/pointless_feedback/messages/new.html.erb'
  end
end
