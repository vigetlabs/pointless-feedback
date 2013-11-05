require 'test_helper'

module PointlessFeedback
  class ApplicationHelperTest < ActionDispatch::IntegrationTest
    describe "main app's named routes" do
      class MainAppApplicationHelperMock
        def foo_path
          '/foo'
        end

        def foo_url
          'http://host/foo'
        end
      end

      class PointlessFeedbackApplicationHelperMock
        include PointlessFeedback::ApplicationHelper

        def main_app
          MainAppApplicationHelperMock.new
        end
      end

      let(:raw_helper) { PointlessFeedbackApplicationHelperMock.new }

      it "outputs named path from the main app" do
        raw_helper.foo_path.must_equal '/foo'
      end

      it "outputs named url from the main app" do
        raw_helper.foo_url.must_equal 'http://host/foo'
      end

      it "raises exception with other routes" do
        proc{ raw_helper.lolwut_path }.must_raise NoMethodError
      end
    end
  end
end
