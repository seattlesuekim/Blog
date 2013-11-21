$LOAD_PATH.unshift 'lib'

# This is optional
require 'rack/cache'
use Rack::Cache

require 'blog'
run Blog