# frozen_string_literal: true

require_relative '../test_case'

# This tests covers the startup discovery of Library Discovery in the Inventory
# feature set of the Contrast Agent.
class LibraryDiscoveryTestCase < TestCase
  def self.msg_source
    'update_application'
  end

  def initialize data
    super
    @hash = data['hash']
    @gem = data['file']
    @version = data['version']
    @file_count = data['classCount']
    @url = data['url']
  end

  def name
    @hash
  end

  # Determines if at least one message from our msg_source matches this
  # testcase.
  #
  # @param reported_messages [Array<Hash>] an array of JSON representing the
  #   Update Application reports sent by the Contrast Service during this test
  #   run.
  def assert! reported_messages
    @found = match?(reported_messages)
  end

  private

  # A reported message matches this test if it has the same hash, gem, url
  # version, and file count as we expect.
  #
  # @param reported_messages [Hash] JSON representing an Update Application
  #   reports sent by the Contrast Service during this test run.
  # @return [Boolean]
  def match? reported_messages
    reported_messages.any? do |message|
      libraries = message.fetch('libraries', nil)
      libraries&.any? { |library| library_match?(library) }
    end
  end

  # A reported library matches this test if it has the same hash, gem, url
  # version, and file count as we expect.
  #
  # @param reported_library [Hash] JSON representing an entity from the
  #   `libraries` field of an Update Application report
  # @return [Boolean]
  def library_match? reported_library
    reported_library['hash'] == @hash &&
        reported_library['file'] == @gem &&
        reported_library['version'] == @version &&
        reported_library['classCount'] == @file_count &&
        reported_library['url'] == @url
  end
end
