require 'uri'
require 'net/http'
require 'json'

module PointlessFeedback
  class Captcha
    def self.pass?(captcha_response)
      new(captcha_response).pass?
    end

    def initialize(captcha_response)
      @captcha_response = captcha_response
    end

    def pass?
      JSON.parse(response.body)["success"] == true
    end

    private

    def response
      @response ||= Net::HTTP.post_form(uri, body)
    end

    def uri
      URI("https://www.google.com/recaptcha/api/siteverify")
    end

    def body
      {
        secret:   PointlessFeedback.google_captcha_secret_key,
        response: @captcha_response
      }
    end
  end
end
