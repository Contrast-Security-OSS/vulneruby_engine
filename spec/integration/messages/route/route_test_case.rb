# frozen_string_literal: true

require_relative '../test_case'

# This tests covers the runtime discovery of Observed Routes in the Assess
# feature set of the Contrast Agent.
class RouteTestCase < TestCase
  def self.msg_source
    'routes_observed'
  end

  def initialize data
    super
    @signature = data['signature']
    @verb = data['verb']
    @url = data['url']
    @sources = data['sources']
  end

  def name
    @signature
  end

  def assert! route_observed_messages
    @found = match?(route_observed_messages)
  end

  private

  def match? route_observed_messages
    route_observed_messages.any? { |m| message_match?(m) }
  end

  # A message matches if it has the same signature, verb, and url and all of
  # the sources that we're checking for.
  #
  # @param route_observed_message [Hash] a hash representing a routes_observed
  #   sent to the Contrast UI
  # @return [Boolean]
  def message_match? route_observed_message
    route_observed_message['signature'] == @signature &&
        route_observed_message['verb'] == @verb &&
        route_observed_message['url'] == @url &&
        source_match?(route_observed_message)
  end

  # Sources match so long as all the ones we're searching for are found. There
  # can be more than what we assert, but not less.
  #
  # @param route_observed_message [Hash] a hash representing a routes_observed
  #   sent to the Contrast UI
  # @return [Boolean]
  def source_match? route_observed_message
    return true if @sources.nil? || @sources.empty?

    message_sources = route_observed_message['sources']
    # make sure that all of the sources we're told to check...
    @sources.all? do |source|
      # show up in any of the sources for this message
      message_sources.any? { |message_source| message_source == source }
    end
  end
end
