# encoding: utf-8
require_relative '../regions/product_finder'

module BB
  class ProductFinderVIC < Ferris::Page
    include BB::Helpers
    partial_url { '/productfinder-vic' }
    rgn(:product, BB::ProductFinder)     { b.divs(class: ['product']) }
    el(:radio_buttons)           { b.divs(class: ['iradio_square']) }
    # gender
    el(:woman)                   { b.label(xpath: '//label[@for="gender1"]') }
    el(:man)                     { b.label(xpath: '//label[@for="gender2"]') }
    # age
    el(:under_25)                { b.label(xpath: '//label[@for="age1"]') }
    el(:between_25_34)           { b.label(xpath: '//label[@for="age2"]') }
    el(:between_35_44)           { b.label(xpath: '//label[@for="age3"]') }
    el(:between_45_54)           { b.label(xpath: '//label[@for="age4"]') }
    el(:between_55_64)           { b.label(xpath: '//label[@for="age5"]') }
    el(:above_65)                { b.label(xpath: '//label[@for="age6"]') }
    # concerns
    el(:pimples)                 { b.label(xpath: '//label[@for="skinConcern1"]') }
    el(:shine)                   { b.label(xpath: '//label[@for="skinConcern2"]') }
    el(:spots)                   { b.label(xpath: '//label[@for="skinConcern3"]') }
    el(:sensation)               { b.label(xpath: '//label[@for="skinConcern4"]') }
    el(:aging)                   { b.label(xpath: '//label[@for="skinConcern5"]') }
    el(:wrinkles)                { b.label(xpath: '//label[@for="skinConcern6"]') }
    el(:density)                 { b.label(xpath: '//label[@for="skinConcern7"]') }
    # skin reaction
    el(:reaction_yes)            { b.label(xpath: '//label[@for="previousReaction1"]') }
    el(:reaction_no)             { b.label(xpath: '//label[@for="previousReaction2"]') }
    # redness
    el(:redness_yes)             { b.label(xpath: '//label[@for="rednessConcern1"]') }
    el(:redness_no)              { b.label(xpath: '//label[@for="rednessConcern2"]') }
    # favourite texture
    el(:water)                   { b.label(xpath: '//label[@for="favoriteTexture1"]') }
    el(:foam)                    { b.label(xpath: '//label[@for="favoriteTexture2"]') }
    el(:gel)                     { b.label(xpath: '//label[@for="favoriteTexture3"]') }
    el(:milk)                    { b.label(xpath: '//label[@for="favoriteTexture4"]') }
    # button
    el(:submit_form)             { b.button(id: 'submit') }
    # results
    el(:out_of_stock_msg)        { b.div(class: ['out-of-stock']) }
    el(:copyright)               { b.div(class: ['copy']) }

    def search_vic
      woman.click
      between_25_34.click
      spots.click
      reaction_no.click
      redness_no.click
      foam.click
      submit_form.click
    end

    def add_vic_to_cart(index)
      product[index].add_product_to_cart
    end

    def only_one_value_can_be_selected
      woman.click
      man.click
      radio_buttons[0].attribute_value('class').include?('checked') ? false : true
    end
  end
end
