# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:simple_date] = "%Y年%m月%d日"
Time::DATE_FORMATS[:full_datetime] = "%Y.%m.%d %p %I:%M"