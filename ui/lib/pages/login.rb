# encoding: utf-8

module BB
  class Login < Ferris::Page
    partial_url { '/login' }

    el(:email)              { b.text_field(id: 'j_username') }
    el(:password)           { b.text_field(id: 'j_password') }
    el(:sign_in_btn)        { b.button(id: 'login-submit') }
    el(:create_account_btn) { b.link(href: '/register') }
    el(:guest_checkout_btn) { b.button(class: ['checkout-guest-user-login-btn']) }

    def fill_form(data)
      fill! data
    end

    def submit_form
      sign_in_btn.click
    end

    def submit_login_form(data)
      fill_form(data)
      submit_form
    end

    def guest_checkout
      guest_checkout_btn.click
    end
  end
end