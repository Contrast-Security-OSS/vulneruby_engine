# frozen_string_literal: true

# This class is the base for all of our tests. It'll be used to assert that a
# message was sent from the Contrast Service to the Contrast UI for a given
# feature of the Contrast Agent.
#
# A passing test means that a message of the given type matched the given
# criteria, which means it has at least the data expected in the format given.
# It does not mean that the message does not have other data or purposes.
class TestCase

  # A msg_source is the file extension that should be checked by this test. For
  # instance, if the message looks like `20201104-140910.621-foo.json`, then
  # the source here should be `foo`.
  #
  # @return [String] the name of the JSON file to match on for this test
  def self.msg_source
    raise NoMethodError, 'This method should be overridden with the message type to which this test pertains.'
  end

  # Determines if at least one message from our msg_source matches this
  # testcase.
  #
  # @param _reported_messages [Array<Hash>] an array of JSON representing the
  #   messages of the .msg_source type that were sent to the Contrast UI during
  #   the application execution
  def assert! _reported_messages
    raise NoMethodError, 'This method should be overridden with the assertion needed to compare the TestCase to the messages.'
  end

  # Some name used in the #to_s of this test to tell it from others of its type
  #
  # @return [String]
  def name
    raise NoMethodError, 'This method should be overridden with the unique identifier for this test.'
  end

  def initialize data
    @found = false
    @ticket = data['ticket']
  end

  # Has a message that matches this test case been reported?
  #
  # @return [Boolean]
  def found?
    @found
  end

  # Is there a ticket associated with this test, meaning it is expected to fail
  # or its result is not to impact the testsuite?
  #
  # @return [Boolean]
  def ticketed?
    !@ticket.nil?
  end

  # A test passes if it's been found or if its results should not be counted
  # against the suite.
  #
  # @return [Boolean]
  def passed?
    found? || ticketed?
  end

  def to_s
    "#{ name } - #{ found? } #{ " - Ticket: #{ @ticket }" if ticketed? }"
  end

end