# encoding: utf-8

module BB
  class StoresInfo < Ferris::Region
    el(:distance)           { b.divs(class: ['store-distance']) }
    el(:store_details_lnk)  { b.links(class: ['store-details-link']) }
    el(:get_directions_lnk) { b.links(class: ['get-directions']) }
    el(:store_phone)        { b.divs(class: ['store-phone-no']) }
    el(:store_open_time)    { b.divs(class: ['store-open-time']) }
    el(:store_name)         { b.divs(class: ['store-name']) }
    el(:store_address)      { b.ps(class: ['store-address']) }

  end
end
