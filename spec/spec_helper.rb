# Require application itself to test out
require "soa_doctor"
require "webmock/rspec"

class String
  def deindent
    strip.gsub(/^ */, '')
  end
end
