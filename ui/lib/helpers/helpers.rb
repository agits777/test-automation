# encoding: utf-8

module BB
  module Helpers
    def enter_credit_card(card_num)
      card_num.scan(/.{1,4}/).each do |num|
        card_number.send_keys num
      end
    end

    def search(search_term)
      @site.search(search_term)
    end

    def exposed_search(search_term)
      @site.search_results.exposed_search.set search_term
      @site.b.send_keys :enter
      end

    def update_password
      @account_settings.fill_form(@data.account_password)
      @account_settings.save_password
      @account_settings.password_form_transition
      @site.clear_cookies
      @site.login_page.tap do |page|
        page.visit
        @site.login_page.fill!(email: @data.email, password: @data.account_password[:new_password])
        page.submit_form
      end
    end

    def update_email
      @account_settings.fill_form(@data.email_new)
      @account_settings.save_changes
      @account_settings.edit_form_transition
      @site.clear_cookies
      @site.login_page.tap do |page|
        page.visit
        @site.login_page.fill!(email: @data.account_details[:new_email], password: @data.password)
        page.submit_form
      end
    end

    def re_login
      @site.clear_cookies
      @site.login_page.tap do |page|
        page.visit
        @site.login_page.fill!(email: @data.email, password: @data.password)
        page.submit_form
      end
    end

    def get_num(string)
      string.match('\d+')[0].to_i
    end
  end
end
