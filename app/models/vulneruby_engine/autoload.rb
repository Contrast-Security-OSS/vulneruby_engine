# frozen_string_literal: true

module VulnerubyEngine
  class Autoload

    attr_accessor :result

    SOME_HARDCODED_PASSWORD = 'BadPracticeOfStoringPasswordInRepo'
    SOME_HARDCODED_KEY = 'BadPracticeOfStoringKeyInRepo'
    public_constant :SOME_HARDCODED_KEY
    public_constant :SOME_HARDCODED_PASSWORD

    def initialize
      super
      @result = {
        digest: Vulneruby::Trigger::CryptoBadMac.run_digest_md5,
        random: Vulneruby::Trigger::CryptoWeakRandomness.run_rand
      }
    end

  end
end