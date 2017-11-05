require_relative 'base/user'

# Call Fabricate.build(:user, create: true, url: @session.url)
# to create a registered user

Fabricator(:user) do
  first_name    { 'Ferris'  }
  last_name     { 'Bueller' }
  phone         { '6135550148' }
  optimum       { '999991000'}
  password_data(fabricator: :password)
  address_data(fabricator: :address)
  payment_data(fabricator: :payment)
  single_brand  { 'DIOR' }
  multi_brand   { 'DIOR,LIERAC' }
  invalid_term  { 'beef' }
  single_name   { 'Lip' }

  after_build do |obj|
    obj.form = { email: obj.email, password: obj.password }
    obj.create_account(create)
  end
end

Fabricator(:login_flow, from: :user) do
  terms      { true  }
  newsletter { false }
  fb_url        {'https://www.facebook.com/shoppersdrugmart'}
  twitter_url   {'https://twitter.com/ShopprsDrugMart'}
  pinterest_url {'https://www.pinterest.ca/shopprsdrugmart/'}

  after_build do |obj|
    obj.form.merge!(confirm_password: obj.confirm_password,
                    terms: obj.terms, newsletter: obj.newsletter)
  end
end

Fabricator(:registration_flow, from: :user) do
  terms      { true }
  newsletter { false }

  after_build do |obj|
    types_of_passwords = %w[
      greater_than_64_no_special_no_numeric
      greater_than_64_special_no_numeric
      greater_than_64_numeric_no_special
      greater_than_64_numeric_special
      greater_than_8_no_special_no_numeric
      greater_than_8_special_no_numeric
      greater_than_8_no_special_numeric
      greater_than_8_special_numeric
      less_than_8_no_special_no_numeric
      less_than_8_special_no_numeric
      less_than_8_no_special_numeric
      less_than_8_special_numeric
      invalid_special_char
    ]

    types_of_passwords.each do |type|
      self.class.send(:attr_accessor, type.to_s)
      obj.instance_variable_set("@#{type}", obj.form.merge(Fabricate(type.to_s).form).merge(terms: obj.terms, newsletter: obj.newsletter))
    end

    obj.form.merge!(confirm_password: obj.confirm_password,
                    terms: obj.terms, newsletter: obj.newsletter)
    obj.terms_unchecked = form.merge(terms: false)
  end
end

Fabricator(:newsletter_flow, from: :user) do
  terms { true }

  after_build do |obj|
    obj.valid_info = {
      first_name: obj.first_name,
      last_name: obj.last_name,
      email: obj.email,
      terms: obj.terms
    }
    obj.fname_less_than_2_chars = obj.valid_info.merge(first_name: 'a')
    obj.fname_invalid           = obj.valid_info.merge(first_name: '%$%')
    obj.lname_less_than_2_chars = obj.valid_info.merge(last_name: 'a')
    obj.lname_invalid           = obj.valid_info.merge(last_name: '%$%')
    obj.email_invalid           = obj.valid_info.merge(email: 'test')
  end
end

Fabricator(:newsletter_modal_flow, from: :user) do
  terms { true }

  after_build do |obj|
    obj.valid_info = {
        email: obj.email,
        terms: obj.terms
    }
    obj.email_invalid = obj.valid_info.merge(email: 'test')
  end
end

Fabricator(:checkout_flow, from: :user) do
  multi_color        { '3348900898844' }
  hst_on             { 1.13 }
  super_multi_color  { '3380814426218' }
  multi_size         { '3348900012189' }
  regular            { '3605970859299' }
  regular_price      { 71 }
  multi_image        { '3337872412868' }

  chanel_multi_color {'3145891632200'}
  chanel_multi_size  {'3145891073607'}
  chanel_regular     {'3145891431803'}
  qty                { 1 }

  after_build do |obj|
    obj.address_form.merge!(first_name: obj.first_name, last_name: obj.last_name, email: obj.email, phone: obj.phone)
    if create
      add_item_to_cart(send(obj.product), obj.qty)
      obj.address_form.delete(:email)
    end
  end
end

Fabricator(:account_email_flow, from: :user) do
  after_build do |obj|
    obj.account_details = {
      first_name: obj.first_name,
      last_name:  obj.last_name,
      email:      obj.email
    }
    obj.fname_invalid = obj.account_details.merge(first_name: 'a1')
    obj.fname_less_than_2_chars = obj.account_details.merge(first_name: 'a')
    obj.lname_invalid = obj.account_details.merge(last_name: 'a1')
    obj.lname_less_than_2_chars = obj.account_details.merge(last_name: 'a')
    obj.email_invalid = obj.account_details.merge(email: 'email#email.com')
    obj.email_new = obj.account_details.merge(email: 'new@new.com')
  end
end

Fabricator(:account_password_flow, from: :user) do
  after_build do |obj|
    obj.account_password = {
        password: obj.password,
        new_password: obj.new_password,
        confirm_new_password: obj.confirm_new_password
    }
    obj.conf_password_no_match = obj.account_password.merge(confirm_new_password: 'a3223227')
    obj.conf_password_blank = obj.account_password.merge(confirm_new_password: '')
    obj.new_password_short = obj.account_password.merge(new_password: 'asdfgh1')
    obj.new_password_has_no_digit = obj.account_password.merge(new_password: 'asdfghjk')
    obj.password_blank = obj.account_password.merge(password: '')
    obj.password_invalid = obj.account_password.merge(password: 'asdfghj1')
  end
end

Fabricator(:shipping_flow, from: :user) do
  terms { true }

  after_build do |obj|
    obj.valid_info = {
        first_name: obj.first_name,
        last_name: obj.last_name
    }
    obj.valid_info.merge!(obj.address_form)
    obj.fname_less_than_2_chars = obj.valid_info.merge(first_name: 'a')
    obj.fname_invalid           = obj.valid_info.merge(first_name: '%$%')
    obj.fname_new               = obj.valid_info.merge(first_name: 'Newname')
    obj.lname_less_than_2_chars = obj.valid_info.merge(last_name: 'a')
    obj.lname_invalid           = obj.valid_info.merge(last_name: '%$%')
    obj.address_invalid         = obj.valid_info.merge(address: '123')
    obj.city_invalid            = obj.valid_info.merge(city: 'a')
    obj.postal_invalid          = obj.valid_info.merge(postal: 'm5abh7')
    obj.phone_invalid           = obj.valid_info.merge(phone: 'abc')
  end
end

Fabricator(:search_data, from: :user) do
  after_build do |obj|
    obj.search_data = { single_brand: obj.single_brand, multi_brand: obj.multi_brand,
                        invalid_term: obj.invalid_term, single_name: obj.single_name }
  end
end
