#---
# Excerpted from "Rails Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest for more book information.
#---
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require "authlogic/test_case"

class ActionController::TestCase
  setup :activate_authlogic
end

class ActiveSupport::TestCase
  
  include ActionView::Helpers::RecordIdentificationHelper
  
  
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  

  # Add more helper methods to be used by all tests here...
  
  def set_session_for(user)
    UserSession.create(user)
  end
  
  def login_as_ben
    set_session_for(users(:ben))
  end
  
  def set_current_project(symbol)
    @request.session[:project_id] = projects(symbol).id
  end
  
  def self.should_match_find_method(named_scope, *args, &block)
    should "match a find method #{named_scope}" do 
      ar_class = self.class.model_class  
      found_objects = ar_class.send(named_scope, *args) 
      assert !found_objects.blank? 
      found_objects.each do |obj|
        assert block.call(obj)
      end 

      unfound_objects = ar_class.all - found_objects
      assert !unfound_objects.blank? 
      unfound_objects.each do |obj|
        assert !block.call(obj)
      end 
    end
  end

end


