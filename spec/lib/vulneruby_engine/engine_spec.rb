# frozen_string_literal: true

describe VulnerubyEngine::Engine do
  it 'maintains the engine_name' do
    expect(described_class.engine_name).to(eq('vulneruby_engine'))
  end
end
