require "test_helper"
require "rails/generators/test_case"
require "generators/pointless_feedback/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests PointlessFeedback::Generators::InstallGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert all files are properly created" do
    run_generator
    assert_file "config/initializers/pointless_feedback.rb"
  end
end
