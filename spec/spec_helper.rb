$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'exchange_rates_nbp'

require 'timecop'
require 'byebug'

spec_dir = File.expand_path('../', __FILE__)
Dir["#{spec_dir}/support/**/*.rb"].each { |f| require f }
