# frozen_string_literal: true

class AssessTestCase
  attr_accessor :rule_id, :trigger_class, :trigger_method

  def self.msg_source
    'traces'
  end

  def initialize data
    @rule_id = data['rule_id']
    @dataflow = data['dataflow']
    @trigger_class = data['trigger_class']
    @trigger_method = data['trigger_method']
    @ticket = data['ticket']
    @found = false
  end

  def dataflow?
    !!@dataflow
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
    vulnerabilities = reported_messages.select { |m| m['ruleId'] == rule_id }
    # if this isn't a dataflow rule, then as long as an instance was reported
    # it will pass
    return @found = !vulnerabilities.empty? unless dataflow?

    @found =
      vulnerabilities.any? do |trace_message|
        trace_message['events'].any? do |action|
          signature = action['signature']
          signature['className'] == @trigger_class && signature['methodName'] == @trigger_method
        end
      end
  end
end
