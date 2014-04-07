# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Crm::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end