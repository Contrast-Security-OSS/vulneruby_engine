# frozen_string_literal: true

require_relative '../test_case'

# This tests covers the runtime discovery of Library Usage in the Inventory
# feature set of the Contrast Agent.
class LibraryUsageTestCase < TestCase
  def self.msg_source
    'activity_application'
  end

  def initialize data
    super
    @hash = data['hash']
    @files = data['files']
  end

  def name
    @hash
  end

  # Determines if at least one message from our msg_source matches this
  # testcase.
  #
  # @param reported_messages [Array<Hash>] an array of JSON representing the
  #   Activity Application reports sent by the Contrast Service during this
  #   test run.
  def assert! reported_messages
    @found = match?(reported_messages)
  end

  private

  # A reported message matches this test if it has the same hash and all of the
  # expected classes. It may have more classes than we expect, but it must at
  # least have those
  #
  # @param reported_messages [Hash] JSON representing an Activity Application
  #   reports sent by the Contrast Service during this test run.
  # @return [Boolean]
  def match? reported_messages
    reported_messages.any? do |message|
      libraries = message.fetch('inventory', nil)&.fetch('libraries', nil)
      libraries&.any? { |library| library_match?(library) }
    end
  end

  # A reported library matches this test if it has the same hash and all of the
  # expected classes. It may have more classes than we expect, but it must at
  # least have those
  #
  # @param reported_library [Hash] JSON representing an entity from the
  #   `inventory.libraries` field of an Activity Application report
  # @return [Boolean]
  def library_match? reported_library
    return false unless reported_library['sha1'] == @hash
    return true if @files.empty?

    reported_files = reported_library['classes']
    @files.all? { |expected| reported_files.include?(expected) }
  end
end
