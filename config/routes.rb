#---
# Excerpted from "Rails Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest for more book information.
#---
ActionController::Routing::Routes.draw do |map|
  map.resources :status_reports

  map.resources :projects

  
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
