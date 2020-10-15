# frozen_string_literal: true

class ProtectTestCase # rubocop:disable Lint/ConstantResolution
  attr_accessor :rule_id, :trigger_class, :trigger_method

  def self.msg_source
    'activity_application'
  end

  def initialize data
    @rule_id = data['rule_id']
    @input_name = data['input_name']
    @input_value = data['input_value']
    @ticket = data['ticket']
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
    "#{ rule_id } - #{ found? } #{ " - Ticket: #{ @ticket }" if has_ticket? }"
  end

  def assert! reported_messages
    @found = match?(reported_messages)
  end

  def match? reported_messages
    reported_messages&.each do |activity_message|
      attackers = activity_message.fetch('defend', nil)&.fetch('attackers', nil)
      next unless attackers

      attackers.each do |attacker_message|
        messages = attacker_message.fetch('protectionRules', nil)&.fetch(rule_id, nil)
        next unless messages

        probes = messages['ineffective']&.fetch('samples', nil)
        exploits = messages['exploited']&.fetch('samples', nil)
        return true if reported?(probes) || reported?(exploits)
      end
    end
    false
  end

  private

  def reported? samples
    return false unless samples

    samples.each do |sample|
      input = sample['input']
      return true if input['name'] == @input_name && input['value'] == @input_value
    end
    false
  end
end
