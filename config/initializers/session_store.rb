# frozen_string_literal: true

::Rails.application.config.session_store(:cookie_store, key: 'vulneruby_engine', httponly: false, secure: false)
