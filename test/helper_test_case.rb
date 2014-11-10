#---
# Excerpted from "Rails Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest for more book information.
#---
require 'action_view/test_case' 

module ActionView
  class TestCase

    setup :setup_response
    def setup_response
      @output_buffer = ""
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      @session = {}
      @request.session = @session
    end

    def session
      @request.session
    end

    def make_response(text)
      @response.body = text
    end
  end
end