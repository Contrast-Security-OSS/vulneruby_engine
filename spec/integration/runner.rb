# frozen_string_literal: true

# Note - just use this in docker for automated exercising of the application

require 'headless'
require 'watir'
require 'webdrivers'
require 'net/http'
require_relative './messages/attack/attack_test_case'
require_relative './messages/library_discovery/library_discovery_test_case'
require_relative './messages/library_usage/library_usage_test_case'
require_relative './messages/route/route_test_case'
require_relative './messages/vulnerability/vulnerability_test_case'


def exercise_rails_app hosts
  exercise_apps(hosts, 'rails', 'vulneruby_engine')
end

def exercise_sinatra_app hosts
  exercise_apps(hosts, 'sinatra', 'vulneruby_engine/sinatra')
end

def exercise_apps hosts, framework, path
  puts("Loaded test hosts: #{ hosts }")
  request_data = JSON.parse(File.read("#{ __dir__ }/#{ framework }_requests.json"))
  browser = Watir::Browser.new(:chrome, headless: true, switches: %w[--no-sandbox])
  hosts.each do |test_host|
    exercise_host(browser, test_host, request_data, path)
  end
ensure
  browser.close
end

def exercise_host browser, test_host, request_data, path
  base_path = "http://#{ test_host }/#{ path }/"
  puts("Base Path: #{ base_path }")
  browser.goto(base_path)
  request_data.each do |test|
    exercise_request(browser, test)
  end
end

def exercise_request browser, test
  puts("\tTesting #{ test['navigation_name'] }")
  browser.link(text: test['navigation_name']).click
  browser.text_field(name: test['input_field_name']).set(test['value']) if test['value']
  browser.button(action: 'submit').click
end

def verify hosts, test_data, test_class
  hosts.each_with_object({}) do |test_host, test_results|
    puts(test_host.to_s)
    messages = find_messages(test_host, test_class.msg_source)
    tests = generate_tests(test_class, test_data)
    tests.each do |test|
      test.assert!(messages)
      puts("\t#{ test }")
    end
    test_results[test_host] = tests
  end
end

# find all the messages matching the given name pattern from the given test
# application
#
# @param test_host [String] the host that should have sent the messages. note
#   that this host name cannot contain a `:` character.
# @param msg_type [String] the type of message being found
# @return [Array<String>] the files on the given host that match the given name
def find_messages test_host, msg_type
  # Load all the trace JSON blobs into an array
  # remove the :PORT so we can find the right directory
  test_host = test_host.split(':')[0]
  root_path = ENV['DOCKER'] ? '/run-data' : "#{ __dir__ }/../../run-data"
  join = File.join(root_path, test_host, 'messages', 'requests', "*-#{ msg_type }.json")
  trace_file_paths = Dir.glob(join)
  trace_file_paths.map { |trace_file_path| JSON.parse(File.read(trace_file_path)) }
end

# Convert the hashes of the test data into the given type
#
# @param test_class [Class] the class type to build with the given hashes
# @param test_data [Array<Hash>] the data used to generate the test classes
# @return [Array<>] the generated test classes
def generate_tests test_class, test_data
  test_data.map { |test_hash| test_class.new(test_hash) }
end

begin
  test_hosts = ENV['TEST_HOSTS'] ? ENV['TEST_HOSTS'].split(',') : ['localhost:3000']
  puts("Testing #{ test_hosts }")
  puts('Waiting for Docker container startup')
  sleep(60)
  puts('Exercising the applications')
  # Exercise the applications
  exercise_rails_app(test_hosts)
  exercise_sinatra_app(test_hosts)
  puts('Waiting for SR messages to drain')
  sleep(90)

  # Assert Results Results
  web_frameworks = %w[rails sinatra]
  features = {
      attack: AttackTestCase,
      library_discovery: LibraryDiscoveryTestCase,
      library_usage: LibraryUsageTestCase,
      route: RouteTestCase,
      vulnerability: VulnerabilityTestCase
  }

  failed = false
  web_frameworks.each do |framework|
    features.each_pair do |feature, test_class|
      # load the framework test
      test_data = JSON.parse(File.read("#{ __dir__ }/messages/#{ feature }/#{ framework }_test.json"))
      # verify the expected results
      puts("Verifying #{ framework } - #{ feature }")
      result_data = send(:verify, test_hosts, test_data, test_class) # rubocop:disable Style/Send
      # and if any were not found, then this test failed
      if result_data.values.flatten.all?(&:passed?)
        puts("Completed #{ framework } - #{ feature } tests: pass.")
      else
        puts("Completed #{ framework } - #{ feature } tests: fail.")
        failed = true
      end
    end
  end

  exit(failed ? 1 : 0)
rescue StandardError => e
  puts('Test runner failed')
  puts(e)
  puts(e.backtrace.join("\n"))
  exit(1)
end
