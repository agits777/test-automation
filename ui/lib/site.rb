# encoding: utf-8

module BB
  class Site < Ferris::Site
    # Pages
    pg(:pd_page,                 BB::PDP)
    pg(:login_page,              BB::Login)
    pg(:account_page,            BB::Account)
    pg(:checkout_page,           BB::Checkout)
    pg(:registration_page,       BB::Registration)
    pg(:search_results,          BB::SearchResults)
    pg(:order_confirmation_page, BB::OrderConfirmation)
    pg(:account_payment_page,    BB::AccountPayment)
    pg(:newsletter_page,         BB::Newsletter)
    pg(:account_shipping_page,   BB::AccountShipping)
    pg(:privacy_policy_page,     BB::PrivacyPolicy)
    pg(:terms_of_use_page,       BB::TermsOfUse)
    pg(:account_settings_page,   BB::AccountSettings)
    pg(:cart_page,               BB::CartPage)
    pg(:chanel_page,             BB::Chanel)
    pg(:product_finder_lrp_page, BB::ProductFinderLRP)
    pg(:product_finder_vic_page, BB::ProductFinderVIC)
    pg(:store_finder_page,       BB::StoreFinder)
    pg(:account_history_page,    BB::AccountHistory)
    pg(:amazon_page,             BB::Amazon)

    # Regions
    rgn(:site_header, BB::SiteHeader) { b.header }
    rgn(:site_footer, BB::SiteFooter) { b.footer }

    def after_visit # TODO: Remove when BBQ-2910 is fixed
      # Watir::Wait.until { b.body.attribute_value('class').include?('js-loaded') }
      sleep 1
    end

    def ensure_loaded # TODO: Remove when BBQ-2910 is fixed
      sleep 2
    end

    def logged_in?
      status = b.execute_script('return this.dataLayer.userStatus')
      case status
      when 'hardLoggedIn' then true
      else false
      end
    end

    def search(product)
      site_header.search(product)
    end
  end
end
