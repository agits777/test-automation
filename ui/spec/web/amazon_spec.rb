servers     = %i[local aws1 aws2 prod] & SERVERS
languages   = %i[en fr] & LANGUAGES
breakpoints = %i[desktop tablet mobile] & BREAKPOINTS

servers.product(languages, breakpoints).flatten.each_slice(3) do |s, l, bp|
  describe 'Amzon |' do
    before(:all) do
      spec_setup(driver: :local, server: s, language: l, breakpoint: bp)
      # @data             = Fabricate.build(:checkout_flow, product: :regular, url: @session.url, create: true)
      @a = @site.amazon_page
    end

    after(:all) do
      @site.close
    end

    before(:each) do
      @a.visit
    end
    context 'Test Amazon' do
      it 'Order Total Is Correct', :setup, test_id: 'BBQ-T889' do
        binding.pry
      end

    end
    end
  end
