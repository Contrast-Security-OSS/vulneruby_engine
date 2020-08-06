# Note - just use this in docker for automated exercising of the application

require 'headless'
require 'watir'
require 'webdrivers'
require 'net/http'
require_relative './test_case'

def exercise_apps hosts, request_data
  puts "Loaded test hosts: #{hosts}"
  browser = Watir::Browser.new(:chrome,
                               headless: true,
                               switches: %w[--no-sandbox])
  hosts.each do |test_host|
    browser.goto "http://#{test_host}:3010/vulneruby_engine/"
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
  hosts.each do |test_host|
    # Load all the trace JSON blobs into an array
    #
    root_path = ENV['DOCKER'] ? '/run-data' : '../../run-data'
    trace_file_paths = Dir.glob(File.join(root_path, test_host, "requests", "*-traces.json"))
    messages = trace_file_paths.map { |trace_file_path| JSON.load(File.read(trace_file_path)) }

    tests = []
    test_data.each do |test_hash|
      test = TestCase.new(test_hash)
      reported_messages = messages.select { |m| m["ruleId"] == test.rule_id }
      test.assert!(reported_messages)
      tests << test
    end

    tests.map{|t|t.print}
  end
end


test_hosts = ['unicorn4']
if test_env_var = ENV['TEST_HOSTS']
  test_hosts = test_env_var.split(',')
end
request_data = JSON.load(File.read("#{__dir__}/requests.json"))
sleep(45)
exercise_apps(test_hosts, request_data)
sleep(30)
test_data = JSON.load(File.read("#{__dir__}/test.json"))
puts "Waiting for SR messages to drain"
verify(test_hosts, test_data)