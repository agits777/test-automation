# encoding: utf-8

module BB
  class Registration < Ferris::Page
    partial_url { '/register' }

    el(:email)              { b.text_field(id: 'register.email') }
    el(:password)           { b.text_field(id: 'password') }
    el(:confirm_password)   { b.text_field(id: 'register.checkPwd') }
    el(:terms)              { b.checkbox(id: 'register.somestuff') }
    el(:newsletter)         { b.checkbox(id: 'register.somestuff2') }
    el(:create_account_btn) { b.button(class: 'email-subscription-btn') }
    el(:privacy_policy_link){ b.link(href: '/privacypolicy')}
    el(:terms_of_use_link)  { b.link(href: '/termsofuse')}

    # Error Messages
    el(:help_block)         { b.div(class: 'help-block')}
    el(:pwd_error)          { help_block.span(id: 'pwd.errors') }
    el(:email_error)        { help_block.span(id: 'email.errors') }
    el(:terms_error)        { help_block.span(id: 'termofuse.errors') }
    el(:email_address_error){b.label(xpath:'//label[@for="register.email" and @class="error"]')}
    el(:blank_pwd_error)    {b.label(xpath:'//label[@for="password" and @class="error"]')}
    el(:blank_confirm_pwd_error)  {b.label(xpath:'//label[@for="register.checkPwd" and @class="error"]')}
    el(:pwd_mismatch_error) { help_block.span(id: 'checkPwd.errors') }
   
    def fill_form(data)
      fill! data
    end

    def submit_form
      create_account_btn.click
    end

    def view_privacy_policy
      privacy_policy_link.click
      b.windows.last.use
    end

    def view_terms_of_use
      terms_of_use_link.click
      b.windows.last.use
    end
    
    def submit_registration_form(data)
      fill_form(data)
      submit_form
    end
  end
end
