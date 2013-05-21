# Require application itself to test out
require "healthcheck"
require "webmock/rspec"

class String
  def deindent
    strip.gsub(/^ */, '')
  end
end
