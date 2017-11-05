# encoding: utf-8

require 'forwardable'

class User
  extend Forwardable

  attr_accessor :email, :terms, :url,
                :newsletter, :client, :create, :form, :first_name,
                :last_name, :address_data, :payment_data, :product, :qty,
                :shipping_data, :search_data, :single_brand, :multi_brand,
                :invalid_term, :single_name,
                :phone, :optimum, :account_details, :password_data,
                :terms_unchecked, :valid_info, :fname_less_than_2_chars, :fname_invalid,
                :lname_less_than_2_chars, :lname_invalid, :email_invalid, :optimum_invalid,
                :optimum_empty, :multi_color, :multi_size, :regular, :chanel_multi_color,
                :chanel_multi_size, :chanel_regular, :address_invalid, :city_invalid,
                :postal_invalid, :phone_invalid, :fname_new, :fname_has_digit,
                :account_password, :new_password, :confirm_new_password, :conf_password_no_match,
                :conf_password_blank, :new_password_short, :new_password_has_no_digit, :password_blank,
                :password_invalid, :email_new, :super_multi_color, :multi_image, :fb_url, :twitter_url,
                :pinterest_url, :hst_on, :regular_price

  def_delegators :@password_data, :password, :confirm_password, :new_password, :confirm_new_password
  def_delegators :@address_data, :address_form
  def_delegators :@payment_data, :visa, :amex, :master, :pcf, :card_data,
                                 :visa_info, :amex_info, :master_info, :pcf_info

  def initialize
    @email = generate_email
  end

  def generate_email
    SecureRandom.hex(8) << '.itccrbgf@mailosaur.io'
  end

  def generate_name(length = 8)
    ('a'..'z').to_a.sample(length).join
  end

  def generate_credentials
    { email: generate_email, password: generate_password }
  end

  def create_account(bool)
    return unless bool
    raise('url must be provided') unless url
    @client = BbRuby::Client.new(base_url: url)
    client.create_account(username: email, password: password)
  end

  def add_item_to_cart(product, qty = 1)
    client.add_item_to_cart(product, qty)
  end

  def add_shipping_address(data)
    client.add_shipping_address(data)
  end
end
