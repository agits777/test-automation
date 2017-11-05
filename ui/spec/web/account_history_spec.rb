servers     = %i[local aws1 aws2] & SERVERS
languages   = %i[en fr] & LANGUAGES
breakpoints = %i[desktop tablet mobile] & BREAKPOINTS

servers.product(languages, breakpoints).flatten.each_slice(3) do |s, l, bp|
  describe 'Account History |', folder: '/Web/Account' do
    before(:all) do
      spec_setup(driver: :local, server: s, language: l, breakpoint: bp)
      @data             = Fabricate.build(:checkout_flow, product: :regular, url: @session.url, create: true)
      @ah               = @site.account_history_page
    end

    after(:all) do
      @site.close
    end

    before(:each) do
      @site.after_visit
    end

    context 'Functional |' do
      let(:registered_user) { Fabricate.build(:checkout_flow, product: :regular, url: @session.url, create: true) }
      before(:example, setup: true) do
        login_page = @site.login_page.visit
        login_page.submit_login_form(registered_user.form)
        @checkout_page = @site.checkout_page.visit
        @checkout_page.checkout(user: registered_user, card_info: registered_user.visa_info)
        @site.after_visit
        @ah.visit
      end

      it 'Order Total Is Correct', :setup, test_id: 'BBQ-T889' do
        skip if l == :fr
        price = (registered_user.regular_price*registered_user.hst_on).round(2)
        expect(@ah.total_page.text.scan(/(\d+[.,]\d+)/).flatten.first.to_f).to eql(price)
      end
      it 'Shipping Address Correct', test_id: 'BBQ-T890' do
        expect(@ah.address_elements[2].text).to eql(registered_user.address_form[:address])
      end
      it 'Order Date Correct', test_id: 'BBQ-T891' do
        skip if l == :fr
        expect(@ah.date_ordered.text).to include(@ah.date_placed)
      end
      it 'Estimated Delivery Present', test_id: 'BBQ-T892' do
        expect(@ah.delivery[1]).to be_present
      end
      it 'Product Details Present', test_id: 'BBQ-T894' do
        @ah.view_details
        expect(@ah.product_details).to be_present
      end
      it 'Total Correct On Details Page', test_id: 'BBQ-T896' do
        skip if l == :fr
        price = (registered_user.regular_price*registered_user.hst_on).round(2)
        expect(@ah.order_details[4].text.scan(/(\d+[.,]\d+)/).flatten.first.to_f).to eql(price)
      end
      it 'Back To Order History Link', test_id: 'BBQ-T898' do
        @ah.back_to_history
        expect(@site.b.url).to include(@ah.partial_url)
      end
      it 'Report Problem Link', test_id: 'BBQ-T899' do
        @ah.view_details
        @ah.report_problem
        expect(@site.b.url).to include('contactus')
      end
      it 'Cancel Order', test_id: 'BBQ-T900' do
        skip('Unable to locate cancel link element in DOM, need unique id') # TODO: fix when data provided
      end
      it 'User Can Cancel Order Cancellation', test_id: 'BBQ-T901' do
        skip('Unable to locate cancel link element in DOM, need unique id') # TODO: fix when data provided
      end
    end
  end
end
