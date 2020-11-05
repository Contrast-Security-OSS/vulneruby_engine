# frozen_string_literal: true

require_relative '../test_case'

# This tests covers the runtime discovery of Attacks in the Protect feature set
# of the Contrast Agent.
class AttackTestCase < TestCase
  def self.msg_source
    'activity_application'
  end

  def initialize data
    super
    @rule_id = data['rule_id']
    @input_name = data['input_name']
    @input_value = data['input_value']
  end

  def name
    @rule_id
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

  # The messages match if any has the same rule id and a sample with the same
  # input name and value.
  #
  # @param reported_messages [Hash] JSON representing an Activity Application
  #   reports sent by the Contrast Service during this test run.
  # @return [Boolean]
  def match? reported_messages
    reported_messages&.each do |activity_message|
      attackers = activity_message.fetch('defend', nil)&.fetch('attackers', nil)
      next unless attackers

      attackers.each do |reported_attacker|
        return true if attack_match?(reported_attacker)
      end
    end
    false
  end

  # A reported attack matches this test if it has the same rule id and a sample
  # with the same input name and value.
  #
  # @param reported_attacker [Hash] JSON representing an entity from the
  #   `defend.attackers` field of an Activity Application report
  # @return [Boolean]
  def attack_match? reported_attacker
    messages = reported_attacker.fetch('protectionRules', nil)&.fetch(@rule_id, nil)
    return unless messages

    probes = messages['ineffective']&.fetch('samples', nil)
    exploits = messages['exploited']&.fetch('samples', nil)
    sample_match?(probes) || sample_match?(exploits)
  end

  # A reported sample matches this test if it has the same input name and value
  # as this test.
  #
  # @param reported_samples [Hash] JSON representing an entity from the
  #   `defend.attackers.*.samples` field of an Activity Application report
  # @return [Boolean]
  def sample_match? reported_samples
    return false unless reported_samples

    reported_samples.each do |reported_sample|
      input = reported_sample['input']
      return true if input['name'] == @input_name && input['value'] == @input_value
    end
    false
  end
end
