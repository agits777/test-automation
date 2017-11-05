# encoding: utf-8

class Payment
  attr_accessor :visa, :amex, :master, :pcf, :card_data,
                :visa_info, :amex_info, :master_info, :pcf_info
end
