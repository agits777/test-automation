require 'dotenv/load'
require 'pry'
require 'aws-sdk'
require 'ferris'
require 'bb_ruby'
require 'headless'
require 'mailosaur'
require 'fabrication'
require 'securerandom'
require 'watir-scroll'
require 'tmj_formatter'
require 'java-properties'
require 'rspec/eventually'
require 'rspec_junit_formatter'
require 'unicode_utils/upcase'

require_relative '../lib/code'
require_relative 'support/setup'
require_relative 'support/helpers'

Watir.default_timeout = 10
Rspec::Eventually.timeout = 30
Rspec::Eventually.pause = 0.5

TMJFormatter.configure do |c|
  c.base_url    = 'https://jira.lblw.ca'
  c.auth_type   = :basic
  c.project_id  = 'BBQ'
  c.test_run_id = ENV['TESTRUNID'] && !ENV['TESTRUNID'].strip.empty? ? ENV['TESTRUNID'] : nil
  c.username    = 'Ferris'
  c.password    = 'ferris'
  c.result_formatter_options      = { run_only_found_tests: false }
  c.create_test_formatter_options = { update_existing_tests: true, test_owner: 'ferris', custom_labels: ['automated'] }
end

Ferris::Browser.define(:local, :local, geolocation: 2, password_manager: false, ignore_ssl_errors: true, cpu_only: true, no_sandbox: true)

SERVER     = ENV['SERVERS'].split(',').map(&:to_sym)
LANGUAGE   = ENV['LANGUAGES'].split(',').map(&:to_sym)
BREAKPOINT = ENV['BREAKPOINTS'].split(',').map(&:to_sym)

%w[SERVERS LANGUAGES BREAKPOINTS].each do |setting|
  raise "Environment variable '#{setting}' must be set" if ENV[setting].to_s.strip.empty?
  value = ENV[setting].split(',').map(&:to_sym)
  Kernel.const_set(setting, value)
end

MAILBOX_ID        = 'itccrbgf'.freeze
MAILOSAUR_API_KEY = '9fb0fa4abdc7e67'.freeze

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
end

RSpec.configure do |config|
  config.include Helpers::EmailValidation
  config.include Setup
  config.alias_it_behaves_like_to :it_execute, 'execute'
  config.include TMJFormatter::Adaptor
  config.formatter = 'TMJResultFormatter' unless RSpec.configuration.dry_run?
  config.formatter = 'TMJOutputFormatter'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    if ENV['HEADLESS'] == 'true'
      $headless = Headless.new
      $headless.start
    end
  end
  config.after(:suite) { $headless.destroy if ENV['HEADLESS'] == 'true' }
  config.after(:each)  { |scenario| process_screenshot(scenario) unless scenario.exception.nil? }
end

private

def upload_to_s3(file_path)
  s3 = Aws::S3::Resource.new(credentials: Aws::Credentials.new('AKIAI26WBPQQL2Y2EXZQ', '5vSI3sOkyril2gZy6U+dmRxSzplVDPfFfS8e7glu'), region: 'us-east-1')
  obj = s3.bucket('kanoah-evidence').object(File.basename(file_path))
  obj.upload_file(file_path, acl: 'public-read')
  obj.public_url
end

def process_screenshot(scenario)
  file = Tempfile.new(['screenshot', '.png'])
  @site.browser.screenshot.save(file.path)
  file.close
  evidence_url = upload_to_s3(file.path)
  scenario.metadata[:kanoah_evidence] = { title: 'Failure Screenshot', path: "<br /><img src='#{evidence_url}'/>" }
end