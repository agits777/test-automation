# encoding: utf-8

module BB
  class AccountShipping < Ferris::Page
    partial_url { '/my-account/address-book' }

    # initial page
    el(:add_new_address_btn)      { b.button(class: ['add-account-add-btn']) }
    el(:save_new_address_btn)     { b.button(class: ['add-address-info-btn']) }
    el(:update_address_btn)       { b.button(class: ['edit-address-info-btn']) }
    el(:edit_address_link)        { b.link(class: ['edit-address']) }
    el(:remove_address_link)      { b.link(class: ['remove-address']) }
    el(:close_dialog_icon)        { b.link(class: ['icon-cross2']) }
    el(:confirm_deletion_btn)     { b.button(class: ['confirm-delete-address']) }
    el(:cancel_removal_btn)       { b.button(class: ['cancel-delete']) }
    el(:address_save_transition)  { b.form(class: ['add-addresses']) }
    el(:address_edit_transition)  { b.form(class: ['edit-addresses']) }
    el(:addresses)                { b.links(class: ['edit-address']) }

    # messages
    el(:first_name_err_msg)       { b.label(xpath: '//label[@for="firstName"]') }
    el(:last_name_err_msg)        { b.label(xpath: '//label[@for="lastName"]') }
    el(:postal_err_msg)           { b.label(xpath: '//div[contains(@class,"postalcode")]/label[@class="error"]') }
    el(:address_err_msg)          { b.label(xpath: '//div[contains(@class,"address")]/label[@class="error"]') }
    el(:city_err_msg)             { b.label(xpath: '//div[contains(@class,"city")]/label[@class="error"]') }
    el(:province_err_msg)         { b.label(xpath: '//div[contains(@class,"province")]//label[@class="error"]') }
    el(:phone_err_msg)            { b.label(xpath: '//div[contains(@class,"phone")]//label[@class="error"]') }
    el(:name_label)               { b.p(xpath: '//p[@class="address-name"]') }

    def add_form_configuration
      class << self
        el(:first_name)           { b.text_field(class: ['add-shipping-firstname']) }
        el(:last_name)            { b.text_field(class: ['add-shipping-lastname']) }
        el(:address)              { b.text_field(class: ['add-shipping-address']) }
        el(:apt)                  { b.text_field(class: ['add-shipping-apt']) }
        el(:city)                 { b.text_field(class: ['add-shipping-city']) }
        el(:province)             { b.select(class: ['add-shipping-province']) }
        el(:postal)               { b.text_field(class: ['add-shipping-postalcode']) }
        el(:phone)                { b.text_field(class: ['add-shipping-phoneno']) }
        el(:save_address_btn)     { b.button(class: ['add-address-info-btn']) }
        el(:cancel_link)          { b.link(class: ['cancel-add-new-address']) }
      end
    end

    def edit_form_configuration
      class << self
        el(:first_name)           { b.text_field(class: ['edit-shipping-firstname']) }
        el(:last_name)            { b.text_field(class: ['edit-shipping-lastname']) }
        el(:address)              { b.text_field(class: ['edit-shipping-address']) }
        el(:apt)                  { b.text_field(class: ['edit-shipping-apt']) }
        el(:city)                 { b.text_field(class: ['edit-shipping-city']) }
        el(:province)             { b.select(class: ['edit-shipping-province']) }
        el(:postal)               { b.text_field(class: ['edit-shipping-postalcode']) }
        el(:phone)                { b.text_field(class: ['edit-shipping-phoneno']) }
        el(:update_address_btn)   { b.button(class: ['edit-address-info-btn']) }
        el(:cancel_link)          { b.link(class: ['cancel-edit-address']) }
      end
    end

    def close_dialog
      close_dialog_icon.click
    end

    def count_of_addresses
      addresses.count
    end

    def confirm_address_removal
      confirm_deletion_btn.click
    end

    def remove_address
      remove_address_link.click
    end

    def cancel_address_removal
      cancel_removal_btn.click
    end

    def edit_address
      edit_form_configuration
      edit_address_link.click
      edit_form_transition
    end

    def cancel_add_address
      cancel_link.click
      save_form_transition
    end

    def cancel_update_address
      cancel_link.click
      edit_form_transition
    end

    def save_new_address
      save_address_btn.click
    end

    def update_address
      update_address_btn.click
      sleep 0.25
    end

    def submit_address_form(data)
      fill_address(data)
      # save_new_address
    end

    def update_account(data)
       edit_address
       submit_address_form(data)
      end

    def save_form_transition
      Watir::Wait.until { address_save_transition.attribute_value('style').include?('overflow: hidden') }
      Watir::Wait.while { address_save_transition.attribute_value('style').include?('overflow: hidden') }
    end

    def edit_form_transition
      Watir::Wait.until { address_edit_transition.attribute_value('style').include?('overflow: hidden') }
      Watir::Wait.while { address_edit_transition.attribute_value('style').include?('overflow: hidden') }
    end

    def fill_address(data)
      fill! data
    end

    def add_new_address
      add_form_configuration
      add_new_address_btn.click
      save_form_transition
    end
  end
end
