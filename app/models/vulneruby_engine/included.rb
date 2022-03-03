module VulnerubyEngine
  # Our base record for the vulnerable application. We'll modify common
  # settings here to add new SQL and Serialization vulnerabilities as we begin
  # to test them.
  module Included

    attr_accessor :result

    SOME_HARDCODED_PASSWORD = 'BadPracticeOfStoringPasswordInRepo'
    SOME_HARDCODED_KEY = 'BadPracticeOfStoringKeyInRepo'
    public_constant :SOME_HARDCODED_KEY
    public_constant :SOME_HARDCODED_PASSWORD
    def Included.included(base)
      def run
        @result = {
          digest: Vulneruby::Trigger::CryptoBadMac.run_digest_md5,
          random: Vulneruby::Trigger::CryptoWeakRandomness.run_rand
        }
        render('layouts/vulneruby_engine/included/run')
      end
    end
  end
end
