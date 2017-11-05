require_relative 'base/payment'

Fabricator(:payment) do
  visa   { '4111111111111111' }
  amex   { '378282246310005' }
  master { '5555555555554444' }
  pcf    { '5181268342675918' }

  card_data do
    {
      name_on_card: 'Ferris Bueller',
      expiration_month: '12',
      expiration_year: '2020',
      cvv: '123'
    }
  end

  after_build do |obj|
    obj.visa_info   = card_data.merge(card_number: obj.visa)
    obj.amex_info   = card_data.merge(card_number: obj.amex)
    obj.master_info = card_data.merge(card_number: obj.master)
    obj.pcf_info    = card_data.merge(card_number: obj.pcf)
  end
end
