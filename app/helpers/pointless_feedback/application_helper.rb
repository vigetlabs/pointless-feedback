module PointlessFeedback
  module ApplicationHelper
    delegate :root_url, :root_path, :to => :main_app

    # Can search for named routes directly in the main app, omitting
    # the "main_app." prefix
    def method_missing(method, *args, &block)
      if main_app_url_helper?(method)
        main_app.send(method, *args)
      else
        super
      end
    end

    def respond_to_missing?(method, include_all)
      main_app_url_helper?(method) || super
    end


    private

    def main_app_url_helper?(method)
      /\A\w+(_path|_url)\z/ === method.to_s && main_app.respond_to?(method)
    end
  end
end
