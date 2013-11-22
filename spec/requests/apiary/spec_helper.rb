require "requests/spec_helper"
# This file will be required by
# all file in this directory and subdirectory

RSpec.configure do |config|
  config.before(:each) do
    set_uuid_start(*(1..5).to_a)
  end
end
