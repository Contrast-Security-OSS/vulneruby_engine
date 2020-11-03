# frozen_string_literal: true

class RouteTestCase
  def self.msg_source
    'routes_observed'
  end

  def initialize data
    @signature = data['signature']
    @verb = data['verb']
    @url = data['url']
    @sources = data['sources']
    @found = false
  end

  def found?
    !!@found
  end

  def has_ticket?
    !!@ticket
  end

  def passed?
    found? || has_ticket?
  end

  def to_s
    "#{ @signature } - #{ found? } #{ " - Ticket: #{ @ticket }" if has_ticket? }"
  end

  def assert! route_observed_messages
    @found = match?(route_observed_messages)
  end

  def match? route_observed_messages
    route_observed_messages.any? { |m| message_match?(m) }
  end

  private

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
