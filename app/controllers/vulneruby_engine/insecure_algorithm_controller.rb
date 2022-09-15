# frozen_string_literal: true

module VulnerubyEngine
  # Entry point for the Insecure Hash Algorithm and Random tests
  class InsecureAlgorithmController < ApplicationController
    SOME_HARDCODED_PASSWORD = 'BadPracticeOfStoringPasswordInRepo'
    SOME_HARDCODED_KEY = [1,2,3]
    public_constant :SOME_HARDCODED_KEY
    public_constant :SOME_HARDCODED_PASSWORD
    def index
      render('layouts/vulneruby_engine/insecure_algorithm/index')
    end

    def run
      @result = {
          digest: Vulneruby::Trigger::CryptoBadMac.run_digest_md5,
          random: Vulneruby::Trigger::CryptoWeakRandomness.run_rand
          cipher: Vulneruby::Trigger::CryptoBadCipher.run_bad_cipher
      }

      render('layouts/vulneruby_engine/insecure_algorithm/run')
    end
  end
end
