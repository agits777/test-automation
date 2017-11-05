# encoding: utf-8

class Password
  attr_accessor :password, :confirm_password, :old_password, :form, :new_password, :confirm_new_password

  def update_form(password:, confirm_password:)
    @form = { password: password, confirm_password: confirm_password }
  end

  def generate_password(length = 8)
    # @old_password     = password
    SecureRandom.hex(length)
  end
end
