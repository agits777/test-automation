# encoding: utf-8

module BB
  class Checkout < Ferris::Page
    partial_url { '/checkout' }

    # address info
    el(:first_name)  { b.text_field(id: 'firstName') }
    el(:last_name)   { b.text_field(id: 'lastName') }
    el(:address)     { b.text_field(id: 'new-address') }
    el(:apt)         { b.text_field(id: 'apt') }
    el(:city)        { b.text_field(id: 'city') }
    el(:province)    { b.select(id: 'province') }
    el(:postal)      { b.text_field(id: 'postalCode') }
    el(:phone)       { b.text_field(id: 'phone') }
    el(:email)       { b.text_field(id: 'email') }

    # payment info
    el(:name_on_card)      { b.text_field(id: 'nameOnCard') }
    el(:card_number)       { b.text_field(id: 'cardNumber') }
    el(:expiration_month)  { b.select(id: 'cardExpirationMonth') }
    el(:expiration_year)   { b.select(id: 'cardExpirationYear') }
    el(:cvv)               { b.text_field(id: 'cardSecurityCode') }
    el(:save_card)         { b.checkbox(id: 'savePaymentForFuture') }
    el(:use_saved_shipping) { b.checkbox(id: 'copy-address') }
    el(:shipping_options) { b.divs(xpath: '//div[@class="shipping-options-section"]//div[@class="checkbox-radio-ctrl"]') }

    el(:place_order) { b.button(class: 'order-review-continue-btn') }

    def initializer
      case site.args[:session].breakpoint
      when :mobile then
        class << self
          el(:sample_continue) { b.button(xpath: '//div[@class="mobileOnly"]//button[contains(@class,"select-sample-continue-btn")]') }
          el(:shipping_continue) { b.button(xpath: '//div[@class="mobileOnly"]//button[contains(@class,"shipping-continue-btn")]') }
          el(:payment_continue) { b.button(xpath: '//div[@class="mobileOnly"]//button[contains(@class,"payment-continue-btn")]') }
          el(:place_order)      { b.button(xpath: '//div[@class="mobileOnly"]//button[contains(@class,"order-review-continue-btn")]') }
        end     
      else
        class << self
          el(:sample_continue)   { b.button(xpath: '//form[@id="checkout-select-sample-form"]//button[contains(@class,"select-sample-continue-btn")]') }
          el(:shipping_continue) { b.button(xpath: '//form[@id="checkout-new-shipping-signed-in-form"]//button[contains(@class,"shipping-continue-btn")]') }
          el(:payment_continue) { b.button(xpath: '//div[contains(@class,"desktopOnly")]//button[contains(@class, "payment-continue-btn")]') }
          el(:place_order)      { b.button(xpath: '//div[contains(@class,"desktopOnly")]//button[contains(@class,"order-review-continue-btn")]') }
        end
      end
    end

    def continue_to_shipping
      sleep 1 # TODO: fix this when BBQ-2910 is finished
      sample_continue.click
    end

    def continue_to_payment
      sleep 1 # TODO: fix this when BBQ-2910 is finished
      shipping_continue.click
    end

    def continue_to_review_order
      sleep 1 # TODO: fix this when BBQ-2910 is finished
      payment_continue.click
    end

    def submit_order
      Watir::Wait.until { place_order.present? }
      place_order.click
      Watir::Wait.while { place_order.present? }
    end

    def checkout(user:, card_info:)
      continue_to_shipping
      fill_shipping_info(user.address_form)
      Watir::Wait.until { shipping_options.size == 3 }
      continue_to_payment
      fill_payment_info(card_info)
      submit_order
    end

    def fill_shipping_info(shipping_data)
      Watir::Wait.until { address.present? }
      fill! shipping_data
      b.scroll.to :top
      postal.click
      b.send_keys :tab
    end

    def fill_payment_info(card_info)
      Watir::Wait.until { card_number.present? }
      enter_credit_card(card_info.delete(:card_number))
      fill! card_info
      use_saved_shipping.fire_event :click
      continue_to_review_order
    end

    def enter_credit_card(card_num)
      card_num.scan(/.{1,4}/).each do |num|
        card_number.send_keys num
      end
    end
  end
end
