require_relative 'base/password'

Fabricator(:password) do
  after_build do |obj|
    obj.password = obj.generate_password
    obj.confirm_password = obj.password
    obj.new_password = obj.generate_password
    obj.confirm_new_password = obj.new_password
    obj.update_form(password: obj.password, confirm_password: obj.confirm_password)
  end
end

Fabricator(:greater_than_64_no_special_no_numeric, from: :password) do
  after_build do |obj|
    obj.password = 'LHQFMSSCPUYIIAGBIQCWGBWXSSXRVTTRETXUYLRBBCMWIUVXBXUSDFJVVQUWDFGP'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_64_special_no_numeric, from: :password) do
  after_build do |obj|
    obj.password = 'LHQFMSSCPUYIIAGBIQCWGBWXSSXRVTTRETXUYLRBBCMWIUVXBXUSDFJVVQUWDFGP!'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_64_numeric_no_special,from: :password) do
  after_build do |obj|
    obj.password = 'LHQFMSSCPUYIIAGBIQCWGBWXSSXRVTTRETXUYLRBBCMWIUVXBXUSDFJVVQUWDFGP1'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_64_numeric_special, from: :password) do
  after_build do |obj|
    obj.password = 'LHQFMSSCPUYIIAGBIQCWGBWXSSXRVTTRETXUYLRBBCMWIUVXBXUSDFJVVQUWDFGP1!'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_8_no_special_no_numeric, from: :password) do
  after_build do |obj|
    obj.password = 'UFVJNIFHQK'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_8_special_no_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFVJNIFHQK!'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_8_no_special_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFVJNIFHQK1'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:greater_than_8_special_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFVJNIFHQK1!'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end


Fabricator(:less_than_8_no_special_no_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFV'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:less_than_8_special_no_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFV!'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:less_than_8_no_special_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFV1'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:less_than_8_special_numeric,from: :password) do
  after_build do |obj|
    obj.password = 'UFV1!'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end

Fabricator(:invalid_special_char,from: :password) do # Invalid special char message(allowed !@#$%^&*) expand on this?
  after_build do |obj|
    obj.password = 'UFVJNIFHQK~'
    obj.update_form(password: obj.password, confirm_password: obj.password)
  end
end