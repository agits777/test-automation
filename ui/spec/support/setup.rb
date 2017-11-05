# encoding: utf-8

require 'forwardable'

module Setup
  extend Forwardable
  def_delegators :@session, :breakpoint, :language, :url, :width

  def spec_setup(**args)
    TMJFormatter.config.environment = "#{args[:server]} - CHROME - #{args[:breakpoint]} - #{args[:language]}".upcase
    puts TMJFormatter.config.environment
    configure_session(args)
    configure_site(args[:driver])
    # configure_localization(lang: language)
  end

  def configure_session(args)
    @session = BB::Session.new(server: args[:server], language: args[:language], breakpoint: args[:breakpoint])
  end

  def configure_site(driver)
    @site = BB::Site.new(driver: driver, session: @session, url: url, size: "#{width},1200")
  end

  # def configure_localization(lang:)
  #   @localization = JavaProperties.load("spec/support/localization/base/base_#{lang}.properties")
  # end
end
