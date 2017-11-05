# encoding: utf-8

module BB
  class AccountSettings < Ferris::Page
    partial_url { '/my-account' }

    # my account initial page
    el(:edit_account_link)            { b.link(class: ['edit-account']) }
    el(:change_password_link)         { b.link(class: ['change-password']) }
    el(:email_label)                  { b.p(xpath: '//p[@class="sub-heading-value updated-email"]') }

    # edit account form
    el(:account_panel)                { b.div(class: ['edit-detail']) }
    el(:cancel_edit_account_link)     { account_panel.link(class: ['edit-account-detail-cancel']) }
    el(:save_account_btn)             { account_panel.button(class: ['edit-save-btn']) }
    el(:first_name)                   { account_panel.text_field(id: 'firstname') }
    el(:last_name)                    { account_panel.text_field(id: 'lastname') }
    el(:email)                        { account_panel.text_field(id: 'email') }

    # edit password form
    el(:password_panel)               { b.div(class: ['edit-password-panel']) }
    el(:password)                     { password_panel.text_field(id: 'password') }
    el(:new_password)                 { password_panel.text_field(id: 'current-password') }
    el(:confirm_new_password)         { password_panel.text_field(id: 'confirm-password') }
    el(:save_new_password_btn)        { password_panel.button(class: ['edit-save-btn']) }
    el(:cancel_save_new_password_link){ password_panel.link(class: ['change-password-cancel']) }

    # account form messages
    el(:firstname_err_msg)            { account_panel.label(xpath: '//label[@for="firstname" and @class="error"]') }
    el(:lastname_err_msg)             { account_panel.label(xpath: '//label[@for="lastname" and @class="error"]') }
    el(:email_err_msg)                { account_panel.label(xpath: '//label[@for="email" and @class="error"]') }

    # password form messages
    el(:current_password_blank_msg)   { password_panel.label(xpath: '//label[@for="password" and @class="error"]') }
    el(:password_err_msg)             { password_panel.span(class: ['confirm-error-msg']) }
    el(:confirm_password_blank_msg)   { password_panel.label(xpath: '//label[@for="confirm-password" and @class="error"]') }
    el(:current_password_invalid_msg) { password_panel.span(xpath: '//span[@class="password-error-msg currentPassword-error-msg error"]') }
    el(:confirm_password_invalid_msg) { password_panel.span(xpath: '//span[@class="confirm-error-msg checkNewPassword-error-msg error"]') }
    el(:new_password_error_msg)       { password_panel.label(xpath: '//label[@for="current-password" and @class="error"]') }

    # forms transition elements
    el(:edit_transition)              { b.div(class: ['edit-account-panel']) }
    el(:password_transition)          { b.div(class: ['edit-password-panel']) }

    def fill_form(data)
      fill! data
    end

    # my account initial page
    def edit_account
      edit_account_link.click
      edit_form_transition
    end

    def change_password
      b.scroll.to :bottom
      change_password_link.click
      password_form_transition
    end

    # edit account form
    def cancel_edit_account
      cancel_edit_account_link.click
      edit_form_transition
    end

    def save_changes
      b.scroll.to :bottom
      save_account_btn.click
    end

    # edit password form
    def save_password
      b.scroll.to :bottom
      save_new_password_btn.click
    end

    def cancel_save_password
      cancel_save_new_password_link.click
      password_form_transition
    end

    def wait_for_wrong_password_message
      current_password_blank_msg.wait_until_present
    end

    def edit_form_transition
      Watir::Wait.until { edit_transition.attribute_value('style').include?('overflow: hidden') }
      Watir::Wait.while { edit_transition.attribute_value('style').include?('overflow: hidden') }
    end

    def password_form_transition
      Watir::Wait.until { password_transition.attribute_value('style').include?('overflow: hidden') }
      Watir::Wait.while { password_transition.attribute_value('style').include?('overflow: hidden') }
    end
  end
end
