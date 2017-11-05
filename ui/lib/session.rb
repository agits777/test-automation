# encoding: utf-8

module BB
  class Session
    attr_reader :url, :language, :breakpoint, :width

    SERVERS     = { prod: { en: 'https://www.amazon.ca', fr: 'https://www.galeriebeaute.ca' },
                    local: { en: 'https://www.amazon.ca', fr: 'https://local.galeriebeaute.ca:9002' },
                    aws1: { en: 'https://aws1-beautyboutique.lblw.ca',  fr: 'https://aws1-galeriebeaute.lblw.ca/' },
                    aws2: { en: 'https://aws2-beautyboutique.lblw.ca',  fr: 'https://aws2-galeriebeaute.lblw.ca' } }.freeze

    LANGUAGES   = { en: :en, fr: :fr }.freeze

    BREAKPOINTS = { mobile:  { name: :mobile,  width: 650  },
                    tablet:  { name: :tablet,  width: 950  },
                    desktop: { name: :desktop, width: 1200 } }.freeze

    def initialize(server:, language:, breakpoint:)
      configure_breakpoint breakpoint
      configure_language language
      configure_url server
    end

    private

    def configure_breakpoint(breakpoint)
      @breakpoint = BREAKPOINTS.fetch(breakpoint.to_sym).fetch :name
      @width      = BREAKPOINTS.fetch(breakpoint.to_sym).fetch :width
    end

    def configure_language(language)
      @language = LANGUAGES.fetch(language.to_sym)
    end

    def configure_url(server)
      @url = SERVERS.fetch(server.to_sym).fetch(@language)
    end
  end
end
