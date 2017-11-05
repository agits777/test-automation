# encoding: utf-8

module BB
  class OrderConfirmation < Ferris::Page
    partial_url { '/checkout/orderConfirmation' }

    el(:order_number)       { b.li(class: 'order-number') }
    el(:order_date)         { b.div(class: 'order-place-date-bold-text') }
    el(:confirmation_email) { b.div(class: 'order-place-email-bold-text') }
    el(:signup_btn)        { b.button(class: ['default-btn sign-up']) }
    el(:first_name_err)    { b.label(xpath: '//label[@for="firstname" and @class="error"]') }
    el(:last_name_err)     { b.label(xpath: '//label[@for="lastname" and @class="error"]') }
    el(:email_err)         { b.label(xpath: '//label[@for="email" and @class="error"]') }
    el(:terms_err)         { b.label(xpath: '//label[@for="terms-of-use" and @class="error"]') }
    el(:newsletter_header) { b.h2(xpath: '//div[@class="newsletter-header-text"]/h2')}
    el(:newsletter_terms)  { b.label(xpath: '//label[@for="accept" and contains(@class,"icheck-label")]')}
    el(:newsletter_addr)   { b.div(xpath: '//div[@class="row mailing-address"]')}
    el(:newsletter_form)   { b.form(xpath:'//form[@class="sign-up-form newsletter"]')}
    el(:first_name)        { b.text_field(id: 'firstname')}
    el(:last_name)         { b.text_field(id: 'lastname')}
    el(:email)             { b.text_field(id: 'email')}
    el(:terms)             { b.checkbox(id:'accept')}

    def submit_form
      signup_btn.click
    end

    def fill_form(data)
      fill! data
    end

    def focus_optimum
      optimum.click
    end

    def submit_newsletter_form(data)
      fill_form(data)
      submit_form
    end
  end
end
