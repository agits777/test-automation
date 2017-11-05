# encoding: utf-8
require_relative '../regions/items'

module BB
  class PDP < Ferris::Page
    partial_url { '/Categories' }

    rgn(:item, BB::Items)     { b.lis(class: 'product-tile') }
    el(:add_to_cart_btn)      { b.input(xpath: '//div[@id="product-detail-wrapper"]//input[@data-url="/cart/add"]') }
    el(:color_dropdown)       { b.select(class: ['color-dropdown']) }
    el(:qty_dropdown)         { b.select(class: ['qty-dropdown']) }
    el(:details_link)         { b.link(class: ['view-detail-link']) }
    el(:info_details_link)    { b.link(class: ['info-link']) }
    el(:details_nav)          { b.div(id: 'secondary-nav') }
    el(:details_add_to_bag)   { details_nav.button(class: ['cta-add']) }
    el(:discover_more_link)   { details_nav.link(id: 'id_discover-more') }
    el(:fav_link)             { b.span(xpath: '//span[contains(.,"Favourite")]') }
    el(:swatches)             { b.divs(class: ['swatches-group']) }
    el(:sample_popup)         { b.div(id: 'overlay-container-wrapper') }
    el(:close_popup)          { sample_popup.link(class: ['icon-closebtn']) }
    el(:item_limit_msg)       { b.div(xpath: '//div[@class="error-msg inventory"]') }
    el(:sample_limit_msg)     { b.div(xpath: '//div[@class="sample-info sample-error"]') }
    el(:img_thumb)            { b.div(class: ['product-image-wrapper']) }
    el(:zoomed_img)           { b.div(id: 'product-image-zoom-wrapper') }
    el(:close_zoomed_img)     { b.link(class: ['close-zoom-image']) }
    el(:thumbs)               { b.divs(class: ['thumb']) }
    el(:sample_buttons)       { b.buttons(class: ['add-sample']) }
    el(:dots)                 { b.divs(class: ['owl-dot']) }
    el(:sample_selected)      { b.divs(class: ['selected-true']) }
    el(:sample_not_selected)  { b.div(class: ['selected-false']) }
    el(:fav_link)             { b.link(class: ['favourite-link']) }
    el(:breadcrumbs)          { b.ul(class: ['breadcrumb']) }
    el(:brand_name_qv)        { b.div(class: ['item-brand-name']) }
    el(:slides)               { b.ul(id: 'large-viewport-pdp-slides') }
    el(:thumbnail)            { slides.lis(class: ['thumbnail']) }
    el(:color_dropdown)       { b.select(class: ['color-dropdown']) }
    el(:product_variation)    { b.div(class: ['product-color-variation']) }
    el(:scroll_panel)         { b.div(id: 'scroll-slider-thumbnail') }

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

    def click_breadcrumb(number)
      @site.b.scroll.to :top
      @link_text = breadcrumbs.links[number].text.split(/ |\_|\-/).map(&:capitalize).join(" ")
      breadcrumbs.links[number].click
    end

    def add_product_to_cart
      add_to_cart_btn.click
    end

    def view_details
      details_link.click
    end

    def close_sample_popup
      close_popup.click
    end

    def zoom_pdp_image
      img_thumb.click
    end

    def close_zoomed_image
      close_zoomed_img.click
    end

    def add_from_details
      details_add_to_bag.click
    end

    def mouse_hover_thumb(number)
      thumbs[number].hover
    end

    def add_remove_sample(number)
      sample_buttons[number].click
    end

    def click_carousel_dot(number, expected_thumb)
      dots[number].click
      thumbs[expected_thumb].wait_until_present
    end

    def add_favourite
      b.scroll.to :center
      fav_link.click
    end

    def open_qv(index: 0)
      item[index].hover_product
      item[index].qv_click
    end

    def click_image_thumbnails
      scroll_panel.wait_until_present
      (0..5).each do |i|
        thumbnail[i].click
      end
    end

    def select_color(color)
      fill! color_dropdown: color
    end

  end
end