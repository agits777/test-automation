# encoding: utf-8

module BB
  class Newsletter < Ferris::Page
    partial_url { '/subscribe/newsletter-signup' }

    el(:first_name)        { b.text_field(id: 'firstname')}
    el(:last_name)         { b.text_field(id: 'lastname')}
    el(:email)             { b.text_field(id: 'email')}
    el(:terms)             { b.checkbox(id:'accept')}
    el(:signup_btn)        { b.button(class: ['default-btn sign-up']) }
    el(:first_name_err)    { b.label(xpath: '//label[@for="firstname" and @class="error"]') }
    el(:last_name_err)     { b.label(xpath: '//label[@for="lastname" and @class="error"]') }
    el(:email_err)         { b.label(xpath: '//label[@for="email" and @class="error"]') }
    el(:terms_err)         { b.label(xpath: '//label[@for="terms-of-use" and @class="error"]') }
    el(:newsletter_header) { b.h2(xpath: '//div[@class="newsletter-header-text"]/h2')}
    el(:newsletter_terms)  { b.label(xpath: '//label[@for="accept" and contains(@class,"icheck-label")]')}
    el(:newsletter_addr)   { b.div(xpath: '//div[@class="row mailing-address"]')}
    el(:newsletter_form)   { b.form(xpath:'//form[@class="sign-up-form newsletter"]')}

    # Newsletter modal dialog
    el(:dialog)            { b.div(class: 'newsletter-overlay-signup') }

    def dialog_present
      dialog.wait_until_present
    end

    def dialog_not_present
      sleep 5
      dialog.present? ? false : true
    end

    def submit_form
      signup_btn.click
    end

    def fill_form(data)
      fill! data
    end

    def submit_newsletter_form(data)
      fill_form(data)
      submit_form
    end

    def close_modal
      dialog.wait_until_present
      @site.b.send_keys :escape
    end
  end
end
