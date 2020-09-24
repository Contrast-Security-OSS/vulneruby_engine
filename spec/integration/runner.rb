# Note - just use this in docker for automated exercising of the application

require 'headless'
require 'watir'
require 'webdrivers'
require 'net/http'
require_relative './test_case'

def exercise_rails_app hosts, request_data
  exercise_apps(hosts, request_data, 'vulneruby_engine')
end

def exercise_sinatra_app hosts, request_data
  exercise_apps(hosts, request_data, 'vulneruby_engine/sinatra')
end

def exercise_apps hosts, request_data, path
  puts "Loaded test hosts: #{hosts}"
  browser = Watir::Browser.new(:chrome,
                               headless: true,
                               switches: %w[--no-sandbox])
  hosts.each do |test_host|
    base_path = "http://#{test_host}/#{path}/"
    puts "Base Path: #{base_path}"
    browser.goto base_path
    request_data.each do |test|
      puts "Testing #{test['navigation_name']}"
      browser.link(text: test['navigation_name']).click
      browser.text_field(name: test['input_field_name']).set(test['value']) if test['value']
      browser.button(action: 'submit').click
    end
  end
ensure
  browser.close
end

def verify hosts, test_data
  test_results = {}
  hosts.each do |test_host|
    # Load all the trace JSON blobs into an array
    test_host = test_host.split(':')[0] # remove the :PORT so we can find the right directory
    root_path = ENV['DOCKER'] ? '/run-data' : '../../run-data'
    trace_file_paths = Dir.glob(File.join(root_path, test_host, "messages", "requests", "*-traces.json"))
    messages = trace_file_paths.map { |trace_file_path| JSON.load(File.read(trace_file_path)) }
    puts "Found #{messages.length} trace messages"

    tests = []
    test_data.each do |test_hash|
      test = TestCase.new(test_hash)
      reported_messages = messages.select { |m| m["ruleId"] == test.rule_id }
      test.assert!(reported_messages)
      tests << test
    end

    tests.map{|t|t.print}
    test_results[test_host] = tests
  end
  test_results
end


test_hosts = ['unicorn4']
if test_env_var = ENV['TEST_HOSTS']
  test_hosts = test_env_var.split(',')
end
rails_request_data = JSON.load(File.read("#{__dir__}/rails_requests.json"))
sinatra_request_data = JSON.load(File.read("#{__dir__}/sinatra_requests.json"))
sleep(45)
exercise_rails_app(test_hosts, rails_request_data)
exercise_sinatra_app(test_hosts, sinatra_request_data)
sleep(30)
rails_test_data = JSON.load(File.read("#{__dir__}/rails_test.json"))
sinatra_test_data = JSON.load(File.read("#{__dir__}/sinatra_test.json"))
puts "Waiting for SR messages to drain"
rails_test_result_data = verify(test_hosts, rails_test_data)
sinatra_test_result_data = verify(test_hosts, sinatra_test_data)

rails_not_rejected = rails_test_result_data.values.flatten.reject{|test|test.has_ticket?}
sinatra_test_result_data = sinatra_test_result_data.values.flatten.reject{|test|test.has_ticket?}
all_found = rails_not_rejected.all?{|t|t.found?} && sinatra_test_result_data.all?{|t|t.found?}
exit all_found ? 0 : 1