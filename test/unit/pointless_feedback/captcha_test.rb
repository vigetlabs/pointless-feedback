require 'test_helper'

module PointlessFeedback
  class CaptchaTest < ActiveSupport::TestCase

    describe ".pass?" do
      setup    do
        PointlessFeedback.google_captcha_secret_key = "super-secret"
        @url  = "https://www.google.com/recaptcha/api/siteverify"
        @body = {
          secret:   "super-secret",
          response: "fake-response"
        }
      end

      teardown do
        PointlessFeedback.google_captcha_secret_key = nil
        @url  = nil
        @body = nil
      end

      subject  { PointlessFeedback::Captcha }

      it "returns true if Google response is true" do
        success  = { "success" => true }
        response = stub(body: success.to_json)

        Typhoeus.expects(:post).with(@url, body: @body).returns(response)

        assert subject.pass?("fake-response")
      end

      it "returns false if Google response is true" do
        failure  = { "success" => false }
        response = stub(body: failure.to_json)

        Typhoeus.expects(:post).with(@url, body: @body).returns(response)

        refute subject.pass?("fake-response")
      end
    end

  end
end
