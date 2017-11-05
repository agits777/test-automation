# encoding: utf-8

module BB
  class AccountPayment < Ferris::Page
    include BB::Helpers

    partial_url { '/my-account/payment-details' }

    # initial page
    el(:add_new_card_btn)         { b.button(class: ['add-card-btn']) }

    # payment info
    el(:save_new_card_btn)        { b.button(class: ['add-new-card-btn']) }
    el(:cancel_link)              { b.link(class: ['cancel-add-new-card']) }
    el(:edit_link)                { b.link(class: ['payment-info-edit-card']) }
    el(:delete_link)              { b.link(class: ['remove-card-btn']) }
    el(:add_new_address_link)     { b.link(class: ['add-new-address']) }
    el(:update_card_btn)          { b.button(class: ['update-card-btn']) }
    el(:cancel_update_card_link)  { b.link(class: ['cancel-edit-card-info']) }
    el(:visa_icon)                { b.img(class: ['visa-icon']) }
    el(:mastercard_icon)          { b.img(class: ['mastercard-icon']) }
    el(:pcf_icon)                 { b.img(class: ['pcf-icon']) }
    el(:amex_icon)                { b.img(class: ['amex-icon']) }

    el(:name_on_card)             { b.text_field(id: 'accountHolderName') }
    el(:card_number)              { b.text_field(id: 'cardNumber') }
    el(:expiration_month)         { b.select(id: 'cardExpirationMonth') }
    el(:expiration_year)          { b.select(id: 'cardExpirationYear') }
    el(:cvv)                      { b.text_field(id: 'cardSecurityCode') }
    el(:cards)                    { b.divs(class: 'card-info') }

    # address info
    el(:select_address)           { b.select(id: 'selectedAddress') }
    el(:country)                  { b.select(id: 'country') }
    el(:address)                  { b.text_field(id: 'address') }
    el(:apt)                      { b.text_field(id: 'apt') }
    el(:city)                     { b.text_field(id: 'city') }
    el(:province)                 { b.select(id: 'canadaProvince') }
    el(:postal)                   { b.text_field(id: 'canadaPostalcode') }

    # card removal dialog
    el(:del_dialog) { b.div(id: 'overlay-container-wrapper') }
    el(:close_dialog)             { del_dialog.link(class: ['icon-cross2']) }
    el(:delete_card_btn)          { del_dialog.button(class: ['confirm-delete']) }
    el(:cancel_delete_btn)        { del_dialog.button(class: ['cancel-delete']) }

    # error messages
    el(:name_err)                 { b.label(xpath: '//div[contains(@class,"name-on-card")]/label[@class="error"]') }
    el(:cc_err)                   { b.label(xpath: '//div[contains(@class,"card-number")]/label[@class="error"]') }
    el(:month_err)                { b.label(xpath: '//div[contains(@class,"card-expiration-month")]/label[@class="error"]') }
    el(:year_err)                 { b.label(xpath: '//div[contains(@class,"card-expiration-year")]/label[@class="error"]') }
    el(:ccv_err)                  { b.label(xpath: '//div[contains(@class,"card-security-code")]/label[@class="error"]') }
    el(:month_err)                { b.label(xpath: '//div[contains(@class,"card-expiration-month")]/label[@class="error"]') }
    el(:address_err)              { b.label(xpath: '//div[contains(@class,"address")]//label[@class="error"]') }
    el(:city_err)                 { b.label(xpath: '//div[contains(@class,"city")]//label[@class="error"]') }
    el(:province_err)             { b.label(xpath: '//div[contains(@class,"province")]//label[@class="error"]') }
    el(:postal_err)               { b.label(xpath: '//div[contains(@class,"postalcode")]//label[@class="error"]') }
    el(:updated_name)             { b.label(xpath: '//div[contains(@class,"postalcode")]//label[@class="error"]') }

    el(:save_transition)          { b.form(class: ['save-new-card-info']) }
    el(:edit_transition)          { b.form(class: ['edit-card-info-form']) }

    # initial page
    def add_first_card
      add_new_card_btn.click
      save_form_transition
    end

    # add new card page
    def save_card
      save_new_card_btn.click
    end

    def cancel_new_card
      cancel_link.click
      save_form_transition
    end

    def add_new_address
      add_new_address_link.click
    end

    # saved cards page
    def count_of_cards
      cards.count
    end

    def edit_existent_card
      edit_link.click
      edit_form_transition
    end

    def delete_existent_card
      b.scroll.to :top
      delete_link.click
    end

    # card removal dialog
    def close_dialog
      close_dialog.click
    end

    def delete_saved_card
      b.scroll.to :top
      delete_card_btn.click
    end

    def cancel_deletion
      cancel_delete_btn.click
    end

    # update existent card
    def update_card
      update_card_btn.click
    end

    def cancel_update
      cancel_update_card_link.click
    end

    def enter_name(name)
      name_on_card.send_keys name
    end

    def fill_payment(card_info)
      card_data = card_info.clone
      enter_credit_card(card_data.delete(:card_number))
      fill! card_data
    end

    def fill_address(data)
      fill! data
    end

    def submit_payment_form(address_info:, card_info:)
      fill_payment(card_info)
      fill_address(address_info)
      save_card
    end

    def save_form_transition
      Watir::Wait.until { save_transition.attribute_value('style').include?('overflow: hidden') }
      Watir::Wait.while { save_transition.attribute_value('style').include?('overflow: hidden') }
    end

    def edit_form_transition
      Watir::Wait.until { edit_transition.attribute_value('style').include?('overflow: hidden') }
      Watir::Wait.while { edit_transition.attribute_value('style').include?('overflow: hidden') }
    end
  end
  end