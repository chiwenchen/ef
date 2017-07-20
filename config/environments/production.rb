Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => Setting.domain }
  config.action_mailer.smtp_settings = {
    # address:              'smtp.mandrillapp.com',
    # port:                 587,
    # user_name:            Setting.mandrill_user_name,
    # password:             Setting.mandrill_api_key,
    # authentication:       'plain',
    # enable_starttls_auto: true
    address: 'smtp.mailgun.org',
    port:                 587,
    user_name: 'cwchen2000@gmail.com',
    domain: 'sandbox4124b25a8f214c8892346bb9e6721c06.mailgun.org',
    password: 'pubkey-fad9fbd7d2149c07fe083bbe37516cab',
    authentication:       'plain',
    enable_starttls_auto: true
  }
end
