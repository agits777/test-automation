# encoding: utf-8

module BB
  class CartPage < Ferris::Page
    include BB::Helpers

    partial_url { '/cart' }

    el(:qty_dropdown)         { b.select(class: ['select-qty']) }
    el(:edit_qty_link)        { b.link(class: ['product-edit']) }
    el(:update_qty_btn)       { b.button(class: ['update-product']) }
    el(:select_samples_btn)   { b.button(id: 'select-sample-btn') }
    el(:colour_dropdown)      { b.select(class: ['with-swatches']) }
    el(:curr_total)           { b.div(xpath: '//div[contains(@class,"cart-product-price")]') }
    el(:items_total)          { b.div(xpath: '//div[contains(@class,"order-summary-items")]') }
    el(:sub_total)            { b.div(xpath: '//div[contains(@class,"order-summary-value")]') }
    el(:item_id_in_cart)      { b.divs(xpath: '//div[contains(@class,"cart-product-item-number")]') }
    el(:fav_link)             { b.link(class: ['favourite-link']) }
    el(:remove_link)          { b.links(class: ['removeItem']) }
    el(:apply_promo_link)     { b.link(class: ['apply-promo-link']) }
    el(:sample_buttons)       { b.buttons(class: ['add-sample']) }
    el(:thumbs)               { b.divs(class: ['thumb']) }
    el(:sample_selected)      { b.divs(class: ['selected-true']) }
    el(:sample_not_selected)  { b.div(class: ['selected-false']) }
    el(:sample_message)       { b.span(xpath: '//span[@id="global-message-text"]') }

    def initializer
      elements = {
        desktop: { unit_price: browser.div(xpath: '//div[contains(@class,"item-product-price")]'),
                   mini_cart_count: browser.span(xpath: '//span[@id="js-cart-item-count-b1"]') },
        else:    { unit_price: browser.div(xpath: '//div[contains(@class,"pdp-info-product-price")]'),
                   mini_cart_count: browser.span(xpath: '//span[@id="js-cart-item-count-b2-b3"]') }
      }

      data = site.args[:session].breakpoint == :desktop ? elements[:desktop] : elements[:else]

      data.each do |method_name, value|
        define_singleton_method(method_name) do |*_args|
          value
        end
      end
      end

    def mouse_hover_thumb(number)
      thumbs[number].hover
    end

    def add_remove_sample(number)
      sample_buttons[number].click
    end

    def add_favourite
      fav_link.click
    end

    def remove_items(number)
      remove_link[number].click
    end

    def edit_qty
      edit_qty_link.click
    end

    def update_qty
      update_qty_btn.click
    end

    def select_samples
      select_samples_btn.click
    end
  end
  end