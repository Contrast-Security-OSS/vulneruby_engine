class TestCase
  attr_accessor :rule_id, :trigger_class, :trigger_method
  def initialize data
    @rule_id = data['rule_id']
    @dataflow = data['dataflow']
    @trigger_class = data['trigger_class']
    @trigger_method = data['trigger_method']
    @found = false
  end

  def dataflow?
    !!@dataflow
  end

  def found?
    !!@found
  end

  def print
    puts "#{rule_id} - #{found?}"
  end

  def assert! reported_messages
    unless dataflow? # as long as an instance was reported it will pass
      @found = reported_messages.length > 0
      return
    end

    @found = reported_messages.any? do |trace_message|
      trace_message['events'].any? do |action|
        signature = action['signature']
        signature['className'] == @trigger_class && signature['methodName'] == @trigger_method
      end
    end

  end
end