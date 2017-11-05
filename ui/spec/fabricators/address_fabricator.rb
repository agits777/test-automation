require_relative 'base/address'

Fabricator(:address) do
  address  { '99 Atlantic Ave' }
  apt      { '123' }
  city     { 'Toronto' }
  province { 'CA-ON' }
  postal   { 'M6K 3J8' }
  phone    { '6135550148' }

  after_build do |obj|
    obj.address_form = { address: obj.address, apt: obj.apt, city: obj.city,
                         province: obj.province, postal: obj.postal }
  end
end
