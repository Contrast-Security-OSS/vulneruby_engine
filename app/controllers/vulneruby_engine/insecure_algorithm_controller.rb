# frozen_string_literal: true
module VulnerubyEngine
  # Entry point for the CMD Injection tests
  class InsecureAlgorithmController < ApplicationController
    SOME_HARDCODED_PASSWORD = "BadPracticeOfStoringPasswordInRepo"
    SOME_HARDCODED_KEY = "BadPracticeOfStoringKeyInRepo"
    def index
      render('layouts/vulneruby_engine/insecure_algorithm/index')
    end

    def run
      @result = {
          digest: Vulneruby::Trigger::CryptoBadMac.run_digest_md5,
          random: Vulneruby::Trigger::CryptoWeakRandomness.run_rand
      }

      render('layouts/vulneruby_engine/insecure_algorithm/run')
    end
  end
end
